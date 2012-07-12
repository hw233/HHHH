/*
 *  ItemUtil.h
 *  SMYS
 *
 *  Created by jhzheng on 12-3-5.
 *  Copyright 2012 (网龙)DeNA. All rights reserved.
 *
 */

#ifndef _ITEM_UTIL_H_ZJH_
#define _ITEM_UTIL_H_ZJH_

enum
{
	ITEM_ID							= 0,               // Id
	ITEM_TYPE							= 1,               // 类型
	ITEM_OWNERTYPE					= 2,               // 所有者类型
	ITEM_OWNER_ID						= 3,               // 所有者id	
	ITEM_USER_ID						= 4,               // 玩家id
	ITEM_AMOUNT						= 5,               // 数量
	ITEM_POSITION						= 6,               // 位置
	ITEM_ADDITION						= 7,               // 强化等级
	ITEM_EXP							= 8,               // 道法经验
	ITEM_ATTR_NUM						= 9,               // 属性数量
	ITEM_ATTR_BEGIN					= 10,               // 属性定义开始()
};

unsigned int GetItemInfoN(unsigned int nItemId, unsigned int  nIndex);
const char* GetItemInfoS(unsigned int nItemId, unsigned int  nIndex);

unsigned int GetItemDBN(unsigned int nItemType, unsigned int  nIndex);
const char* GetItemDBS(unsigned int nItemType, unsigned int  nIndex);

bool IsItemCanChaiFen(unsigned int nItemType);
bool isItemRidePet(unsigned int nItemType);


#endif // _ITEM_UTIL_H_ZJH_