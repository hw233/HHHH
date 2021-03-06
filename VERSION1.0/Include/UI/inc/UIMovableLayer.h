/*
 *  UIMovableLayer.h
 *  SMYS
 *
 *  Created by jhzheng on 12-2-10.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef _UI_MOVEABLE_LAYER_H_ZJH_
#define _UI_MOVEABLE_LAYER_H_ZJH_

#include "NDUILayer.h"
#include "AutoLink.h"
#include <list>

using namespace NDEngine;

class CUIMovableLayer :
public NDUILayer,
public NDUILayerDelegate
{
	DECLARE_CLASS(CUIMovableLayer)
	
	CUIMovableLayer();
	~CUIMovableLayer();
	
public:
	void Initialization(); override
	void SetMovableViewer(NDCommonProtocol* viewer);

protected:
	bool TouchEnd(NDTouch* touch); override
	
	virtual bool CanHorizontalMove(float& hDistance);
	virtual bool CanVerticalMove(float& vDistance);
	
	virtual bool OnHorizontalMove(float fDistance) { return true; }
	virtual bool OnVerticalMove(float fDistance) { return true; }
	virtual void OnMoveStop() {}
	
protected:
	 bool OnLayerMoveOfDistance(NDUILayer* uiLayer, float hDistance, float vDistance); override
};

#endif // _UI_MOVEABLE_LAYER_H_ZJH_