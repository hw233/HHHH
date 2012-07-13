/*
 *  NDCrashUpload.h
 *  DragonDrive
 *
 *  Created by jhzheng on 11-10-20.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef _ND_CRASH_UPLOAD_H_
#define _ND_CRASH_UPLOAD_H_

#import <Foundation/Foundation.h>
#include "SKPSMTPMessage.h"

@interface NDCrashUpload : NSObject <SKPSMTPMessageDelegate>
{
	NSString*		_curDealFile;
	
	BOOL			_hasDealBefore, _hasDataTransBefore;
}

+ (id)Shared;

+ (void)PurgeShared;

- (BOOL) HadDealBefore;

- (BOOL) HadDataTransBefore;

- (void) ResetDataTransBefore;

- (NSUInteger) GetCrashReportSize;

- (void) UploadCrashReport;

- (BOOL) EnableCrashCatch;

@end

#endif // _ND_CRASH_UPLOAD_H_