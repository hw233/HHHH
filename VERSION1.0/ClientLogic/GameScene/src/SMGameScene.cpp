/*
 *  SMGameScene.mm
 *  SMYS
 *
 *  Created by jhzheng on 12-2-10.
 *  Copyright 2012 (����)DeNA. All rights reserved.
 *
 */

#include "SMGameScene.h"
#include "NDDirector.h"
#include "NDMapLayerLogic.h"
#include "NDMiniMap.h"
#include "NDUtility.h"
#include "WorldMapScene.h"
#include "ScriptGameLogic.h"
#include "NDConstant.h"

//#define TAG_WORLD_MAP_BTN_LAYER		(65534)
#define TAG_WORLD_MAP_BTN			(1)
#define WORLD_MAP_BTN_W				(40)
#define WORLD_MAP_BTN_H				(20)

IMPLEMENT_CLASS(CSMGameScene, NDScene)

CSMGameScene* CSMGameScene::Scene()
{
	CSMGameScene *scene = new CSMGameScene;
	scene->Initialization(1);
	scene->SetTag(SMGAMESCENE_TAG);
	return scene;
}

CSMGameScene::CSMGameScene()
{
//	m_miniMap	= NULL;	 ///< ��ʱ��ע�� ����
	m_mapLayer	= NULL;
}

CSMGameScene::~CSMGameScene()
{
}


void CSMGameScene::Initialization(int mapID)
{
	NDScene::Initialization();
	
	CGSize winsize			= NDDirector::DefaultDirector()->GetWinSize();
	float fScaleFactor		= NDDirector::DefaultDirector()->GetScaleFactor();
	
	m_mapLayer = new NDMapLayerLogic();
	m_mapLayer->Initialization(mapID); 
	this->AddChild(m_mapLayer, MAPLAYER_Z, MAPLAYER_TAG);
	//this->ShowMiniMap(true);
	
	/*
	NDUILayer *layerMapButton	= new NDUILayer;
	layerMapButton->Initialization();
	layerMapButton->SetFrameRect(CGRectMake(
			(winsize.width - WORLD_MAP_BTN_W * fScaleFactor), 0,
			WORLD_MAP_BTN_W * fScaleFactor, WORLD_MAP_BTN_H * fScaleFactor));
	layerMapButton->SetTag(TAG_WORLD_MAP_BTN_LAYER);
	this->AddChild(layerMapButton);
	
	NDUIButton *btnMap	= new NDUIButton;
	btnMap->Initialization();
	btnMap->SetFrameRect(CGRectMake(0, 0, WORLD_MAP_BTN_W * fScaleFactor, WORLD_MAP_BTN_H * fScaleFactor));
	btnMap->SetDelegate(this);
	btnMap->SetTag(TAG_WORLD_MAP_BTN);
	layerMapButton->AddChild(btnMap);
	*/
}



void CSMGameScene::ShowMiniMap(bool bShow)
{
	/***
	* ��ʱ��ע�� ����
	* all
	*/
// 	if (bShow) 
// 	{
// 		if (!this->m_miniMap)
// 		{
// 			m_miniMap = new NDMiniMap();
// 			m_miniMap->Initialization();
// 			m_miniMap->SetGameScene(this);
// 			m_miniMap->SetFrameRect(CGRectMake(308.0f, 0.0f, 172.0f, 84.0f));
// 			this->AddChild(m_miniMap);
// 		}
// 	} 
// 	else
// 	{
// 		if (this->m_miniMap)
// 		{
// 			this->RemoveChild(m_miniMap, true);
// 			m_miniMap = NULL;
// 		}
// 	}
}

CGSize CSMGameScene::GetSize()
{
	return this->m_mapLayer->GetContentSize();
}

cocos2d::CCArray* CSMGameScene::GetSwitchs()
{
	return this->m_mapLayer->GetMapData()->getSwitchs();
}

void CSMGameScene::OnButtonClick(NDUIButton* button)
{
	/*
	if (TAG_WORLD_MAP_BTN == button->GetTag())
	{
		WorldMapLayer* world	= new WorldMapLayer;
		world->Initialization(GetMapId());
		this->AddChild(world);
	}
	*/
}