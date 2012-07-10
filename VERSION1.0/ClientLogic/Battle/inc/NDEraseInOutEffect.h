/*
 *  NDEraseInOutEffect.h
 *  DragonDrive
 *
 *  Created by jhzheng on 11-7-19.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef _ND_ERASE_IN_OUT_EFFECT_H_
#define _ND_ERASE_IN_OUT_EFFECT_H_

#include "NDUINode.h"
#include "NDTimer.h"

using namespace NDEngine;

class NDEraseInOutEffect : public NDUINode, public ITimerCallback
{
	DECLARE_CLASS(NDEraseInOutEffect)
public:
	
	NDEraseInOutEffect();
	
	~NDEraseInOutEffect();
	
	void StartEraseIn();
	
	void StartEraseOut();
	
	bool isChangeComplete();
	
	bool IsInStateEraseIn();
	
	bool IsInStateEraseOut();
	
	void OnTimer(OBJID tag); override
	
	void draw(); override
private:
	enum { eStateStop, eStateEraseIn, eStateEraseOut,};
	NDTimer* m_timer;
	int inCount, outCount;
//	bool changeComplete;
	int state;
private:
//	void setChangeComplete(bool changeComplete) {
//		this->changeComplete = changeComplete;
//	}
	
	void refreshScreenIn();
	
	void drawScreenIn();
	
	void refreshScreenOut();
	
	void drawScreenOut();
	
	void reset();
	
	DECLARE_AUTOLINK(NDEraseInOutEffect)
	INTERFACE_AUTOLINK(NDEraseInOutEffect)
};

#endif // _ND_ERASE_IN_OUT_EFFECT_H_