/*
 *  GameNewItemBag.m
 *  DragonDrive
 *
 *  Created by jhzheng on 11-8-6.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */
 
#include "GameNewItemBag.h"
#include "GameItemBag.h"
#include "ImageNumber.h"
#include "define.h"
#include "NDUtility.h"
#include "ItemImage.h"
#include "NDDataTransThread.h"
#include "NDTransData.h"
#include "NDUISynLayer.h"
#include "NDMsgDefine.h"
#include "NDUIDialog.h"
#include "NDPlayer.h"
#include "CGPointExtension.h"
#include <sstream>

IMPLEMENT_CLASS(NewGameItemBag, NDUILayer)

int NewGameItemBag::m_iTotalPage = 0;

NewGameItemBag::NewGameItemBag()
{
	m_backlayer = NULL;
	memset(m_arrCellInfo, 0, sizeof(CellInfo*)*NEW_MAX_CELL_PER_PAGE*NEW_MAX_PAGE_COUNT);
	m_lbTitle = NULL;
	memset(m_btnPages, 0, sizeof(NDUIButton*)*NEW_MAX_PAGE_COUNT);
	memset(m_picPages, 0, sizeof(NDPicture*)*NEW_MAX_PAGE_COUNT);
	m_iCurpage = 0;
	m_iFocusIndex = 0;
	m_iTotalPage = 0; 
	memset(m_imagePages, 0, sizeof(NDUIImage*)*NEW_MAX_PAGE_COUNT);
	m_itemfocus = NULL;
	
	m_imageMouse = NULL;
	m_pageLayer = NULL;
	
	m_picPlan = NULL;
	
	m_picDel = NULL;
	
	m_btnPlanOrDel = NULL;
	
	memset(m_imageNumInfo, 0, sizeof(m_imageNumInfo));
	
	m_showMoney = false;
	m_tidyupEnable = true;
}

NewGameItemBag::~NewGameItemBag()
{	
	//for (int i = 0; i < MAX_PAGE_COUNT; i++)
	//	{
	//		SAFE_DELETE(m_picPages[i]);
	//	}
	
	SAFE_DELETE(m_itemfocus);
}

void NewGameItemBag::Initialization(vector<Item*>& itemlist, bool showMoney/*=false*/, bool tidyupEnable/* = true*/)
{
	NDUILayer::Initialization();
	//this->SetBackgroundColor(NEW_BKCOLOR4);
	
	m_showMoney = showMoney;
	m_tidyupEnable = tidyupEnable;
	
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	NDPicture *picBg = pool.AddPicture(GetImgPathNew("bag_bag_bg.png"));
	
	NDUIImage* imageBg = new NDUIImage;
	
	imageBg->Initialization();
	
	imageBg->SetPicture(picBg, true);
	
	imageBg->SetFrameRect(CGRectMake(0, 0, picBg->GetSize().width, picBg->GetSize().height));
	
	imageBg->EnableEvent(false);
	
	this->AddChild(imageBg);
	
	m_backlayer = new NDUILayer;
	m_backlayer->Initialization();
	m_backlayer->SetBackgroundColor(ccc4(129, 98, 54, 255));
	m_backlayer->SetFrameRect(CGRectMake(5, NEW_ITEM_BAG_H-9-20, NEW_ITEM_BAG_W-34, 20));
	this->AddChild(m_backlayer);
	
	m_lbTitle = new NDUILabel; 
	m_lbTitle->Initialization(); 
	m_lbTitle->SetText(""); 
	m_lbTitle->SetFontSize(13); 
	m_lbTitle->SetTextAlignment(LabelTextAlignmentCenter); 
	m_lbTitle->SetFrameRect(CGRectMake(0, 0, NEW_ITEM_BAG_W, 20));
	m_lbTitle->SetFontColor(ccc4(253, 253, 253, 255));//ccc4(16, 56, 66,255));
	m_backlayer->AddChild(m_lbTitle);
	
	if (showMoney) 
	{
		m_lbTitle->EnableDraw(false);
		
		InitMoney(m_backlayer);
	}
	
	int iPageInter = 2, iPageStartY = (NEW_ITEM_BAG_H-59*4-iPageInter*3)/2; // iPageW = 33, iPageH = 55, 
	m_pageLayer = new NDUILayer;
	m_pageLayer->Initialization();
	m_pageLayer->SetBackgroundColor(ccc4(255, 255, 255, 0));
	m_pageLayer->SetFrameRect(CGRectMake(NEW_ITEM_BAG_W-31, iPageStartY, 31, (55+iPageInter)*4));
	this->AddChild(m_pageLayer);
	for (int i = 0; i < NEW_MAX_PAGE_COUNT; i++)
	{
		NDPicture *pic = GetPagePic(i+1, false);
		NDPicture *picSel = GetPagePic(i+1, true);
		CGSize size = pic->GetSize();
		CGSize sizeSel = picSel->GetSize();
		//m_picPages[i] = PictureNumber::SharedInstance()->TitleGoldNumber(i+1);
		m_btnPages[i] = new NDUIButton;
		m_btnPages[i]->Initialization();
		m_btnPages[i]->SetDelegate(this);
		m_btnPages[i]->SetTouchDownColor(ccc4(0, 0, 0, 0));
		m_btnPages[i]->SetBackgroundPicture(pic, NULL, false, CGRectZero, true);
		m_btnPages[i]->SetFocusImage(picSel, true, CGRectMake((size.width-sizeSel.width)/2, (size.height-sizeSel.height)/2, sizeSel.width, sizeSel.height), true);
		m_btnPages[i]->SetFrameRect(CGRectMake(0, (size.height+iPageInter)*i, size.width, size.height));
		//m_btnPages[i]->SetFocusColor(ccc4(20, 59, 64, 255));
		m_btnPages[i]->SetBackgroundColor(ccc4(56, 110, 110, 255));
		m_btnPages[i]->CloseFrame();
		m_pageLayer->AddChild(m_btnPages[i]);
	}
	
	/*
	for (int i = 0; i < NEW_MAX_PAGE_COUNT; i++)
	{
		m_imagePages[i] = new NDUIImage;
		m_imagePages[i]->Initialization();
		m_imagePages[i]->SetPicture(m_picPages[i]);
		CGSize size = m_picPages[i]->GetSize();
		CGRect rect = m_btnPages[i]->GetFrameRect();
		m_imagePages[i]->SetFrameRect(CGRectMake( rect.origin.x+(rect.size.width-size.width)/2,
												 rect.origin.y+(rect.size.height-size.height)/2, 
												 size.width, size.height));
		this->AddChild(m_imagePages[i]);
	}
	*/
	//this->SetFocus(m_btnPages[0]);
	
	// 设置数据
	vector<Item*>::iterator it = itemlist.begin();
	int iIndex = 0;
	for (; it != itemlist.end(); it++, iIndex++)
	{
		if (iIndex >= NEW_MAX_CELL_PER_PAGE*NEW_MAX_PAGE_COUNT)
		{
			break;
		}
		
		if (iIndex == 0)
		{
			m_lbTitle->SetText((*it)->getItemDesc().c_str());
		}
		
		InitCellItem(iIndex, *it, false);
	}
	
	// 初始化第一页
	if (iIndex < NEW_MAX_CELL_PER_PAGE)
	{
		InitCellItem(iIndex, NULL, false);
	}
	
	ShowPage(0);
	
	m_itemfocus = new ItemFocus;
	m_itemfocus->Initialization();
	m_itemfocus->EnableEvent(false);
	this->AddChild(m_itemfocus,1);
	if (m_arrCellInfo[0])
	{
		m_itemfocus->SetFrameRect(m_arrCellInfo[0]->GetFrameRect());
	}
	
	m_imageMouse = new NDUIImage;
	
	m_imageMouse->Initialization();
	
	m_imageMouse->EnableEvent(false);
	
	this->AddChild(m_imageMouse, 2);
	
	m_picPlan = pool.AddPicture(GetImgPathNew("bag_bagzhengli.png"), true);
	
	m_picDel = pool.AddPicture(GetImgPathNew("trash_open.png"));
	
	m_btnPlanOrDel = new NDUIButton;
	m_btnPlanOrDel->Initialization();
	m_btnPlanOrDel->SetImage(m_picPlan);
	m_btnPlanOrDel->SetDelegate(this);
	m_btnPlanOrDel->SetFrameRect(CGRectMake(10+(NEW_ITEM_CELL_INTERVAL_W+NEW_ITEM_CELL_W)*0,
											10+(NEW_ITEM_CELL_INTERVAL_H+NEW_ITEM_CELL_H)*(NEW_ITEM_BAG_R-1), 
											NEW_ITEM_CELL_W, NEW_ITEM_CELL_H));
	this->AddChild(m_btnPlanOrDel);
	
	if (!m_tidyupEnable) 
	{
		m_btnPlanOrDel->EnalbeGray(true);
	}
	//NewGameItemBagDelegate* delegate = dynamic_cast<NewGameItemBagDelegate*> (this->GetDelegate());
	//	bool bDelegateRet = true;
	//	if (delegate && m_arrCellInfo[0]->item) 
	//	{
	//		bDelegateRet = delegate->OnClickCell(this, m_iCurpage, iIndex, m_arrCellInfo[iIndex]->item, false );
	//	}
	
}
void NewGameItemBag::draw()
{
	NDUILayer::draw();
	//if (m_iFocusIndex != -1)
	//	{
	//		m_itemfocus->Update();
	//	}
	if (m_itemfocus) m_itemfocus->SetVisible(false);
}

void NewGameItemBag::OnButtonClick(NDUIButton* button)
{
	if (m_iTotalPage < 1)
	{
		return;
	}
	
	if (button == m_btnPlanOrDel) 
	{
		if (m_btnPlanOrDel->IsGray()) return;
		
		if (NDPlayer::defaultHero().IsInState(USERSTATE_BOOTH))
		{
			showDialog(NDCommonCString("tip"), NDCommonCString("BoothCantSortBag"));
		}else
		{
			bool findItem = false;
			for (int i = 0; i < NEW_MAX_PAGE_COUNT; i++)
			{
				for (int j = 0; j < NEW_MAX_CELL_PER_PAGE; j++)
				{
					int iIndex = i*NEW_MAX_CELL_PER_PAGE+j;
					
					if (iIndex >= m_iTotalPage*NEW_MAX_CELL_PER_PAGE)
					{
						break;
					}
					
					if (m_arrCellInfo[iIndex] && m_arrCellInfo[iIndex]->GetItem())
					{
						findItem = true;
					}
				}
			}
			
			if (!findItem) return;
			
			ShowProgressBar;
			NDTransData bao(_MSG_TIDY_UP_BAG);
			SEND_DATA(bao);
		}
	}
	
	for (int i=0; i < NEW_MAX_PAGE_COUNT; i++)
	{
		if ( button == m_btnPages[i])
		{
			if ( i <= m_iTotalPage-1 )
			{
				//切换页
				ShowPage( i+1 > m_iTotalPage ? 0 : i);
				
				int iStartIndex = i == 0 ? 0 : (i)*NEW_MAX_CELL_PER_PAGE;
				int iEndIndex = (i+1)*NEW_MAX_CELL_PER_PAGE;
				if (m_iFocusIndex >= iStartIndex && m_iFocusIndex < iEndIndex)
				{}
				else
				{
					m_iFocusIndex = -1;
					m_itemfocus->SetFrameRect(CGRectZero);
					m_lbTitle->SetText("");
					
					this->SetFocus(NULL);
				}
				
				m_iCurpage = i;
			}
			
			NewGameItemBagDelegate* delegate = dynamic_cast<NewGameItemBagDelegate*> (this->GetDelegate());
			if (delegate) 
			{
				delegate->OnClickPage(this, i);
			}
			
			if (i >= m_iTotalPage)
			{
				stringstream ss; ss << NDCommonCString("KaiTongBag") << (i+1) << NDCommonCString("NeedSpend");
				if (i == 1) {
					ss << 200;
				} else if (i == 2) {
					ss << 500;
				} else if (i == 3) {
					ss << 1000;
				}
				
				ss << NDCommonCString("ge") << NDCommonCString("emoney");
				
				NDUIDialog *dlg = new NDUIDialog;
				dlg->Initialization();
				dlg->SetDelegate(this);
				dlg->Show("", ss.str().c_str(), NDCommonCString("Cancel"), NDCommonCString("Ok"), NULL);
			}
			
			m_pageLayer->SetFocus(m_btnPages[m_iCurpage]);
			
			return;
		}
		
		
	}
	
	if (m_iCurpage >= NEW_MAX_PAGE_COUNT)
	{
		NDLog(@"物品包当前页出错!!!");
		return;
	}
	
	int iIndex = m_iCurpage*NEW_MAX_CELL_PER_PAGE;
	
	for (; iIndex < (m_iCurpage+1)*NEW_MAX_CELL_PER_PAGE; iIndex++)
	{
		if (m_arrCellInfo[iIndex] == button)
		{
			NewGameItemBagDelegate* delegate = dynamic_cast<NewGameItemBagDelegate*> (this->GetDelegate());
			bool bDelegateRet = true;
			bool bFocus = m_iFocusIndex == iIndex;
			if (delegate) 
			{
				bDelegateRet = delegate->OnClickCell(this, m_iCurpage, iIndex, m_arrCellInfo[iIndex]->GetItem(), bFocus );
			}
			
			if (m_arrCellInfo[iIndex]->GetItem())
			{
				if (( !delegate || !bDelegateRet ))
				{
					m_lbTitle->SetText(m_arrCellInfo[iIndex]->GetItem()->getItemDesc().c_str());
				}
			}
			else 
			{
				m_lbTitle->SetText("");
			}
			
			if (m_iFocusIndex != iIndex)
			{
				m_itemfocus->SetFrameRect(m_arrCellInfo[iIndex]->GetFrameRect());
			}
			
			m_iFocusIndex = iIndex;
			
			
			if (delegate) 
			{
				delegate->AfterClickCell(this, m_iCurpage, iIndex, m_arrCellInfo[iIndex]->GetItem(), bFocus );
			}
			
			return;
		}
	}
	
}

bool NewGameItemBag::OnButtonLongClick(NDUIButton* button)
{
	if (button->IsKindOfClass(RUNTIME_CLASS(NDUIItemButton))) 
	{
		NDUIItemButton *btn = (NDUIItemButton*)button;
		
		Item *item = btn->GetItem();
		
		if (item) 
		{
			if (item->isFormula() || item->isItemPet() || item->isSkillBook())
			{
				sendQueryDesc(item->iID);
			} 
			else
			{
				NDUIDialog *dlg = new NDUIDialog;
				dlg->Initialization();
				std::string strtmp = item->makeItemDes(false, true);
				dlg->Show(item->getItemNameWithAdd().c_str(), strtmp.c_str(), NULL, NULL);
			}	
			
			return true;
		}
	}
	
	return false;
}

bool NewGameItemBag::OnButtonDragOut(NDUIButton* button, CGPoint beginTouch, CGPoint moveTouch, bool longTouch)
{
	if (button->IsKindOfClass(RUNTIME_CLASS(NDUIItemButton)) && m_imageMouse) 
	{
		Item* item = ((NDUIItemButton*)button)->GetItem();
		
		if (!item) 
			return false;
		
		NDPicture* pic = ItemImage::GetItemByIconIndex(item->getIconIndex(), ((NDUIItemButton*)button)->IsGray());
			
		if (pic) pic->SetGrayState(((NDUIItemButton*)button)->IsGray());
		
		m_imageMouse->SetPicture(pic, true);
		
		CGSize size = pic->GetSize();
		
		CGRect scrRect = this->GetScreenRect();
		
		CGPoint point = ccp(moveTouch.x-size.width/2-scrRect.origin.x, moveTouch.y-size.height/2-scrRect.origin.y);
	
		m_imageMouse->SetFrameRect(CGRectMake(point.x, point.y, pic->GetSize().width, pic->GetSize().height));
		
		ShowDel(true);
		
		return true;
	}
	
	return false;
}

bool NewGameItemBag::OnButtonDragOutComplete(NDUIButton* button, CGPoint endTouch, bool outOfRange)
{
	if (m_imageMouse)
		m_imageMouse->SetPicture(NULL, true);
	
	ShowDel(false);
	
	return false;
}

bool NewGameItemBag::OnButtonDragIn(NDUIButton* desButton, NDUINode *uiSrcNode, bool longTouch)
{
	if (uiSrcNode->GetParent() != this) 
	{ // 
		NewGameItemBagDelegate *delegate = dynamic_cast<NewGameItemBagDelegate*> (this->GetDelegate());
		
		if (delegate) 
			return delegate->OnBagButtonDragIn(desButton, uiSrcNode, longTouch, desButton == m_btnPlanOrDel);
		
		return false;
	}
	
	if (uiSrcNode == desButton) return false;
	
	if (!uiSrcNode->IsKindOfClass(RUNTIME_CLASS(NDUIItemButton))) return false;
	
	NDUIItemButton *srcButton = (NDUIItemButton*)uiSrcNode;
	
	if (desButton == m_btnPlanOrDel ) 
	{
		 if (m_btnPlanOrDel->IsGray()) return false;
		 
		// 丢物品
		Item* item = srcButton->GetItem();
		
		if (!item) return false;
		
		NewGameItemBagDelegate *delegate = dynamic_cast<NewGameItemBagDelegate*> (this->GetDelegate());
		
		if (delegate) 
			return delegate->OnDropItem(this, item);
	}
	else
	{ // swap
		if (!desButton || !desButton->IsKindOfClass(RUNTIME_CLASS(NDUIItemButton))) return false;
		
		if (desButton->GetParent() != this) return false;
		
		NDUIItemButton *dstItemButton = (NDUIItemButton*)desButton;
		
		Item* tmpItem = dstItemButton->GetItem();
		bool gray = dstItemButton->IsGray();
		
		dstItemButton->ChangeItem(srcButton->GetItem(), srcButton->IsGray());
		dstItemButton->EnalbeGray(srcButton->IsGray());
		
		srcButton->ChangeItem(tmpItem, gray);
		srcButton->EnalbeGray(gray);
		
		return true;
	}
	
	return false;
}

void NewGameItemBag::OnDialogButtonClick(NDUIDialog* dialog, unsigned int buttonIndex)
{
	// 开通背包
	ShowProgressBar;
	NDTransData bao(_MSG_LIMIT);
	bao << (unsigned char)(1);
	SEND_DATA(bao);
	dialog->Close();
}

void NewGameItemBag::UpdateItemBag(vector<Item*>& itemlist)
{
	if (m_iTotalPage <= 0)
	{
		return;
	}
	
	int iSize = int(itemlist.size());
	
	for (int i = 0; i < NEW_MAX_PAGE_COUNT; i++)
	{
		for (int j = 0; j < NEW_MAX_CELL_PER_PAGE; j++)
		{
			int iIndex = i*NEW_MAX_CELL_PER_PAGE+j;
			if (iIndex < iSize)
			{
				InitCellItem(iIndex, itemlist[iIndex], iIndex%NEW_MAX_CELL_PER_PAGE == m_iCurpage);
			}
			else
			{
				if (iIndex >= m_iTotalPage*NEW_MAX_CELL_PER_PAGE)
				{
					break;
				}
				InitCellItem(iIndex, NULL, iIndex%NEW_MAX_CELL_PER_PAGE == m_iCurpage);
			}
		}
	}
	
	ShowPage(m_iCurpage+1 > m_iTotalPage ? 0 : m_iCurpage);
}

void NewGameItemBag::UpdateItemBag(vector<Item*>& itemlist, vector<int> filter)
{
	vector<Item*> vec_item;
	vector<Item*>::iterator it = itemlist.begin();
	for (; it != itemlist.end(); it++) 
	{
		vector<int> vec_type = Item::getItemType((*it)->iItemType);
		int typesize = vec_type.size();
		int filtersize = filter.size();
		for (int i = 0; i < filtersize; i++) 
		{
			if (i > (typesize-1) || filter[i] != vec_type[i]) 
			{
				break;
			}
			
			if (i == filtersize-1) 
			{
				vec_item.push_back(*it);
			}
		}
	}
	
	UpdateItemBag(vec_item);
}

bool NewGameItemBag::AddItem(Item* item)
{
	for (int i = 0; i < NEW_MAX_PAGE_COUNT; i++)
	{
		for (int j = 0; j < NEW_MAX_CELL_PER_PAGE; j++)
		{
			int iIndex = i*NEW_MAX_CELL_PER_PAGE+j;
			
			if (iIndex >= m_iTotalPage*NEW_MAX_CELL_PER_PAGE)
			{
				break;
			}
			
			if (!m_arrCellInfo[iIndex] || m_arrCellInfo[iIndex]->GetItem()== NULL)
			{
				InitCellItem(iIndex, item, iIndex/NEW_MAX_CELL_PER_PAGE == m_iCurpage);
				return true;
			}
		}
	}
	return false;
}

bool NewGameItemBag::DelItem(int iItemID)
{
	for (int i = 0; i < NEW_MAX_PAGE_COUNT; i++)
	{
		for (int j = 0; j < NEW_MAX_CELL_PER_PAGE; j++)
		{
			int iIndex = i*NEW_MAX_CELL_PER_PAGE+j;
			
			if (iIndex >= m_iTotalPage*NEW_MAX_CELL_PER_PAGE)
			{
				break;
			}
			
			if (m_arrCellInfo[iIndex])
			{
				NDUIItemButton*& btn	= m_arrCellInfo[iIndex];
				
				if (btn && btn->GetItem() && btn->GetItem()->iID == iItemID)
				{
					btn->ChangeItem(NULL);
					
					if (m_iFocusIndex == iIndex)
					{
						m_lbTitle->SetText("");
					}
					return true;
				}
			}
		}
	}
	
	return false;
}

bool NewGameItemBag::AddItemByIndex(int iCellIndex, Item* item)
{
	if (!m_arrCellInfo[iCellIndex])
	{
		InitCellItem(iCellIndex, item, iCellIndex%NEW_MAX_CELL_PER_PAGE == m_iCurpage);
		return true;
	}
	return false;
}

bool NewGameItemBag::DelItemByIndex(int iCellIndex)
{
	if (m_arrCellInfo[iCellIndex])
	{
		m_arrCellInfo[iCellIndex]->ChangeItem(NULL);
		
		return true;
	}
	return false;
}

bool NewGameItemBag::IsFocus()
{
	return m_iFocusIndex != -1;
}

void NewGameItemBag::DeFocus()
{
	m_iFocusIndex = -1;
	m_itemfocus->SetFrameRect(CGRectZero);
}

void NewGameItemBag::SetTitle(string title)
{
	if (m_lbTitle)
	{
		m_lbTitle->SetText(title.c_str());
	}
}

void NewGameItemBag::SetTitleColor(ccColor4B color)
{
	if (m_lbTitle)
	{
		m_lbTitle->SetFontColor(color);
	}
}

Item* NewGameItemBag::GetFocusItem()
{
	if (m_iFocusIndex > -1 && m_arrCellInfo[m_iFocusIndex])
	{
		return m_arrCellInfo[m_iFocusIndex]->GetItem();
	}
	
	return NULL;
}

NDUIItemButton* NewGameItemBag::GetFocusItemBtn()
{
	if (m_iFocusIndex > -1 && m_arrCellInfo[m_iFocusIndex])
	{
		return m_arrCellInfo[m_iFocusIndex];
	}
	
	return NULL;
}

void NewGameItemBag::UpdateTitle()
{
	if (m_iFocusIndex != -1 && m_arrCellInfo[m_iFocusIndex] && m_arrCellInfo[m_iFocusIndex]->GetItem())
	{
		NewGameItemBagDelegate* delegate = dynamic_cast<NewGameItemBagDelegate*> (this->GetDelegate());
		bool bDelegateRet = false;
		if (delegate && !m_showMoney) 
		{
			bDelegateRet = delegate->OnClickCell(this, m_iCurpage, m_iFocusIndex, m_arrCellInfo[m_iFocusIndex]->GetItem(), false );
		}
		
		if (m_arrCellInfo[m_iFocusIndex]->GetItem())
		{
			if (( !delegate || !bDelegateRet ))
			{
				m_lbTitle->SetText(m_arrCellInfo[m_iFocusIndex]->GetItem()->getItemDesc().c_str());
			}
		}
	}
}

void NewGameItemBag::UpdateMoney()
{
	NDPlayer& player = NDPlayer::defaultHero();
	int valueInfo[3];
	valueInfo[0] = player.eMoney;
	valueInfo[1] = player.money;
	valueInfo[2] = player.jifeng;
	
	for (int i = 0; i < 3; i++) 
	{
		if (m_imageNumInfo[i])
		{
			m_imageNumInfo[i]->SetSmallGoldNumber(valueInfo[i]);
			
			if (!this->IsVisibled()) 
			{
				m_imageNumInfo[i]->SetVisible(false);
			}
		}
	}
}

Item* NewGameItemBag::GetItem(int iPage, int iIndex)
{
	if (iPage >= m_iTotalPage || !(iIndex >= 0 && iIndex < NEW_MAX_CELL_PER_PAGE)) 
	{
		return NULL;
	}
	
	if (m_arrCellInfo[iPage*NEW_MAX_CELL_PER_PAGE+iIndex]) 
	{
		return m_arrCellInfo[iPage*NEW_MAX_CELL_PER_PAGE+iIndex]->GetItem();
	}
	
	return NULL;
}

void NewGameItemBag::ShowPage(int iPage)
{
	if (iPage >= NEW_MAX_PAGE_COUNT && iPage+1 <= m_iTotalPage)
	{
		return;
	}
	
	int iIndex = iPage*NEW_MAX_CELL_PER_PAGE;
	
	for (; iIndex < (iPage+1)*NEW_MAX_CELL_PER_PAGE; iIndex++)
	{
		if (!m_arrCellInfo[iIndex])
		{
			InitCellItem(iIndex, NULL, true);
		}
		
		if (m_arrCellInfo[iIndex])
		{
			m_arrCellInfo[iIndex]->SetVisible(true);
		}
	}
	
	HidePage(iPage);
	/*
	for (int i = 0; i < NEW_MAX_PAGE_COUNT; i++)
	{
		if (!m_btnPages[i]) 
		{
			continue;
		}
		if (i == iPage) 
		{
			m_btnPages[i]->SetBackgroundColor(ccc4(20, 59, 64, 255));
		}
		else 
		{
			m_btnPages[i]->SetBackgroundColor(ccc4(56, 110, 110, 255));
		}
		
	}
	*/
	
	if (m_pageLayer && m_btnPages[iPage]) 
		m_pageLayer->SetFocus(m_btnPages[iPage]);
}

void NewGameItemBag::HidePage(int iExceptPage)
{
	if (iExceptPage >= NEW_MAX_PAGE_COUNT || iExceptPage < 0)
	{
		return;
	}
	
	for (int i = 0; i < NEW_MAX_PAGE_COUNT; i++)
	{
		if (i == iExceptPage)
		{
			continue;
		}
		
		int iIndex = i*NEW_MAX_CELL_PER_PAGE;
		
		for (; iIndex < (i+1)*NEW_MAX_CELL_PER_PAGE; iIndex++)
		{
			if (m_arrCellInfo[iIndex])
			{
				m_arrCellInfo[iIndex]->SetVisible(false);
			}
		}
	}
}

void NewGameItemBag::InitCellItem(int iIndex, Item* item, bool bShow)
{
	if (iIndex<0 || iIndex>=NEW_MAX_CELL_PER_PAGE*NEW_MAX_PAGE_COUNT)
	{
		NDLog(@"初始化物品格子参数有误!!!");
		return;
	}
	
	if (!m_arrCellInfo[iIndex])
	{
		int col = iIndex%NEW_MAX_CELL_PER_PAGE%NEW_ITEM_BAG_C;
		int row = iIndex%NEW_MAX_CELL_PER_PAGE/NEW_ITEM_BAG_C;
		
		if (row == NEW_ITEM_BAG_R-1)
		{
			col += 1;
		}
		
		m_arrCellInfo[iIndex] = new NDUIItemButton;
		m_arrCellInfo[iIndex]->Initialization();
		m_arrCellInfo[iIndex]->SetFrameRect(CGRectMake(10+(NEW_ITEM_CELL_INTERVAL_W+NEW_ITEM_CELL_W)*col,
													   10+(NEW_ITEM_CELL_INTERVAL_H+NEW_ITEM_CELL_H)*row, 
													   NEW_ITEM_CELL_W, NEW_ITEM_CELL_H));
		m_arrCellInfo[iIndex]->SetDelegate(this);
		this->AddChild(m_arrCellInfo[iIndex]);
	}
	
	m_arrCellInfo[iIndex]->ChangeItem(item);
	
	m_arrCellInfo[iIndex]->SetVisible(bShow);
}

void NewGameItemBag::UpdateBagNum(int iNum)
{
	if(iNum<=0) return; m_iTotalPage = iNum > NEW_MAX_PAGE_COUNT ? NEW_MAX_PAGE_COUNT : iNum;
}

NDPicture* NewGameItemBag::GetPagePic(unsigned int num, bool bHightLight)
{
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	NDPicture *pic = pool.AddPicture(GetImgPathNew("bag_bag_unsel.png"));
	NDPicture *picSel = pool.AddPicture(GetImgPathNew("bag_bag_sel.png"));
	NDPicture *picNum = pool.AddPicture(GetImgPathBattleUI("bag_number.png"));
	
	CGSize size = pic->GetSize(), sizeSel = picSel->GetSize();
		
	vector<const char*> vImgFiles;
	vector<CGRect> vImgCustomRect;
	vector<CGPoint>vOffsetPoint;
	vImgFiles.push_back(GetImgPathNew(bHightLight ? "bag_bag_sel.png" : "bag_bag_unsel.png"));
	vImgCustomRect.push_back(CGRectMake(0, 0, (bHightLight ? sizeSel.width : size.width), (bHightLight ? sizeSel.height : size.height)));
	vOffsetPoint.push_back(CGPointZero);
	vImgFiles.push_back(GetImgPathBattleUI("bag_number.png"));
	vImgCustomRect.push_back(getNewNumCut(num, bHightLight));
	CGPoint pos;
	pos.x = ((bHightLight ? sizeSel.width : size.width)-14)/2+(bHightLight ? 2 : 0);
	pos.y = ((bHightLight ? sizeSel.height : size.height)-14)/2;
	vOffsetPoint.push_back(pos);
	
	NDPicture* resPic = new NDPicture;
	
	resPic->Initialization(vImgFiles, vImgCustomRect, vOffsetPoint);
	
	delete pic;
	delete picSel;
	delete picNum;
	
	return resPic;
}

void NewGameItemBag::InitMoney(NDUINode* parent)
{
	if (!parent) return;
	
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	NDPicture *picEMoney = pool.AddPicture(GetImgPathNew("bag_bagemoney.png"));
	
	NDPicture *picMoney = pool.AddPicture(GetImgPathNew("bag_bagmoney.png"));
	
	NDPicture *picJiFeng = pool.AddPicture(GetImgPathNew("bag_jifeng.png"));
	
	unsigned int interval = 8;
	
	NDPicture* tmpPics[3];
	
	tmpPics[0] = picEMoney;
	
	tmpPics[1] = picMoney;
	
	tmpPics[2] = picJiFeng;
	
	int width = parent->GetFrameRect().size.width,
		height = parent->GetFrameRect().size.height,
		framewidth = (width-interval*4)/3;
		
	NDPlayer& player = NDPlayer::defaultHero();
	int valueInfo[3];
	valueInfo[0] = player.eMoney;
	valueInfo[1] = player.money;
	valueInfo[2] = player.jifeng;
		
	for (int i = 0; i < 3; i++) 
	{
		CGSize sizePic = tmpPics[i]->GetSize();
		int startx = interval+i*(framewidth+interval),
			imageY = (height-sizePic.height)/2,
			numY = (height-PictureNumber::SharedInstance()->GetSmallGoldSize().height)/2;
		NDUIImage *image = new NDUIImage;
		image->Initialization();
		image->SetPicture(tmpPics[i], true);
		image->SetFrameRect(CGRectMake(startx, imageY, sizePic.width,sizePic.height));
		parent->AddChild(image);
		
		m_imageNumInfo[i] = new ImageNumber;
		m_imageNumInfo[i]->Initialization();
		m_imageNumInfo[i]->SetFrameRect(CGRectMake(startx+sizePic.width+2, numY, width, height));
		m_imageNumInfo[i]->SetSmallGoldNumber(valueInfo[i]);
		parent->AddChild(m_imageNumInfo[i]);
	}
}

void NewGameItemBag::ShowDel(bool show)
{
	if (m_btnPlanOrDel && !m_btnPlanOrDel->IsGray()) 
	{
		m_btnPlanOrDel->SetImage( show ? m_picDel : m_picPlan);
	}
}

NDUIItemButton* NewGameItemBag::GetItemBtnByItem(Item* item)
{
	for (int i = 0; i < NEW_MAX_PAGE_COUNT; i++)
	{
		for (int j = 0; j < NEW_MAX_CELL_PER_PAGE; j++) 
		{
			if (m_arrCellInfo[i*NEW_MAX_CELL_PER_PAGE+j] &&
				m_arrCellInfo[i*NEW_MAX_CELL_PER_PAGE+j]->GetItem() == item)
				return m_arrCellInfo[i*NEW_MAX_CELL_PER_PAGE+j];
		}
	}
	
	return NULL;
}

NDUIItemButton* NewGameItemBag::GetItemButtonByItemID(int iItemID)
{
	for (int i = 0; i < NEW_MAX_PAGE_COUNT; i++)
	{
		for (int j = 0; j < NEW_MAX_CELL_PER_PAGE; j++)
		{
			int iIndex = i*NEW_MAX_CELL_PER_PAGE+j;
			
			if (iIndex >= m_iTotalPage*NEW_MAX_CELL_PER_PAGE)
			{
				break;
			}
			
			if (m_arrCellInfo[iIndex])
			{
				NDUIItemButton*& btn	= m_arrCellInfo[iIndex];
				
				if (btn && btn->GetItem() && btn->GetItem()->iID == iItemID)
				{
					return btn;
				}
			}
		}
	}
	
	return NULL;
}

bool NewGameItemBag::SetItemAmountByID(int iItemID, unsigned int amount)
{
	NDUIItemButton* btn = GetItemButtonByItemID(iItemID);
	if (btn) {
		btn->SetItemCount(amount);
		
		return true;
	}
	
	return false;
}

bool NewGameItemBag::SetItemAmount(Item* item, unsigned int amount)
{
	NDUIItemButton* btn = GetItemBtnByItem(item);
	if (btn) {
		btn->SetItemCount(amount);
		
		return true;
	}
	
	return false;
}

