/*
 *  QuickTeam.mm
 *  DragonDrive
 *
 *  Created by jhzheng on 11-8-28.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "QuickTeam.h"
#include "NDMapMgr.h"
#include "GameScene.h"
#include "NDUtility.h"
#include "NDPlayer.h"
#include "QuickInteraction.h"

IMPLEMENT_CLASS(QuickTeam, NDUIChildrenEventLayer)

QuickTeam::QuickTeam()
{
	m_btnShrink = NULL;
	
	m_picShrink = NULL;
	
	m_stateShrink = false;
	
	m_keyAnimation = -1;
	
	memset(m_btn, 0, sizeof(m_btn));
}

QuickTeam::~QuickTeam()
{
}

void QuickTeam::Initialization()
{
	NDUILayer::Initialization();
	
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	CGSize winsize = NDDirector::DefaultDirector()->GetWinSize();
	
	NDPicture *picBg = pool.AddPicture(GetImgPathNew("team_back.png"), false);
	
	CGSize sizeBg = picBg->GetSize();
	
	this->SetFrameRect(CGRectMake(0, (winsize.height-sizeBg.height)/2, sizeBg.width, sizeBg.height));
	
	NDUIImage* SecondBg = new NDUIImage;
	SecondBg->Initialization();
	SecondBg->EnableEvent(false);
	SecondBg->SetPicture(picBg, true);
	SecondBg->SetFrameRect(CGRectMake(0, 0, sizeBg.width, sizeBg.height));
	this->AddChild(SecondBg);
	
	NDPicture * pic = pool.AddPicture(GetImgPathNew("team_switch.png"), false);
	CGSize sizeSwitch = pic->GetSize();
	NDUIImage* imgShrink = new NDUIImage; 
	imgShrink->Initialization();
	imgShrink->SetPicture(pic, true);
	imgShrink->SetFrameRect(CGRectMake(33, (sizeBg.height-sizeSwitch.height)/2-3, sizeSwitch.width, sizeSwitch.height));
	imgShrink->EnableEvent(false);
	this->AddChild(imgShrink);
	
	m_btnShrink = new NDUIButton;
	m_btnShrink->Initialization();
	m_picShrink = pool.AddPicture(GetImgPathBattleUI("handlearraw.png"), false);
	m_btnShrink->SetImage(m_picShrink, true, CGRectMake(15, 7, 9, 16), false);
	m_btnShrink->SetFrameRect(CGRectMake(37, (sizeBg.height-sizeSwitch.height)/2, 62, 34));
	m_btnShrink->SetDelegate(this);
	this->AddChild(m_btnShrink);
	
	int startY = 15, interval = (sizeBg.height-startY*2-39*4)/3 ;
	for (int i = 0; i < eMaxShow; i++) 
	{
		m_btn[i] = new TeamRoleButton;
		m_btn[i]->Initialization();
		m_btn[i]->SetFrameRect(CGRectMake(0, startY+(interval+39)*i, 49, 39));
		m_btn[i]->SetDelegate(this);
		this->AddChild(m_btn[i]);
	}
}

void QuickTeam::OnButtonClick(NDUIButton* button)
{
	if (button == m_btnShrink)
	{
		DealShrink(0.3f);
		
		return;
	}
	
	if (!button || !button->IsKindOfClass(RUNTIME_CLASS(TeamRoleButton))) return;
	
	int teamId = 0, index = 0;
	
	((TeamRoleButton*)button)->GetTeamRole(teamId, index);
	
	if (teamId < 0 || index < 0) return;
	
	NDManualRole* role = NDMapMgrObj.GetTeamRole(teamId, index);
	
	if (!role) return;
	
	GameScene *scene = GameScene::GetCurGameScene();
	
	if (!scene) return;
	
	scene->SetTargetHead(role);
	
	NDPlayer::defaultHero().SetFocusRole(role);
	
	QuickInteraction::RefreshOptions();
}

void QuickTeam::SetShrink(bool bShrink, bool animation/*=true*/)
{
	if (m_stateShrink == bShrink) {
		return;
	}
	
	DealShrink(animation ?  0.3f : 0.0f);
}

void QuickTeam::Refresh()
{
	NDPlayer& player = NDPlayer::defaultHero();
	
	if (!player.isTeamMember()) return;
	
	s_team_info teminfo;
	
	if (!NDMapMgrObj.GetTeamInfo(player.teamId, teminfo)) return;
	
	int btnIndex = 0;
	
	for(int i = 0; i < eTeamLen; i++)
	{
		if (! (teminfo.team[i] != player.m_id && teminfo.team[i] > 0) ) continue;
		
		m_btn[btnIndex]->SetRole(player.teamId, i);
		
		m_btn[btnIndex]->SetVisible(true);
		
		btnIndex++;
	}
	
	for(; btnIndex < eMaxShow; btnIndex++)
	{
		m_btn[btnIndex]->SetVisible(false);
	}
}

bool QuickTeam::IsShrink()
{
	return m_stateShrink;
}

void QuickTeam::ReverseShrink()
{
	DealShrink(0.3f);
}

void QuickTeam::DealShrink(float time)
{
	if (m_keyAnimation == (unsigned int)-1 ) 
	{
		CGRect frame = this->GetFrameRect();
		CGSize size = CGSizeZero;
		
		size.width = frame.size.width-20;
		
		m_keyAnimation = m_curUiAnimation.GetAnimationKey(this, size);
	}
	
	UIAnimationMove move = m_stateShrink ? UIAnimationMoveRightToLeftReverse : UIAnimationMoveRightToLeft;
	
	m_curUiAnimation.AddAnimation(m_keyAnimation, move, time);
	
	m_curUiAnimation.playerAnimation(m_keyAnimation);
	
	m_stateShrink = !m_stateShrink;
	
	if (m_picShrink)
		m_picShrink->Rotation(!m_stateShrink ? PictureRotation0 : PictureRotation180);
}