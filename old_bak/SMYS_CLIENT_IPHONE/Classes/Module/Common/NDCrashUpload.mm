/*
 *  NDCrashUpload.mm
 *  DragonDrive
 *
 *  Created by jhzheng on 11-10-20.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#import "NDCrashUpload.h"
#import "PLCrashReporter.h"
#import "PLCrashReport.h"
#import "NSData+Base64Additions.h"
#import "NDMapMgr.h"


@interface NDCrashUpload(hidden)

- (void) send:(NSData*) data;

- (BOOL) GetCrashFile;

- (NSString*) GetCrashDir;

- (NSUInteger) GetFileSize: (NSString*) filename;

- (BOOL) CheckValidCrash: (NSString*) filename;

- (BOOL) DeleFile: (NSString*) filename;

@end

@implementation NDCrashUpload

NDCrashUpload *NDCrashUpload_Shared = nil;

+(id)alloc
{
	NDAsssert(NDCrashUpload_Shared == nil);
	return [super alloc];
}

-(id) init
{
	if( (self=[super init]) ) 
	{
		_curDealFile = nil;
		
		_hasDealBefore = false;
		
		_hasDataTransBefore = false;
	}
	
	return self;
}

-(void) dealloc
{
	if (_curDealFile) 
	{
		[_curDealFile release];
		_curDealFile = nil;
	}
	
	NDCrashUpload_Shared = nil;
	
	[super dealloc];
}

+ (id)Shared
{
	if (NDCrashUpload_Shared == nil)
	{
		NDCrashUpload_Shared = [[NDCrashUpload alloc] init];
	}
	
	return NDCrashUpload_Shared;
}

+ (void)PurgeShared
{
	if (NDCrashUpload_Shared)
	{
		[NDCrashUpload_Shared release];
		
		NDCrashUpload_Shared = nil;
	}
}

- (BOOL) HadDealBefore
{
	return _hasDealBefore;
}

- (BOOL) HadDataTransBefore
{
	return _hasDataTransBefore;
}

- (void) ResetDataTransBefore
{
	_hasDataTransBefore = NO;
}

- (NSUInteger) GetCrashReportSize
{
	if (![self GetCrashFile] || _curDealFile == nil)
		return 0;
	
	return [self GetFileSize:_curDealFile];
}

- (void) UploadCrashReport
{
	_hasDealBefore = true;
	
	if (_curDealFile == nil && [self GetCrashReportSize] == 0)
		return;
	 
	if (_curDealFile == nil || [self GetFileSize:_curDealFile] == 0)
		return;
		
	NSData *crashData = nil;
	NSError *outError;
	
	crashData = [NSData dataWithContentsOfFile: _curDealFile options: NSMappedRead error: &outError];
	
	if (crashData != nil) 
	{
		[self send: crashData];
	}
}

- (BOOL) EnableCrashCatch
{
	PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
	
	return [crashReporter enableCrashReporter];
}

#pragma mark 私有方法

- (void) send:(NSData*) data
{
	if (!data) return;
	
	SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
	testMsg.fromEmail = @"dragondrive1102@sohu.com";
	testMsg.toEmail = @"dragondrive2011@sohu.com";
	testMsg.relayHost = @"smtp.sohu.com";
	testMsg.requiresAuth = YES;
	testMsg.login = @"dragondrive1102@sohu.com";
	testMsg.pass = @"123456abc";
	testMsg.subject = @"test message";
	// testMsg.bccEmail = @"testbcc@test.com";
	testMsg.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
	
	// Only do this for self-signed certs!
	// testMsg.validateSSLChain = NO;
	testMsg.delegate = self;
	
	NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
							   @"NULL",kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
	
	// NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"vcf"];
	//NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
	
	NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"application/octet-stream",kSKPSMTPPartContentTypeKey,
							 @"attachment;\r\n\tfilename=\"live_report.plcrash\"",kSKPSMTPPartContentDispositionKey,[data encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
	
	testMsg.parts = [NSArray arrayWithObjects:plainPart,vcfPart,nil];
	
	[testMsg send];
}

- (BOOL) GetCrashFile
{
	NSFileManager *fm = [NSFileManager defaultManager];
	
	if (_curDealFile != nil && [fm fileExistsAtPath:_curDealFile])
		return YES;
	
	NSString* dir = [self GetCrashDir];
	
	if (!dir || [dir isEqualToString:@""])
		return NO;
		
	if (_curDealFile)
	{
		[_curDealFile release];
		
		_curDealFile = nil;
	}
	
	NSArray* contentOfFolder = [fm contentsOfDirectoryAtPath:dir error:NULL];
	
	NSMutableArray *delArr = [[NSMutableArray alloc] init];
	
	for (NSString *aPath in contentOfFolder) 
	{
	
		NSString *fullpath = [dir stringByAppendingPathComponent:aPath];
		
		BOOL isDir;
		/*
		if ([fm fileExistsAtPath:fullpath isDirectory:&isDir] 
			&& !isDir) 
		{
			if (![self CheckValidCrash:fullpath])
			{
				[delArr addObject:fullpath];
			}
			else if (_curDealFile == nil)
			{
				_curDealFile = [fullpath retain];
			}
		}
         */
	}
	
	for (NSString *aPath in delArr) 
	{
		[self DeleFile:aPath];
	}
	
	[delArr release];
	
	return _curDealFile != nil;
}

- (NSString*) GetCrashDir
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	NSString *crashReportDirectory = [documentsDirectory stringByAppendingPathComponent:@"/CrashReport"];
	
	NSFileManager *fm = [NSFileManager defaultManager];

	BOOL isDir;
	/*
	if (![fm fileExistsAtPath:crashReportDirectory isDirectory:&isDir] || !isDir)
		return @"";
	*/
	return crashReportDirectory;
}

- (NSUInteger) GetFileSize: (NSString*) filename
{
	if (!filename || [filename isEqualToString:@""])
		return 0;
	
	NSFileManager *fm = [NSFileManager defaultManager];
	NSError *error;
	
	NSDictionary *attribute = [fm attributesOfItemAtPath:filename error:&error];
	
	if (!attribute)
		return 0;
		
	NSNumber *fileSize = [attribute objectForKey:NSFileSize];
	
	return [fileSize unsignedIntegerValue];
}

- (BOOL) CheckValidCrash: (NSString*) filename;
{
	if (!filename || [filename isEqualToString:@""])
		return NO;
		
	NSData *crashData = nil;
	NSError *outError;
	
	crashData = [NSData dataWithContentsOfFile: filename options: NSMappedRead error: &outError];
	
	if (!crashData)
		return NO;
		
	PLCrashReport *report = [[[PLCrashReport alloc] initWithData: crashData error: &outError] autorelease];
	if (report == nil)
		return NO;
		
	return YES;
}

- (BOOL) DeleFile: (NSString*) filename;
{
	if (!filename || [filename isEqualToString:@""])
		return NO;
		
	NSFileManager *fm = [NSFileManager defaultManager];
	NSError *error;
 
    if ([fm fileExistsAtPath: filename] &&
        [fm removeItemAtPath: filename error:&error])
    {
		return YES;
    }
	
	return NO;
}

#pragma mark smtp send delegate

- (void)messageSent:(SKPSMTPMessage *)message
{
    [message release];
    
	if (_curDealFile != nil && [self DeleFile:_curDealFile])
	{
		[_curDealFile release];
		
		_curDealFile = nil;
	}
	
	_hasDataTransBefore = YES;
	
	NDMapMgrObj.DealBugReport();
	//showDialog("提示", "异常发送成功");
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
	NDLog(@"异常发送失败:%@", [error localizedDescription]);
    
	[message release];
	
	NDMapMgrObj.DealCrashRepotUploadFail();
}
@end