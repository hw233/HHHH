/*
 *  NDUIFighterSpeedBar.mm
 *  DragonDrive
 *
 *  Created by jhzheng on 11-8-3.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "NDUIFighterSpeedBar.h"
#include "ImageNumber.h"
#include "NDUtility.h"
#include "BattleMgr.h"
#include "Battle.h"
#include <sstream>

#define BOTTOM_START_Y (40)
#define BOTTOM_RECT CGRectMake(88, 240, 332, 80)


IMPLEMENT_CLASS(FighterBottom, NDUISpeedBar)

FighterBottom::FighterBottom()
{
	m_sizeBtn = CGSizeMake(39, 35);
	
	m_pointBorder = CGPointMake((332-5*(39+4)-47*2)/2+47+1, BOTTOM_START_Y);
	
	m_uiInterval = 4;
	
	m_align = SpeedBarAlignmentBottom;
	
	memset(m_picItem, 0, sizeof(m_picItem));
}

FighterBottom::~FighterBottom()
{
	for (int i = 0; i < 5; i++) 
	{
		if (m_picItem[i])
		{
			delete m_picItem[i];
			
			m_picItem[i] = NULL;
		}
	}
}

void FighterBottom::Initialization(bool bShrink/*=false*/)
{
	NDUISpeedBar::Initialization(5, 3);
	
	this->SetFrameRect(BOTTOM_RECT);
	
	this->SetShrink(bShrink, false);
}

void FighterBottom::Layout()
{
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	m_btnSetOption = new NDUIButton;
	
	m_btnSetOption->Initialization();
	
	m_btnSetOption->SetDelegate(this);
	
	m_btnSetOption->SetFrameRect(CGRectMake((332-5*(39+4)-47*2)/2, BOTTOM_START_Y, 47, 35));
	
	m_btnSetOption->SetImage(pool.AddPicture(GetImgPathBattleUI("itemset.png")), false, CGRectZero, true);
	
	//m_btnSetOption->SetTitle("设置");
	
	this->AddChild(m_btnSetOption);
	
	CGRect frame = BOTTOM_RECT;
	
	m_btnRefresh = new NDUIButton;
	
	m_btnRefresh->Initialization();
	
	m_btnRefresh->SetDelegate(this);
	
	//m_btnRefresh->SetTitle("刷新");
	
	m_btnRefresh->SetFrameRect(CGRectMake(332-(332-5*(39+4)-47*2)/2-47, BOTTOM_START_Y, 47, 35));
	
	m_btnRefresh->SetBackgroundPicture(pool.AddPicture(GetImgPathBattleUI("itemswitch.png")), NULL, false, CGRectZero, true);

	this->AddChild(m_btnRefresh);

	m_btnShrink = new NDUIButton;
	
	m_btnShrink->Initialization();
	
	m_btnShrink->SetFrameRect(CGRectMake((332-40)/2, 0, 40, BOTTOM_START_Y));
	
	//m_btnShrink->SetTitle("收缩");
	
	m_picShrink = pool.AddPicture(GetImgPathBattleUI("handlearraw.png"));
	
	CGSize sizeShrink = m_picShrink->GetSize();
	
	m_btnShrink->SetImage(m_picShrink, true, CGRectMake((40-sizeShrink.height)/2, (BOTTOM_START_Y-sizeShrink.width)/2+8, sizeShrink.height, sizeShrink.width), false);
	
	m_btnShrink->SetDelegate(this);
	
	SetShrinkDis(40);
	
	this->AddChild(m_btnShrink);
	
	m_picBackGround = pool.AddPicture(GetImgPathBattleUI("itemback.png"));
	
	m_picBackGroundShrink = pool.AddPicture(GetImgPathBattleUI("orizontalhandle.png"));
	
	for (int i = 0; i < 5; i++) 
	{
		m_picItem[i] = pool.AddPicture(GetImgPathBattleUI("itemchildback.png"), true);
	}
	
	this->SetFocusImage(GetImgPathBattleUI("itemchildsel.png"));
}

void FighterBottom::DrawBackground()
{
	CGRect scrRect = this->GetScreenRect();
	
	if (m_picBackGround) 
	{
		CGSize bg = m_picBackGround->GetSize(), frame = scrRect.size;
		
		m_picBackGround->DrawInRect(CGRectMake(scrRect.origin.x+(frame.width-bg.width), scrRect.origin.y+(frame.height-bg.height), bg.width, bg.height));
	}
	
	if (m_picBackGroundShrink) 
	{
		
		CGSize bg = m_picBackGroundShrink->GetSize(), frame = scrRect.size;
		
		m_picBackGroundShrink->DrawInRect(CGRectMake(scrRect.origin.x+(frame.width-bg.width)/2, scrRect.origin.y+BOTTOM_START_Y+8-bg.height, bg.width, bg.height));
	}
	
	if (m_picShrink)
		m_picShrink->Rotation(IsShrink() ? PictureRotation270 : PictureRotation90);
		
	for (int i = 0; i < 5; i++) 
	{
		if (m_picItem[i])
		{
			unsigned int index = m_uiCurPage * m_uiFuncNum + i;
			
			m_picItem[i]->SetGrayState(false);
			
			if (index < m_vecInfo.size() && m_vecInfo[index].info.isGray()) 
			{
				m_picItem[i]->SetGrayState(true);
			}
			
			m_picItem[i]->DrawInRect(CGRectMake(scrRect.origin.x+m_pointBorder.x+i*(39+m_uiInterval)+1, scrRect.origin.y+BOTTOM_START_Y, 39, 35));
		}
	}
}

void FighterBottom::OnDrawAjustUI()
{
	if (m_imageFocus && m_imageFocus->IsVisibled()) 
	{
		CGRect rect = m_imageFocus->GetFrameRect();
		rect.origin.x += 1;
		//rect.origin.y += 2;
		m_imageFocus->SetFrameRect(rect);
	}
	
	SetRefeshPagePic();
}

void FighterBottom::SetRefeshPagePic()
{
	PictureNumber& pn = *(PictureNumber::SharedInstance());
	NDPicture *num = pn.TitleRedNumber(m_uiCurPage+1);
	
	if (num) 
	{
		CGSize sizeNum = pn.GetTitleRedNumberSize();
		
		m_btnRefresh->SetImage(num, true, CGRectMake((47-sizeNum.width)/2, (35-sizeNum.height)/2, sizeNum.width, sizeNum.height));
	}
}

///////////////////////////////////////
#define LEFT_RECT CGRectMake(0, 10, 80, 253)

#define LABLE_COOLDOWN_TAG (202)

IMPLEMENT_CLASS(FighterLeft, NDUISpeedBar)

FighterLeft::FighterLeft()
{
	m_sizeBtn = CGSizeMake(40, 40);
	
	m_pointBorder = CGPointMake(0, (253-40*6)/2+40);
	
	m_uiInterval = 0;
	
	m_align = SpeedBarAlignmentLeft;
	
	memset(m_picItem, 0, sizeof(m_picItem));
}

FighterLeft::~FighterLeft()
{
	for (int i = 0; i < 5; i++) 
	{
		if (m_picItem[i])
		{
			delete m_picItem[i];
			
			m_picItem[i] = NULL;
		}
	}
}

void FighterLeft::Initialization(bool bShrink/*=false*/)
{
	NDUISpeedBar::Initialization(5, 4);
	
	this->SetFrameRect(LEFT_RECT);
	
	this->SetShrink(bShrink, false);
}

void FighterLeft::Layout()
{
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	CGRect frame = LEFT_RECT;
	
	m_btnRefresh = new NDUIButton;
	
	m_btnRefresh->Initialization();
	
	m_btnRefresh->SetDelegate(this);
	
	//m_btnRefresh->SetTitle("刷新");
	
	m_btnRefresh->SetBackgroundPicture(pool.AddPicture(GetImgPathBattleUI("skillswitch.png")), NULL, false, CGRectZero, true);
	
	m_btnRefresh->SetFrameRect(CGRectMake(0, (253-40*6)/2, 40, 40));
	
	this->AddChild(m_btnRefresh);
	
	m_btnShrink = new NDUIButton;
	
	m_btnShrink->Initialization();
	
	//m_btnShrink->SetTitle("收缩");
	
	m_picShrink = pool.AddPicture(GetImgPathBattleUI("handlearraw.png"));
	
	CGSize sizeShrink = m_picShrink->GetSize();
	
	m_btnShrink->SetFrameRect(CGRectMake(40, (253-40)/2, 40, 40));
	
	m_btnShrink->SetImage(m_picShrink, true, CGRectMake((40-sizeShrink.width)/2-6, (40-sizeShrink.height)/2, sizeShrink.width, sizeShrink.height), false);
	
	m_btnShrink->SetDelegate(this);
	
	SetShrinkDis(40);
	
	this->AddChild(m_btnShrink);
	
	m_picBackGround = pool.AddPicture(GetImgPathBattleUI("skillback.png"));
	
	m_picBackGroundShrink = pool.AddPicture(GetImgPathBattleUI("verticalhandle.png"));
	
	m_picBackGroundShrink->SetReverse(true);
	
	for (int i = 0; i < 5; i++) 
	{
		m_picItem[i] = pool.AddPicture(GetImgPathBattleUI("skillchildback.png"), true);
	}
	
	this->SetFocusImage(GetImgPathBattleUI("skillchildsel.png"));
}

void FighterLeft::ReverseShrinkState()
{
	this->ReverseShrink();
}

void FighterLeft::SetRefeshPagePic()
{
	PictureNumber& pn = *(PictureNumber::SharedInstance());
	NDPicture *num = pn.TitleRedNumber(m_uiCurPage+1);
	
	if (num) 
	{
		CGSize sizeNum = pn.GetTitleRedNumberSize();
		
		m_btnRefresh->SetImage(num, true, CGRectMake((40-sizeNum.width)/2, (40-sizeNum.height)/2, sizeNum.width, sizeNum.height));
	}
}

void FighterLeft::DrawBackground()
{
	CGRect scrRect = this->GetScreenRect();
	
	if (m_picBackGround) 
	{
		CGSize bg = m_picBackGround->GetSize(), frame = scrRect.size;
		
		m_picBackGround->DrawInRect(CGRectMake(scrRect.origin.x, scrRect.origin.y, bg.width, bg.height));
	}
	
	if (m_picBackGroundShrink) 
	{
		
		CGSize bg = m_picBackGroundShrink->GetSize(), frame = scrRect.size;
		
		m_picBackGroundShrink->DrawInRect(CGRectMake(scrRect.origin.x+m_pointBorder.x+33, scrRect.origin.y+(frame.height-bg.height)/2, bg.width, bg.height));
	}
	
	if (m_picShrink)
		m_picShrink->Rotation(IsShrink() ? PictureRotation0 : PictureRotation180);
	
	for (int i = 0; i < 5; i++) 
	{
		if (m_picItem[i])
		{
			unsigned int index = m_uiCurPage * m_uiFuncNum + i;
			
			m_picItem[i]->SetGrayState(false);
			
			if (index < m_vecInfo.size() && m_vecInfo[index].info.isGray()) 
			{
				m_picItem[i]->SetGrayState(true);
			}
			
			m_picItem[i]->DrawInRect(CGRectMake(scrRect.origin.x, scrRect.origin.y+m_pointBorder.y+i*(40+m_uiInterval), 40, 40));
		}
	}
	
	SetRefeshPagePic();
}

void FighterLeft::SetPage(unsigned int page)
{
	unsigned int resPage = 0;
	
	if (!FindPage(page, resPage, true, true))
	{
		resPage = 0;
	}
	
	m_uiCurPage = resPage;
	
	UpdatePage();
}

void FighterLeft::DealSkillTurn()
{
	Battle* ble = BattleMgrObj.GetBattle();
	
	if (!ble) return;
	
	CoolDownRecord& cooldown = ble->GetSkillCoolDownRecord();
	
	std::vector<CellInfo>::iterator it = m_vecInfo.begin();
	
	for (; it != m_vecInfo.end(); it++) {
		SpeedBarCellInfo& ci = (*it).info;
		
		NDUIButton *btn = (NDUIButton *)(this->GetChild((*it).key));
		
		if (!btn) continue;
		
		if (!ci.isGray())
		{
			btn->RemoveChild(LABLE_COOLDOWN_TAG,true);
			continue;
		}
		
		if (ci.param2 == 0) {
			btn->RemoveChild(LABLE_COOLDOWN_TAG,true);
			continue;
		}
		
		CoolDownRecord_IT itCoolDown = cooldown.find(CoolDownID(ci.param1));
		if (itCoolDown == cooldown.end()) {
			btn->RemoveChild(LABLE_COOLDOWN_TAG, true);
			continue;
		}
		
		std::string show;
		
		CoolDownData cd = itCoolDown->second;
		
		//NDLog(@"skill id[%d] cool[%d], turn[%d]",ci.param1, ci.param2, itCoolDown->second );
		
		if (cd >= CoolDownData(ci.param2))
		{
			show = "";
		}
		else
		{
			std::stringstream ss;
			
			if (cd < 0)
				ss << ci.param2;
			else
				ss << (ci.param2 - cd);
				
			show = ss.str();
		}
		
		if (show == "") {
			btn->RemoveChild(LABLE_COOLDOWN_TAG, true);
			continue;
		}
		
			
		
		NDUILabel *lb = (NDUILabel*) (btn->GetChild(LABLE_COOLDOWN_TAG));
		
		if (!lb)
		{
			CGSize sizelb = getStringSize(show.c_str(), 12);
			CGSize sizeParent = btn->GetFrameRect().size;
			CGRect rect = CGRectMake((sizeParent.width-sizelb.width)/2, 
									 (sizeParent.height-sizelb.height*2), 
									 sizelb.width, sizelb.height);
			lb = new NDUILabel;
			lb->Initialization();
			lb->SetFontSize(12);
			lb->SetFontColor(ccc4(0, 0, 0, 255));
			lb->SetFrameRect(rect);
			lb->SetTag(LABLE_COOLDOWN_TAG);
			btn->AddChild(lb);
		}
		
		if (lb->GetText() != show)
		{
			lb->SetText(show.c_str());
		}
		
		lb->SetVisible(btn->IsVisibled());
	}
}

///////////////////////////////////////

#define RIGHT_RECT CGRectMake(480-85, 0, 85, 261)

IMPLEMENT_CLASS(FighterRight, NDUISpeedBar)

FighterRight::FighterRight()
{
	m_sizeBtn = CGSizeMake(43, 39);
	
	m_pointBorder = CGPointMake(42, (261-5*39-4*4)/2);
	
	m_uiInterval = 4;
	
	m_align = SpeedBarAlignmentRight;
	
	memset(m_lbText, 0, sizeof(m_lbText));
}

FighterRight::~FighterRight()
{
	for (int i = 0; i < 5; i++) 
	{
		if (m_picItem[i])
		{
			delete m_picItem[i];
			
			m_picItem[i] = NULL;
		}
	}
}

void FighterRight::Initialization(bool bShrink/*=false*/)
{
	NDUISpeedBar::Initialization(5, 1);
	
	this->SetFrameRect(RIGHT_RECT);
	
	this->SetShrink(bShrink, false);
}

void FighterRight::Layout()
{
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	CGRect frame = RIGHT_RECT;
	
	m_btnShrink = new NDUIButton;
	
	m_btnShrink->Initialization();
	
	//m_btnShrink->SetTitle("收缩");
	m_picShrink = pool.AddPicture(GetImgPathBattleUI("handlearraw.png"));
	
	CGSize sizeShrink = m_picShrink->GetSize();
	
	m_btnShrink->SetFrameRect(CGRectMake(0, (frame.size.height-42)/2, 42, 40));
	
	m_btnShrink->SetImage(m_picShrink, true, CGRectMake((42-sizeShrink.width)/2+8, (40-sizeShrink.height)/2, sizeShrink.width, sizeShrink.height), false);
	
	m_btnShrink->SetDelegate(this);
	
	SetShrinkDis(43);
	
	this->AddChild(m_btnShrink);
	
	m_picBackGround = pool.AddPicture(GetImgPathBattleUI("menuback.png"));
	
	m_picBackGroundShrink = pool.AddPicture(GetImgPathBattleUI("verticalhandle.png"));
	
	for (int i = 0; i < 5; i++) 
	{
		m_picItem[i] = pool.AddPicture(GetImgPathBattleUI("menuchildback.png"), true);
	}
	
	CGSize sizetext = getStringSize(NDCommonCString("catch"), 11);
	
	std::string text[5] = { NDCommonCString("catch"), NDCommonCString("flee"), NDCommonCString("def"), NDCommonCString("attack"), NDCommonCString("ChaKang"),};
	
	for (int i = 0; i < 5; i++) 
	{
		m_lbText[i] = new NDUILabel;
		m_lbText[i]->Initialization();
		m_lbText[i]->SetFontSize(11);
		m_lbText[i]->SetText(text[i].c_str());
		m_lbText[i]->SetFontColor(ccc4(0, 0, 0, 200));
		m_lbText[i]->SetFrameRect(CGRectMake(m_pointBorder.x+(m_sizeBtn.width-sizetext.width)/2, m_pointBorder.y+(m_sizeBtn.height+m_uiInterval)*i+m_sizeBtn.height-sizetext.height, sizetext.width, sizetext.height));
		this->AddChild(m_lbText[i]);
	}
	
	this->SetFocusImage(GetImgPathBattleUI("menuchildsel.png"));
}

void FighterRight::DrawBackground()
{
	CGRect scrRect = this->GetScreenRect();
	
	if (m_picBackGround) 
	{
		CGSize bg = m_picBackGround->GetSize(), frame = scrRect.size;
		
		m_picBackGround->DrawInRect(CGRectMake(scrRect.origin.x+(frame.width-bg.width), scrRect.origin.y, bg.width, bg.height));
	}
	
	if (m_picBackGroundShrink) 
	{
		
		CGSize bg = m_picBackGroundShrink->GetSize(), frame = scrRect.size;
		
		m_picBackGroundShrink->DrawInRect(CGRectMake(scrRect.origin.x+m_pointBorder.x-bg.width+8, scrRect.origin.y+(frame.height-bg.height)/2, bg.width, bg.height));
	}
	
	if (m_picShrink)
		m_picShrink->Rotation(IsShrink() ? PictureRotation180 : PictureRotation0);
	
	for (int i = 0; i < 5; i++) 
	{
		if (m_picItem[i])
		{
			unsigned int index = m_uiCurPage * m_uiFuncNum + i;
			
			m_picItem[i]->SetGrayState(false);
			
			if (index < m_vecInfo.size() && m_vecInfo[index].info.isGray()) 
			{
				m_picItem[i]->SetGrayState(true);
			}
			
			m_picItem[i]->DrawInRect(CGRectMake(scrRect.origin.x+m_pointBorder.x+2, scrRect.origin.y+m_pointBorder.y+i*(39+m_uiInterval), 43, 39));
		}
	}
}

void FighterRight::OnDrawAjustUI()
{
	if (m_imageFocus && m_imageFocus->IsVisibled()) 
	{
		CGRect rect = m_imageFocus->GetFrameRect();
		rect.origin.x += 2;
		rect.origin.y += 1;
		m_imageFocus->SetFrameRect(rect);
	}
}
