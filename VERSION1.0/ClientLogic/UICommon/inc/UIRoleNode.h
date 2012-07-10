/*
 *  UIRoleNode.h
 *  SMYS
 *
 *  Created by jhzheng on 12-2-20.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef _UI_ROLE_NODE_H_ZJH_
#define _UI_ROLE_NODE_H_ZJH_

#include "NDUINode.h"
#include "NDManualRole.h"

using namespace NDEngine;

class CUIRoleNode : public NDUINode
{
	DECLARE_CLASS(CUIRoleNode)
	
	CUIRoleNode();
	~CUIRoleNode();

public:
	void Initialization(); override
	void ChangeLookFace(int nLookFace);
	void SetEquip(int nEquipId, int nQuality);
	void SetMove(bool bSet, bool directRight=true);
	void SetRoleScale(float scale);
private:
	NDUINode*				m_pRoleParentNode;
	NDManualRole*			m_pRole;
	
protected:
	void draw(); override
};

#endif // _UI_ROLE_NODE_H_ZJH_