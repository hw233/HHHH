/*
 *  NDUIFighterSpeedBar.h
 *  DragonDrive
 *
 *  Created by jhzheng on 11-8-3.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef _ND_UI_FIGHTER_SPEED_BAR_
#define _ND_UI_FIGHTER_SPEED_BAR_

#include "NDUISpeedBar.h"
#include "NDUILabel.h"

class FighterBottom :
public NDUISpeedBar
{
	DECLARE_CLASS(FighterBottom)
public:
	FighterBottom();
	
	~FighterBottom();
	
	void Initialization(bool bShrink=false); override
	
protected:	

	void Layout(); override
	
	void DrawBackground(); override
	
	void OnDrawAjustUI(); override
	
private:
	void SetRefeshPagePic();
	
private:
	NDPicture *m_picItem[5];
};

///////////////////////////////////////

class FighterLeft :
public NDUISpeedBar
{
	DECLARE_CLASS(FighterLeft)
public:
	FighterLeft();
	
	~FighterLeft();
	
	void Initialization(bool bShrink=false); override
	
	void SetPage(unsigned int page); override
	
	void DealSkillTurn();
	
protected:	
	void Layout(); override
	
	void DrawBackground(); override
	
	void ReverseShrinkState();
	
private:
	void SetRefeshPagePic();

private:
	NDPicture *m_picItem[5];
};

///////////////////////////////////////

class FighterRight :
public NDUISpeedBar
{
	DECLARE_CLASS(FighterRight)
public:
	FighterRight();
	
	~FighterRight();
	
	void Initialization(bool bShrink=false); override
	
protected:

	void Layout(); override
	
	void DrawBackground(); override
	
	void OnDrawAjustUI(); override
private:	
	NDPicture *m_picItem[5];
	NDUILabel *m_lbText[5];
};

#endif // _ND_UI_FIGHTER_SPEED_BAR_