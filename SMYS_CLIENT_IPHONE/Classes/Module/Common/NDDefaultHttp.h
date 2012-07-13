/*
 *  NDDefaultHttp.h
 *  DragonDrive
 *
 *  Created by jhzheng on 11-7-12.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef _ND_DEFAULT_HTTP_H_
#define _ND_DEFAULT_HTTP_H_

#include "NDObject.h"

using namespace NDEngine;

typedef enum
{
	NDHttpErrCodeNone = 0,
	NDHttpErrCodeInvalidUrl,
	NDHttpErrCodeNotFound,
	NDHttpErrCodeInternalServerError,
	NDHttpErrCodeNoData,
	NDHttpErrCodeOtherError,
}NDHttpErrCode;

class NDDefaultHttpDelegate 
{
public:
	virtual void OnRecvData(id http, char* data, unsigned int len) {}
	virtual void OnRecvError(id http, NDHttpErrCode errCode) {}
};

@interface NDDefaultHttp : NSObject
{
	NSMutableData *_recvdata;
	NDObject *_delegate;
}

- (void)AysnSendRequst:(NSString*)url delegate:(NDObject*)object;

@end

#endif // _ND_DEFAULT_HTTP_H_