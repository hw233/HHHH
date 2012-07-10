/*
 *  ItemUtil.cpp
 *  SMYS
 *
 *  Created by jhzheng on 12-3-5.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#include "ItemUtil.h"
#include "TableDef.h"
#include "ScriptGameData.h"
#include "ScriptDataBase.h"

unsigned int GetItemInfoN(unsigned int nItemId, unsigned int  nIndex)
{
	return ScriptGameDataObj.GetData<unsigned long>(eItemInfo, nItemId, eRoleDataBasic, 0, nIndex);
}

const char* GetItemInfoS(unsigned int nItemId, unsigned int  nIndex)
{
	return ScriptGameDataObj.GetData<std::string>(eItemInfo, nItemId, eRoleDataBasic, 0, nIndex).c_str();
}

unsigned int GetItemDBN(unsigned int nItemType, unsigned int  nIndex)
{
	return ScriptDBObj.GetN("itemtype", nItemType, nIndex);
}

const char* GetItemDBS(unsigned int nItemType, unsigned int  nIndex)
{
	return ScriptDBObj.GetS("itemtype", nItemType, nIndex).c_str();
}

bool IsItemCanChaiFen(unsigned int nItemType)
{
	return GetItemDBN(nItemType, DB_ITEMTYPE_AMOUNT_LIMIT) > 1;
}

bool isItemRidePet(unsigned int nItemType)
{
	return nItemType / 1000000 == 14;
}