/*
 *  NDTimer.h
 *  DragonDrive
 *
 *  Created by wq on 11-1-17.
 *  Copyright 2011 (����)DeNA. All rights reserved.
 *
 */

#ifndef __ND_TIMER_H__
#define __ND_TIMER_H__

#include "basedefine.h"
#include <map>

class ITimerCallback
{
public:
	virtual void OnTimer(OBJID tag) = 0;
};

class Timer;
class NDTimer
{
public:
	NDTimer();
	~NDTimer();
	
	void SetTimer(ITimerCallback* timerCallback, OBJID tag, float interval);
	void KillTimer(ITimerCallback* timerCallback, OBJID tag);
	
private:
	struct IMP_CALLBACK
	{
		IMP_CALLBACK()
		{
			timerCallback = NULL;
			tag = 0;
		}
		
		ITimerCallback* timerCallback;
		OBJID tag;
		
		bool operator < (const IMP_CALLBACK& cbImp) const
		{
			return timerCallback < cbImp.timerCallback ? true : tag < cbImp.tag;
		}
	};
	
	typedef std::map<IMP_CALLBACK, Timer*> MAP_TIMER;
	
	MAP_TIMER m_mapTimer;
};

#endif