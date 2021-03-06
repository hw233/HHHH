/*
 *  UIItemButton.h
 *  SMYS
 *
 *  Created by jhzheng on 12-3-5.
 *  Copyright 2012 (����)DeNA. All rights reserved.
 *
 */

#ifndef _UI_ITEM_BUTTON_H_ZJH_
#define _UI_ITEM_BUTTON_H_ZJH_

#include "NDUIButton.h"

using namespace NDEngine;

class CUIItemButton :
	public NDUIButton
{
	DECLARE_CLASS(CUIItemButton)
	CUIItemButton();
	~CUIItemButton();
	
public:
	void SetLock(bool bSet);
	bool IsLock();

	void ChangeItem(unsigned int unItemId);
	unsigned int GetItemId();
	
	void ChangeItemType(unsigned int unItemType);
	unsigned int GetItemType();
	
	void RefreshItemCount();
	unsigned int GetItemCount();
	
	void SetShowAdapt(bool bShowAdapt);
	bool IsShowAdapt();

	virtual void InitializationItem();
	virtual void CloseItemFrame();
	virtual void SetItemFrameRect(CCRect rect);

	virtual void SetItemBackgroundPicture(NDPicture *pic, NDPicture *touchPic = NULL,
		bool useCustomRect = false, CCRect customRect = CCRectZero, bool clearPicOnFree = false);
	virtual void SetItemBackgroundPictureCustom(NDPicture *pic, NDPicture *touchPic = NULL,
		bool useCustomRect = false, CCRect customRect = CCRectZero);

	virtual void SetItemTouchDownImage(NDPicture *pic, bool useCustomRect = false, CCRect customRect = CCRectZero, bool clearPicOnFree = false);
	virtual void SetItemTouchDownImageCustom(NDPicture *pic, bool useCustomRect = false, CCRect customRect = CCRectZero);

	virtual void SetItemFocusImage(NDPicture *pic, bool useCustomRect = false, CCRect customRect = CCRectZero, bool clearPicOnFree = false);
	virtual void SetItemFocusImageCustom(NDPicture *pic, bool useCustomRect = false, CCRect customRect = CCRectZero);
private:
	unsigned int			m_unItemId;
	unsigned int			m_unItemType;
	unsigned int			m_unItemCount;
	bool					m_bLock;
	bool					m_bShowAdapt;
	
private:
	void ChangeItemCount(unsigned int unItemCount);
	
protected:
	void draw(); override
};


#endif // _UI_ITEM_BUTTON_H_ZJH_