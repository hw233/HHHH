/*
 *  EnhancedObj.h
 *  DragonDrive
 *
 *  Created by wq on 11-9-5.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef __ENHANCED_OBJ_H__
#define __ENHANCED_OBJ_H__

struct EnhancedObj
{
	EnhancedObj();
	~EnhancedObj();
	
	int idType;
	ushort addpoint;
	Byte percent;
	int req_item;
	int req_num;
	int req_money;
};

#endif