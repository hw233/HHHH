/*
 *  CCTexture2DExt.mm
 *  SMYS
 *
 *  Created by jhzheng on 12-3-30.
 *  Copyright 2012 (����)DeNA. All rights reserved.
 *
 */

#include "CCTexture2DExt.h"
#include "NDTextureMonitor.h"
/*
@implementation CCTexture2D (MemoryMonitor)

- (NSUInteger) GetPixelMemory
{
	unsigned int nSize	= self.pixelsWide * self.pixelsHigh;
	
	if ( kCCTexture2DPixelFormat_A8 != self.pixelFormat )
	{
		nSize	*= 4;
	}
	
	return nSize;
}

- (void) OnLoadImageBegin
{
	TextureMonitorObj.BeforeTextureAdd();
}

- (void) OnLoadImageEnd
{
	unsigned int nSize = [self GetPixelMemory];
	
	if ( 0 == nSize)
	{
		return;
	}

	TextureMonitorObj.TextureAdd(nSize);
}

- (void) OnUnLoadImageBegin
{
	unsigned int nSize = [self GetPixelMemory];
	
	if ( 0 == nSize)
	{
		return;
	}
	
	TextureMonitorObj.TextureDel(nSize);
}

- (void) OnUnLoadImageEnd
{
}

@end
*/