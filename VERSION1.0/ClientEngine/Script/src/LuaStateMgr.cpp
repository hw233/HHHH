/*
 *  LuaStateMgr.mm
 *  DragonDrive
 *
 *  Created by jhzheng on 12-1-6.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#include "LuaStateMgr.h"

using namespace NDEngine;

static LuaStateOwner* state = NULL;

static LuaStateMgr* mgr = NULL;

void exceptOutPut(LuaState *L, const char *exceptinfo)
{
	FUNCEXCEPTOUTPUT fun = LuaStateMgrObj.GetExceptOutput();
	
	if (fun)
	{
		fun(exceptinfo);
		
		return;
	}
}

LuaStateMgr::LuaStateMgr(void)
{
	m_funExceptOutput = NULL;
}

LuaStateMgr::~LuaStateMgr(void)
{
	mgr = NULL;
}

LuaStateMgr& LuaStateMgr::GetSingle()
{
	if (mgr == NULL)
	{
		mgr = new LuaStateMgr;
	}
	
	return *mgr;
}

LuaStateOwner& LuaStateMgr::GetState()
{
	if (state ==  NULL)
	{
		state = new LuaStateOwner(true);
		
		(*state)->SetExceptInfoOutHandler(&exceptOutPut);
	}
	
	return *state;
}