/*
 *  NDCommonScene.mm
 *  DragonDrive
 *
 *  Created by jhzheng on 11-8-11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "NDCommonScene.h"
#include "NDDirector.h"
#include "NDUtility.h"
#include "CGPointExtension.h"
#include "NDUIImage.h"

//////////////////////////////////////////////////////////////
#pragma mark tab 节点

IMPLEMENT_CLASS(TabNode, NDUINode)

TabNode::TabNode()
{
	m_lbText = NULL;
	
	m_pic = m_picFocus = m_picFocusSel = NULL;
	
	m_focus = false;
	
	m_focusTextColor = false;
	
	m_textColor = ccc4(0, 0, 0, 255);
	
	m_focusColor = ccc4(0, 0, 0, 255);
	
	m_bHorizontal = true;
	
	m_uiVerticalOffect = 0;
	
	m_picText = NULL;
	
	m_picFocusText = NULL;
}

TabNode::~TabNode()
{
	SAFE_DELETE(m_pic);
	
	SAFE_DELETE(m_picFocus);
	
	SAFE_DELETE(m_picFocusSel);
}
	
void TabNode::Initialization()
{
	NDUINode::Initialization();
}

// interface begin ...
void TabNode::SetImage(NDPicture *pic, NDPicture *focusPic, NDPicture* selPic/*=NULL*/)
{
	if (m_pic) delete m_pic;
	
	if (m_picFocus) delete m_picFocus;
	
	if (m_picFocusSel) delete m_picFocusSel;
	
	m_pic = pic; m_picFocus = focusPic; m_picFocusSel = selPic;
}

void TabNode::SetText(const char *text)
{
	if (!text) return;
	
	if (!m_lbText) InitLabel();
	
	m_lbText->SetText(text);
}

void TabNode::SetTextColor(ccColor4B color, bool setBoder/*=false*/, ccColor4B colorBoder/*=ccc4(255, 255, 255, 255)*/)
{
	if (!m_lbText) InitLabel();
	
	m_lbText->SetFontColor(color);
	
	m_textColor = color;
}

void TabNode::SetFocusColor(ccColor4B color, bool setBoder/*=false*/, ccColor4B colorBoder/*=ccc4(255, 255, 255, 255)*/)
{
	if (!m_lbText) InitLabel();
	
	m_focusColor = color;
	
	m_focusTextColor = true;
}

void TabNode::SetTextFontSize(unsigned int fontsize, bool horzontal/*=true*/, unsigned int verticalOffset/*=0*/)
{
	if (!m_lbText) InitLabel();
	
	m_lbText->SetFontSize(fontsize);
	
	if (!horzontal)
	{
		CGRect rect = m_lbText->GetFrameRect();
		
		rect.origin.x = (rect.size.width-fontsize)/2;
		
		rect.size.width = fontsize;
		
		m_lbText->SetFrameRect(rect);
	}
	
	m_bHorizontal = horzontal;
	
	m_uiVerticalOffect = verticalOffset;
}

void TabNode::SetFocus(bool focus)
{
	m_focus = focus;
}

void TabNode::SetTextPicture(NDPicture* picText, NDPicture* picFocusText)
{
	SAFE_DELETE(m_picText);
	
	SAFE_DELETE(m_picFocusText);
	
	m_picText = picText;
	
	m_picFocusText = picFocusText;
}

// interface end ...

void TabNode::draw()
{
	if (!this->IsVisibled()) return;
	
	CGRect scrRect = this->GetScreenRect();
	
	if (m_focus) 
	{
		if (m_picFocus)
		{
			CGSize picSize = m_picFocus->GetSize();
			
			CGRect rect;
			
			rect.origin = ccp(scrRect.origin.x+scrRect.size.width-picSize.width, 
								 scrRect.origin.y+(scrRect.size.height-picSize.height)/2);
			rect.size = picSize;
			
			m_picFocus->DrawInRect(rect);
			
			if (m_picFocusText) 
			{
				CGSize size = m_picFocusText->GetSize();
				
				rect.origin.x += (rect.size.width-size.width)/2;
				
				rect.origin.y += (rect.size.height-size.height)/2;
				
				rect.size = size;
				
				m_picFocusText->DrawInRect(rect);
			}
		}
			
		if (m_picFocusSel)
			m_picFocusSel->DrawInRect(CGRectMake(scrRect.origin.x+scrRect.size.width/4,
											  scrRect.origin.y+scrRect.size.height+2,
											  scrRect.size.width/2, m_picFocusSel->GetSize().height));
											  
		if (m_lbText)
		{ 
			if (m_focusTextColor)
				m_lbText->SetFontColor(m_focusColor);
			
			if (m_bHorizontal && m_picFocus) 
			{
				CGSize size = m_picFocus->GetSize();
				
				m_lbText->SetFrameRect(CGRectMake(scrRect.size.width-size.width, 
												  scrRect.size.height-size.height, 
												  size.width, 
												  size.height));
			}
			else if (!m_bHorizontal && m_picFocus) 
			{
				CGSize size = m_picFocus->GetSize();
				
				CGRect rect = m_lbText->GetFrameRect();
				
				unsigned int fontsize = m_lbText->GetFontSize();
				
				CGSize sizefoucus = m_picFocus ? m_picFocus->GetSize() : CGSizeZero;
				
				rect.origin = ccp((size.width-fontsize)/2, (size.height-sizefoucus.height)/2);
				
				rect.size.height = size.height;
				
				m_lbText->SetFrameRect(rect);
			}
		}
	}
	else
	{
		if (m_lbText)
		{
			if (m_focusTextColor)
				m_lbText->SetFontColor(m_textColor);
				
			if (m_bHorizontal && m_pic) 
			{
				CGSize size = m_pic->GetSize();
				
				
				
				m_lbText->SetFrameRect(CGRectMake(scrRect.size.width-size.width, 
												  scrRect.size.height-size.height, 
												  size.width, 
												  size.height));
			}
			else if (!m_bHorizontal)
			{
				CGSize size = m_pic->GetSize();
				
				CGRect rect = m_lbText->GetFrameRect();
				
				unsigned int fontsize = m_lbText->GetFontSize();
				
				rect.origin = ccp((size.width-fontsize)/2+m_uiVerticalOffect, 0);
				
				rect.size.height = size.height;
				
				m_lbText->SetFrameRect(rect);
			}
		}
		
		if (m_pic)
		{
			CGSize picSize = m_pic->GetSize();
			
			scrRect.origin = ccp(scrRect.origin.x+scrRect.size.width-picSize.width, 
								 scrRect.origin.y+scrRect.size.height-picSize.height);
			scrRect.size = picSize;
			
			m_pic->DrawInRect(scrRect);
			
			if (m_picText) 
			{
				CGSize size = m_picText->GetSize();
				
				scrRect.origin.x += (scrRect.size.width-size.width)/2;
				
				scrRect.origin.y += (scrRect.size.height-size.height)/2;
				
				scrRect.size = size;
				
				m_picText->DrawInRect(scrRect);
			}
		}
	}
}

void TabNode::InitLabel()
{
	if (!m_lbText) 
	{
		m_lbText = new NDUILabel;
		
		m_lbText->Initialization();
		
		m_lbText->SetTextAlignment(LabelTextAlignmentCenter);
		
		CGSize size = this->GetFrameRect().size;
		
		m_lbText->SetFrameRect(CGRectMake(0, 0, size.width, size.height));
		
		this->AddChild(m_lbText);
	}
}

IMPLEMENT_CLASS(VerticalTabNode, TabNode)

VerticalTabNode::VerticalTabNode()
{
	m_iFocusOffset = 0;
}

void VerticalTabNode::SetFoucusOffset(int offset)
{
	m_iFocusOffset = offset;
}

void VerticalTabNode::draw()
{
	if (!this->IsVisibled()) return;
	
	CGRect scrRect = this->GetScreenRect();
	
	if (m_focus) 
	{
		if (m_picFocus)
		{
			CGSize picSize = m_picFocus->GetSize();
			
			CGRect rect;
			
			rect.origin = ccp(scrRect.origin.x+scrRect.size.width-picSize.width, 
							  scrRect.origin.y+(scrRect.size.height-picSize.height)/2+m_iFocusOffset);
			rect.size = picSize;
			
			m_picFocus->DrawInRect(rect);
			
			if (m_picFocusText) 
			{
				CGSize size = m_picFocusText->GetSize();
				
				rect.origin.x += (rect.size.width-size.width)/2;
				
				rect.origin.y += (rect.size.height-size.height)/2;
				
				rect.size = size;
				
				m_picFocusText->DrawInRect(rect);
			}
		}
	}
	else
	{
		if (m_pic)
		{
			CGSize picSize = m_pic->GetSize();
			
			scrRect.origin = ccp(scrRect.origin.x+scrRect.size.width-picSize.width, 
								 scrRect.origin.y+scrRect.size.height-picSize.height);
			scrRect.size = picSize;
			
			m_pic->DrawInRect(scrRect);
			
			if (m_picText) 
			{
				CGSize size = m_picText->GetSize();
				
				scrRect.origin.x += (scrRect.size.width-size.width)/2;
				
				scrRect.origin.y += (scrRect.size.height-size.height)/2;
				
				scrRect.size = size;
				
				m_picText->DrawInRect(scrRect);
			}
		}
	}
}

//////////////////////////////////////////////////////////////
#pragma mark tab容器

IMPLEMENT_CLASS(TabLayer, NDUILayer)

TabLayer::TabLayer()
{
	m_uiFocusIndex = 0;
	
	m_uiInterval = 0;
	
	m_tabNodeSize = CGSizeMake(40, 20);
}

TabLayer::~TabLayer()
{
}

void TabLayer::Initialization(unsigned int interval/*=0*/)
{
	NDUILayer::Initialization();
	
	m_uiInterval = interval;
}

void TabLayer::SetTabNodeSize(CGSize size)
{
	m_tabNodeSize = size;
}

TabNode* TabLayer::CreateTabNode()
{
	return NULL;
}

TabNode* TabLayer::GetTabNode(unsigned int index)
{
	if (index >= m_childrenList.size()) return NULL;
	
	if (!(m_childrenList[index]->IsKindOfClass(RUNTIME_CLASS(TabNode)))) return NULL;
	
	return (TabNode*)(m_childrenList[index]);
}

unsigned int TabLayer::GetTabNodeCount()
{
	size_t size = m_childrenList.size();
	
	unsigned int count = 0;
	
	for (size_t i = 0; i < size; i++) 
	{
		if (m_childrenList[i]->IsKindOfClass(RUNTIME_CLASS(TabNode)))
				count++;
	}
	
	return count;
}

void TabLayer::SetFocusTabIndex(unsigned int index, bool dispatchEvent/*=false*/)
{
	size_t size = m_childrenList.size();
	
	if (m_uiFocusIndex < size) {
		if (!(m_childrenList[m_uiFocusIndex]->IsKindOfClass(RUNTIME_CLASS(TabNode)))) return;
		((TabNode*)(m_childrenList[m_uiFocusIndex]))->SetFocus(false);
	}
	
	if (index < size) {
		if (!(m_childrenList[index]->IsKindOfClass(RUNTIME_CLASS(TabNode)))) return;
		((TabNode*)(m_childrenList[index]))->SetFocus(true);
	}
	
	unsigned int tmpLastIndex = m_uiFocusIndex;
	
	m_uiFocusIndex = index;
	
	if (dispatchEvent) 
	{
		TabLayerDelegate* delegate = dynamic_cast<TabLayerDelegate*> (this->GetDelegate());
		if (delegate) 
		{
			delegate->OnTabLayerSelect(this, tmpLastIndex, index);
		}
	}
	
	
}

void TabLayer::SetFocusTabNode(TabNode* tabnode, bool dispatchEvent/*=false*/)
{
	size_t size = m_childrenList.size();
	
	for (size_t i = 0; i < size; i++) 
	{
		if (tabnode == m_childrenList[i] && m_childrenList[i]->IsKindOfClass(RUNTIME_CLASS(TabNode)))
		{
			SetFocusTabIndex(i, dispatchEvent);
			
			break;
		}
	}
}

unsigned int TabLayer::GetFocusIndex()
{
	return m_uiFocusIndex;
}

CGSize TabLayer::GetTabNodeSize()
{
	return m_tabNodeSize;
}

TabNode* TabLayer::GetFoucusTabNode()
{
	return GetTabNode(m_uiFocusIndex);
}

bool TabLayer::DispatchTouchEndEvent(CGPoint beginTouch, CGPoint endTouch)
{
	for (int i = this->GetChildren().size() - 1; i >= 0; i--) 
	{
		
		NDUINode* uiNode = (NDUINode*)this->GetChildren().at(i);
		
		//un visibled node dont accept event
		if (!uiNode->IsVisibled()) 
		{
			continue;
		}
		
		//un receive event node dont accept event
		if (!uiNode->EventEnabled()) 
		{
			continue;
		}
		
		//un darwed dont accept event
		if (!uiNode->DrawEnabled()) 
		{
			continue;
		}
		
		//not TabNode do not deal any event
		if (!uiNode->IsKindOfClass(RUNTIME_CLASS(TabNode))) 
		{
			continue;
		}	
		
		//touch event deal
		CGRect nodeFrame = uiNode->GetScreenRect();		
		
		if (CGRectContainsPoint(nodeFrame, endTouch)) 
		{
			if (CGRectContainsPoint(nodeFrame, beginTouch)) 
			{
				if ((unsigned int)i == m_uiFocusIndex) 
				{
					TabLayerDelegate* delegate = dynamic_cast<TabLayerDelegate*> (this->GetDelegate());
					if (delegate) 
					{
						delegate->OnTabLayerClick(this, i);
					}
					return true;
				}
				
				//onclick event......
				SetFocusTabIndex(i, true);
				
				return true;
			}
		}
	}		
	return false;
}


//////////////////////////////////////////////////////////////
#pragma mark 水平型tab容器

IMPLEMENT_CLASS(HorizontalTabLayer, TabLayer)

HorizontalTabLayer::HorizontalTabLayer()
{
	m_ShowPage = false;
	
	m_uiCountPerPage = 0;
}

void HorizontalTabLayer::SetFocusTabIndex(unsigned int index, bool dispatchEvent/*=false*/)
{
	if (m_ShowPage && m_uiCountPerPage > 0)
	{
		unsigned int pageIndex = index / m_uiCountPerPage;
		
		size_t size = m_childrenList.size();
		
		for (size_t i = 0; i < size; i++) 
		{
			if (m_childrenList[i]->IsKindOfClass(RUNTIME_CLASS(TabNode)))
			{
				((TabNode*)(m_childrenList[i]))->SetVisible(i / m_uiCountPerPage == pageIndex);
			}
		}
	}
	
	TabLayer::SetFocusTabIndex(index, dispatchEvent);
}

// call before CreateTabNode
void HorizontalTabLayer::SetCountPerPage(unsigned int count)
{
	m_ShowPage = true;
	
	m_uiCountPerPage = count;
}

bool HorizontalTabLayer::IsShowPage()
{
	return m_ShowPage;
}

void HorizontalTabLayer::NextPage()
{
	if (!m_ShowPage || m_uiCountPerPage == 0) return;
	
	unsigned int pageIndex = this->GetFocusIndex() / m_uiCountPerPage;
	
	unsigned int childCount = this->GetTabNodeCount();
	
	unsigned int pageCount = childCount / m_uiCountPerPage + (childCount % m_uiCountPerPage == 0 ? 0 : 1);
	
	unsigned int nextPage = (pageIndex+1) % pageCount;
	
	if (nextPage == pageIndex) return;
	
	TabLayerDelegate *delegate = dynamic_cast<TabLayerDelegate*> (this->GetDelegate());
	if (delegate)
		delegate->OnTabLayerNextPage(this, pageIndex, nextPage);
	
	SetFocusTabIndex(nextPage*m_uiCountPerPage, true);
}

TabNode* HorizontalTabLayer::CreateTabNode()
{
	unsigned int count = this->GetTabNodeCount();
	
	if (m_ShowPage && m_uiCountPerPage > 0)
		count = count%m_uiCountPerPage;
	
	TabNode* node = new TabNode;
	
	node->Initialization();
	
	node->SetFrameRect(CGRectMake(count*(m_tabNodeSize.width+m_uiInterval), 0, m_tabNodeSize.width, m_tabNodeSize.height));
	
	this->AddChild(node);
	
	if (count == 0) 
	{
		node->SetFocus(true);
	}
	
	return node;
}

//////////////////////////////////////////////////////////////
#pragma mark 垂直型tab容器

IMPLEMENT_CLASS(VerticalTabLayer, TabLayer)
	
VerticalTabNode* VerticalTabLayer::CreateTabNode()
{
	unsigned int count = this->GetTabNodeCount();
	
	VerticalTabNode* node = new VerticalTabNode;
	
	node->Initialization();
	
	node->SetFrameRect(CGRectMake(0, count*(m_tabNodeSize.height+m_uiInterval), m_tabNodeSize.width, m_tabNodeSize.height));
	
	if (count == 0)
		this->AddChild(node,1);
	else
		this->AddChild(node);
	
	if (count == 0) 
	{
		node->SetFocus(true);
	}
	
	return node;
}

//////////////////////////////////////////////////////////////
#pragma mark 客户层

IMPLEMENT_CLASS(NDUIClientLayer, NDUIChildrenEventLayer)

NDUIClientLayer::NDUIClientLayer()
{
	m_tab = NULL;
}

NDUIClientLayer::~NDUIClientLayer()
{
}

// 创建一个功能tab标签(仅有一个)
// 使用者对返回的tab作定制
VerticalTabLayer* NDUIClientLayer::CreateFuncTab(unsigned int interval/*=0*/)
{
	if (!m_tab) 
	{
		CGRect rect = this->GetFrameRect();
		
		m_tab = new VerticalTabLayer;
		
		m_tab->Initialization(interval);
		
		m_tab->SetDelegate(this);
		
		this->AddChild(m_tab);
	}
	
	return m_tab;
}

// 获取功能层(调用之前若已创建了tab,则返回对应的标签层)
// 可以加入显示节点
// 至于标签的切换工作(功能层切换)内部完成
NDUILayer* NDUIClientLayer::GetFuncLayer(unsigned int index)
{
	size_t size = m_vClientLayer.size();
	
	CGRect rect = this->GetFrameRect();
	
	if (!m_tab) 
	{
		if (index > 0) return NULL;
		
		if (size == 0) 
		{
			NDUILayer *layer = new NDUILayer;
			
			layer->Initialization();
			
			layer->SetFrameRect(CGRectMake(0, 0, rect.size.width, rect.size.height));
			
			m_vClientLayer.push_back(layer);
		}
		
		return m_vClientLayer[index];
	}
	
	CGRect rectTab = m_tab->GetFrameRect();
	
	unsigned int tabcount = m_tab->GetTabNodeCount();
	
	if (index >= tabcount) 
	{
		return NULL;
	}
	
	if (size < tabcount) 
	{
		m_vClientLayer.resize(tabcount, NULL);
	}
	
	if (m_vClientLayer[index] == NULL) 
	{
		m_vClientLayer[index] = new NDUILayer;
		
		m_vClientLayer[index]->Initialization();
		
		m_vClientLayer[index]->SetFrameRect(CGRectMake(0, 0, rect.size.width-rectTab.size.width, rect.size.height));
		
		this->AddChild(m_vClientLayer[index]);
	}
	
	return m_vClientLayer[index];
}

TabNode* NDUIClientLayer::GetFuncTabNode(unsigned int index)
{
	if (!m_tab) return NULL;
	
	return m_tab->GetTabNode(index);
}

unsigned int NDUIClientLayer::GetFuncTabNodeCount()
{
	if (!m_tab) return 0;
	
	return m_tab->GetTabNodeCount();
}

void NDUIClientLayer::SetFocusFuncTabIndex(unsigned int index, bool dispatchEvent/*=false*/)
{
	if (!m_tab) return;
	
	m_tab->SetFocusTabIndex(index, dispatchEvent);
	
	size_t size = m_vClientLayer.size();
	
	for (size_t i = 0; i < size; i++) 
	{
		m_vClientLayer[i]->SetVisible(i == index);
	}
}

void NDUIClientLayer::SetFocusFuncTabNode(TabNode* tabnode, bool dispatchEven/*t=false*/)
{
	if (!m_tab) return;
	
	m_tab->SetFocusTabNode(tabnode, dispatchEven);
}

unsigned int NDUIClientLayer::GetCurFuncTabIndex()
{
	if (!m_tab) return -1;
	
	return m_tab->GetFocusIndex();
}

void NDUIClientLayer::OnTabLayerSelect(TabLayer* tab, unsigned int lastIndex, unsigned int curIndex)
{
	if (tab != m_tab) return;
	
	size_t size = m_vClientLayer.size();
	
	if (lastIndex < size) 
	{
		m_vClientLayer[lastIndex]->SetVisible(false);
	}
	
	if (curIndex < size) 
	{
		m_vClientLayer[curIndex]->SetVisible(true);
	}
	
	NDUIClientLayerDelegate* delegate = dynamic_cast<NDUIClientLayerDelegate*> (this->GetDelegate());
	if (delegate) 
	{
		delegate->OnClientLayerTabSel(this, lastIndex, curIndex);
	}	
}

//////////////////////////////////////////////////////////////
#pragma mark 通用界面场景

#define main_tab_bg_h (37)

#define main_tab_bg_startw (7)

IMPLEMENT_CLASS(NDCommonScene, NDScene)

NDCommonScene::NDCommonScene()
{
	m_tab = NULL;
	
	m_curTabIndex = 0;
	
	m_genralLayer = NULL;
	
	m_genralEventLayer = NULL;
	
	m_btnClose = m_btnNext = NULL;
	
	m_uiTabInterval = 5;
	
	m_tabNodeSize = CGSizeMake(70, 34);
	
	m_layerBackground = NULL;
}

NDCommonScene::~NDCommonScene()
{
}

void NDCommonScene::Initialization(bool showPage/*=false*/, unsigned int perPageCount/*=0*/)
{
	NDScene::Initialization();

	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	CGSize winsize = NDDirector::DefaultDirector()->GetWinSize();
	
	m_layerBackground = new NDUILayer;
	
	m_layerBackground->Initialization();
	
	m_layerBackground->SetBackgroundColor(ccc4(245, 226, 168, 255));
	
	m_layerBackground->SetFrameRect(CGRectMake(0, 0, winsize.width, winsize.height));
	
	this->AddChild(m_layerBackground);
	
	NDUIImage* imageTabCut = new NDUIImage;
	
	imageTabCut->Initialization();
	
	imageTabCut->SetPicture(NDPicturePool::DefaultPool()->AddPicture(GetImgPathNew("bag_bg.png"), winsize.width, main_tab_bg_h), true);
	
	imageTabCut->SetFrameRect(CGRectMake(0, 0, winsize.width, main_tab_bg_h));
	
	imageTabCut->EnableEvent(false);
	
	m_layerBackground->AddChild(imageTabCut);
	
	NDPicture *picTabCut = pool.AddPicture(GetImgPathNew("newui_tab_fengge.png"), winsize.width, 5);
	
	imageTabCut = new NDUIImage;
	
	imageTabCut->Initialization();
	
	imageTabCut->SetPicture(picTabCut, true);
	
	imageTabCut->SetFrameRect(CGRectMake(0, main_tab_bg_h-5, winsize.width, 5));
	
	imageTabCut->EnableEvent(false);
	
	m_layerBackground->AddChild(imageTabCut);
	
	InitTab(showPage, perPageCount);
	
	NDPicture *picClose = pool.AddPicture(GetImgPathNew("newui_close.png"));
	
	CGSize sizeClose = picClose->GetSize();
		
	m_btnClose = new NDUIButton;
	
	m_btnClose->Initialization();
	
	m_btnClose->SetFrameRect(CGRectMake(winsize.width-main_tab_bg_startw-sizeClose.width, main_tab_bg_h-sizeClose.height, sizeClose.width, sizeClose.height));
	
	//m_btnClose->SetTitle("关闭");
	
	m_btnClose->SetImage(picClose, false, CGRectZero, true);
	
	m_btnClose->SetDelegate(this);
	
	m_layerBackground->AddChild(m_btnClose);
	
	NDPicture *picNext = pool.AddPicture(GetImgPathNew("newui_btn.png"));
	
	CGSize sizeNext = picNext->GetSize();
	
	m_btnNext = new NDUIButton;
	
	m_btnNext->Initialization();
	
	m_btnNext->SetFrameRect(CGRectMake(main_tab_bg_startw, main_tab_bg_h-sizeNext.height, sizeNext.width, sizeNext.height));
	
	m_btnNext->SetImage(picNext, false, CGRectZero, true);
	
	m_btnNext->SetTitle(NDCommonCString("RollPage"));
	
	m_btnNext->SetFontSize(14);
	
	m_btnNext->SetFontColor(ccc4(116, 13, 13, 255));
	
	m_btnNext->SetDelegate(this);
	
	m_layerBackground->AddChild(m_btnNext);
}

// 增加一个tab标签
// 标签索引从0开始递增
// 同时为该标签创建了一个客户层
TabNode* NDCommonScene::AddTabNode()
{
	if (!m_tab) InitTab();
	
	CGSize size = NDDirector::DefaultDirector()->GetWinSize();
	
	NDUIClientLayer* client = new NDUIClientLayer;
	
	client->Initialization();
	
	client->SetFrameRect(CGRectMake(0, main_tab_bg_h, size.width, size.height-main_tab_bg_h));
	
	m_layerBackground->AddChild(client);
	
	m_vClientLayer.push_back(client);
	
	CGRect rect = m_tab->GetFrameRect();
	
	if (!m_tab->IsShowPage() || m_tab->GetTabNodeCount() < m_tab->GetPerPageCount())
		rect.size.width = (m_uiTabInterval+m_tabNodeSize.width)*(m_tab->GetTabNodeCount()+1)-m_uiTabInterval;
	m_tab->SetFrameRect(rect);
	
	return m_tab->CreateTabNode();
}

// 获取标签的客户层
// 大多数工作是获取客户层后往层里加节点(具体展现),至于标签的切换工作(客户层切换)内部完成
// 如果该客户层需要支持多个功能,可以把加入节点的工作重心转移到NDUIClientLayer->GetFuncLayer
NDUIClientLayer* NDCommonScene::GetClientLayer(unsigned int tabIndex)
{
	size_t size = m_vClientLayer.size();
	
	if (!m_tab && size == 0) 
	{
		CGSize size = NDDirector::DefaultDirector()->GetWinSize();
		
		NDUIClientLayer* client = new NDUIClientLayer;
		
		client->Initialization();
		
		client->SetFrameRect(CGRectMake(0, 0, size.width, size.height));
		
		m_layerBackground->AddChild(client);
		
		m_vClientLayer.push_back(client);
		
		return client;
	}
	else if (!m_tab)
	{
		if (size == 1) 
			return m_vClientLayer[0];
			
		return NULL;
	}
	
	
	if (tabIndex >= size) return NULL;
	
	return m_vClientLayer[tabIndex];
}

// 创建通用层
// 通用层与tab无关 
// 通用层一直处于显示状态(不会因为tab切换而隐藏或显示)
NDUILayer* NDCommonScene::CetGernalLayer(bool dealEvent,unsigned int zOrder/*=0*/)
{
	NDUILayer*& layer = dealEvent ? m_genralEventLayer : m_genralLayer;
	
	if  (layer) return layer;
	
	CGPoint pos = CGPointZero;
	
	if (m_tab) pos.y = main_tab_bg_h;
	
	CGSize winsize = NDDirector::DefaultDirector()->GetWinSize();
	
	layer = new NDUILayer;
	
	layer->Initialization();
	
	layer->SetFrameRect(CGRectMake(pos.x, pos.y, winsize.width, winsize.height-pos.y));
	
	layer->EnableEvent(dealEvent);
	
	m_layerBackground->AddChild(layer);
	
	return layer;
}

void NDCommonScene::SetTabFocusOnIndex(unsigned int index, bool dispatchEvent/*=false*/)
{
	if (!m_tab || index >= m_tab->GetTabNodeCount()) return;
	
	size_t size = m_vClientLayer.size();
	
	for (size_t i = 0; i < size; i++) 
	{
		m_vClientLayer[i]->SetVisible(i == index);
	}
	
	m_tab->SetFocusTabIndex(index, dispatchEvent);
}

unsigned int NDCommonScene::GetCurTabIndex()
{
	if (!m_tab) return -1;
	
	return m_tab->GetFocusIndex();
}

void NDCommonScene::OnTabLayerSelect(TabLayer* tab, unsigned int lastIndex, unsigned int curIndex)
{
	if (tab == m_tab) 
	{
		size_t size = m_vClientLayer.size();
		
		if (lastIndex < size) 
		{
			m_vClientLayer[lastIndex]->SetVisible(false);
		}
		
		if (curIndex < size) 
		{
			NDUIClientLayer *layer = m_vClientLayer[curIndex];
			layer->SetVisible(true);
			
			layer->SetFocusFuncTabIndex(layer->GetCurFuncTabIndex(), true);
		}
	}
}

void NDCommonScene::OnTabLayerNextPage(TabLayer* tab, unsigned int lastPage, unsigned int nextPage)
{
	if (tab != m_tab && !tab->IsKindOfClass(RUNTIME_CLASS(HorizontalTabLayer))) return;
	
	size_t size = m_vClientLayer.size();
	
	unsigned int perPageCount = ((HorizontalTabLayer*)tab)->GetPerPageCount();
	
	if (perPageCount == 0) return;
	
	unsigned int lastPageStart = lastPage * perPageCount,
				 lastPageEnd = (lastPage+1) * perPageCount,
				 nextPageStart = nextPage * perPageCount,
				 nextPageEnd = (nextPage+1) * perPageCount;
	
	for (size_t i = 0; i < size; i++) 
	{
		bool visible;
		if ( i >= lastPageStart && i < lastPageEnd )
			visible = false;
		else if ( i >= nextPageStart && i < nextPageEnd)
			if (i == nextPageStart)
				visible = true;
			else
				visible = false;
		else
			continue;
			
		m_vClientLayer[i]->SetVisible(visible);
	}
}

void NDCommonScene::InitTab(bool showPage/*=false*/, unsigned int perPageCount/*=0*/)
{
	m_tab = new HorizontalTabLayer;
	
	m_tab->Initialization(m_uiTabInterval);
	
	if (showPage)
		m_tab->SetCountPerPage(perPageCount);
	
	m_tab->SetFrameRect(CGRectMake(main_tab_bg_startw+42+m_uiTabInterval, main_tab_bg_h-m_tabNodeSize.height, 0, m_tabNodeSize.height));
	
	m_tab->SetTabNodeSize(m_tabNodeSize);
	
	m_tab->SetDelegate(this);
	
	m_layerBackground->AddChild(m_tab);
}

bool NDCommonScene::OnBaseButtonClick(NDUIButton* button)
{
	if (button == m_btnClose) 
	{
		NDDirector::DefaultDirector()->PopScene();
		
		return true;
	}
	else if (button == m_btnNext)
	{
		if (m_tab)
		{
			if (m_tab->IsShowPage())
				m_tab->NextPage();
			else
				m_tab->SetFocusTabIndex((m_tab->GetFocusIndex()+1)%m_tab->GetTabNodeCount(), true);
			
			return true;
		}
	}
	
	return false;
}

#pragma mark 功能tab


IMPLEMENT_CLASS(NDFuncTab, NDUILayer)

NDFuncTab::NDFuncTab()
{
	m_tab = NULL;
}

NDFuncTab::~NDFuncTab()
{
}

void NDFuncTab::Initialization(unsigned int tabCount, CGPoint pos, CGSize sizeTabNode/*=CGSizeMake(25, 63)*/, unsigned selHeight/*=0*/, unsigned unselHeight/*=0*/, bool bFullClient/*=false*/, int bgwidth/*=280*/)
{
	NDUILayer::Initialization();
	
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	NDPicture *picBg = NULL;
	
	int width = bFullClient ? 480 : bgwidth;
	
	//if (bFullClient) {
		picBg = pool.AddPicture(GetImgPathNew("bag_bag_bg.png"), width - sizeTabNode.width, 276, false);
	//} else {
	//	picBg = pool.AddPicture(GetImgPathNew("bag_bag_bg.png"));
	//}
	
	CGSize bgsize = picBg->GetSize();
	
	CGSize framesize = CGSizeMake(width, bgsize.height);
	
	this->SetFrameRect(CGRectMake(pos.x, pos.y, framesize.width, framesize.height));
	
	NDUIImage* imageBg = new NDUIImage;
	
	imageBg->Initialization();
	
	imageBg->SetPicture(picBg, true);
	
	imageBg->SetFrameRect(CGRectMake(0, 0, bgsize.width, bgsize.height));
	
	imageBg->EnableEvent(false);
	
	this->AddChild(imageBg);
	
	//CGSize sizeTabNode = CGSizeMake(25, 63);
	
	CGRect rectTab;
	
	int height = sizeTabNode.height*tabCount+4*(tabCount-1);
	
	rectTab.origin = ccp(bgsize.width+2, 10);
	
	rectTab.size = CGSizeMake(framesize.width-bgsize.width-2, height);
	
	m_tab = new VerticalTabLayer;
	
	m_tab->Initialization(4);
	
	m_tab->SetFrameRect(rectTab);
	
	m_tab->SetTabNodeSize(sizeTabNode);
	
	m_tab->SetDelegate(this);
	
	this->AddChild(m_tab, 1);
	
	for (unsigned int i = 0; i < tabCount; i++) 
	{
		VerticalTabNode* tabnode = m_tab->CreateTabNode();
		
		tabnode->SetImage(pool.AddPicture(GetImgPathNew("newui_tab_unsel2.png"), 0, unselHeight), 
						  pool.AddPicture(GetImgPathNew("newui_tab_sel2.png"), 0, selHeight));
						  
		if(i == 0)
			tabnode->SetFoucusOffset(9);
		else if (i == 3)
			tabnode->SetFoucusOffset(-9);			  
						  
		NDUIClientLayer* client = new NDUIClientLayer;
		
		client->Initialization();
		
		client->SetFrameRect(CGRectMake(0, 0, bgsize.width, bgsize.height));
		
		this->AddChild(client);
		
		m_vClientLayer.push_back(client);
	}
}

TabNode* NDFuncTab::GetTabNode(unsigned int index)
{
	if (!m_tab) return NULL;
	
	if (index >= m_tab->GetTabNodeCount()) return NULL;
	
	return m_tab->GetTabNode(index);
}

// 获取标签的客户层
// 大多数工作是获取客户层后往层里加节点(具体展现),至于标签的切换工作(客户层切换)内部完成
// 如果该客户层需要支持多个功能,可以把加入节点的工作重心转移到NDUIClientLayer->GetFuncLayer
NDUIClientLayer* NDFuncTab::GetClientLayer(unsigned int tabIndex)
{
	size_t size = m_vClientLayer.size();
	
	if (tabIndex >= size) return NULL;
	
	return m_vClientLayer[tabIndex];
}

void NDFuncTab::OnTabLayerClick(TabLayer* tab, uint curIndex)
{
	TabLayerDelegate* delegate = dynamic_cast<TabLayerDelegate*> (this->GetDelegate());
	if (delegate) 
	{
		delegate->OnTabLayerClick(tab, curIndex);
	}
}

void NDFuncTab::OnTabLayerSelect(TabLayer* tab, unsigned int lastIndex, unsigned int curIndex)
{
	if (tab == m_tab) 
	{
		size_t size = m_vClientLayer.size();
		
		if (lastIndex < size) 
		{
			m_vClientLayer[lastIndex]->SetVisible(false);
		}
		
		if (curIndex < size) 
		{
			NDUIClientLayer *layer = m_vClientLayer[curIndex];
			layer->SetVisible(true);
		}
		
		TabLayerDelegate* delegate = dynamic_cast<TabLayerDelegate*> (this->GetDelegate());
		if (delegate) 
		{
			delegate->OnTabLayerSelect(tab, lastIndex, curIndex);
		}
	}
}

void NDFuncTab::SetVisible(bool visible)
{
	unsigned int index;
	
	if (m_tab && visible) 
	{
		index = m_tab->GetFocusIndex();
	}
	
	NDUILayer::SetVisible(visible);
	
	if (m_tab && visible) 
	{
		m_tab->SetFocusTabIndex(index, false);
	}
	
	size_t size = m_vClientLayer.size();
	
	for (size_t i = 0; i < size; i++) 
	{
		m_vClientLayer[i]->SetVisible(i == index);
	}
}

void NDFuncTab::SetTabFocusOnIndex(unsigned int index, bool dispatchEvent/*=false*/)
{
	if (!m_tab) return;
	
	size_t size = m_vClientLayer.size();
	
	for (size_t i = 0; i < size; i++) 
	{
		m_vClientLayer[i]->SetVisible(i == index);
	}
	
	m_tab->SetFocusTabIndex(index, dispatchEvent);
}

#pragma mark 社交类型场景

IMPLEMENT_CLASS(NDCommonSocialScene, NDScene)
	
NDCommonSocialScene::NDCommonSocialScene()
{
	m_tab = NULL;
	
	m_layerBackground = NULL;
	
	m_btnClose = NULL;
}

NDCommonSocialScene::~NDCommonSocialScene()
{
}

void NDCommonSocialScene::Initialization()
{
	NDScene::Initialization();
	
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	CGSize winsize = NDDirector::DefaultDirector()->GetWinSize();
	
	m_layerBackground = new NDUILayer;
	
	m_layerBackground->Initialization();
	
	m_layerBackground->SetBackgroundColor(ccc4(245, 226, 168, 255));
	
	m_layerBackground->SetFrameRect(CGRectMake(0, 0, winsize.width, winsize.height));
	
	this->AddChild(m_layerBackground);
	
	NDUIImage* imageTabCut = new NDUIImage;
	
	imageTabCut->Initialization();
	
	imageTabCut->SetPicture(NDPicturePool::DefaultPool()->AddPicture(GetImgPathNew("bag_bg.png"), winsize.width, main_tab_bg_h), true);
	
	imageTabCut->SetFrameRect(CGRectMake(0, 0, winsize.width, main_tab_bg_h));
	
	imageTabCut->EnableEvent(false);
	
	m_layerBackground->AddChild(imageTabCut);
	
	NDPicture *picTabCut = pool.AddPicture(GetImgPathNew("newui_tab_fengge.png"), winsize.width, 5);
	
	imageTabCut = new NDUIImage;
	
	imageTabCut->Initialization();
	
	imageTabCut->SetPicture(picTabCut, true);
	
	imageTabCut->SetFrameRect(CGRectMake(0, main_tab_bg_h-5, winsize.width, 5));
	
	imageTabCut->EnableEvent(false);
	
	m_layerBackground->AddChild(imageTabCut);
	
	NDPicture *picClose = pool.AddPicture(GetImgPathNew("newui_close.png"));
	
	CGSize sizeClose = picClose->GetSize();
	
	m_btnClose = new NDUIButton;
	
	m_btnClose->Initialization();
	
	m_btnClose->SetFrameRect(CGRectMake(0, 0, sizeClose.width, sizeClose.height));
	
	//m_btnClose->SetTitle("关闭");
	
	m_btnClose->SetImage(picClose, false, CGRectZero, true);
	
	m_btnClose->SetDelegate(this);
	
	NDUILayer *closeLayer = new NDUILayer;
	closeLayer->Initialization();
	closeLayer->SetFrameRect(CGRectMake(winsize.width-main_tab_bg_startw-sizeClose.width, main_tab_bg_h-sizeClose.height, sizeClose.width, sizeClose.height));
	this->AddChild(closeLayer, 10);
	
	closeLayer->AddChild(m_btnClose);
}

void NDCommonSocialScene::InitTab(unsigned int tabCount, CGSize sizeTabNode/*=CGSizeMake(25, 63)*/, unsigned selHeight/*=0*/, unsigned unselHeight/*=0*/)
{
	SAFE_DELETE_NODE(m_tab);
	
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	CGSize winsize = NDDirector::DefaultDirector()->GetWinSize();
	
	CGRect rectTab;
	
	int height = sizeTabNode.height*tabCount+4*(tabCount-1);
	
	rectTab.origin = ccp(winsize.width-sizeTabNode.width+2, 8+main_tab_bg_h);
	
	rectTab.size = CGSizeMake(sizeTabNode.width, height);
	
	m_tab = new VerticalTabLayer;
	
	m_tab->Initialization(4);
	
	m_tab->SetFrameRect(rectTab);
	
	m_tab->SetTabNodeSize(sizeTabNode);
	
	m_tab->SetDelegate(this);
	
	this->AddChild(m_tab, 1);
	
	for_vec(m_vClientLayer, std::vector<NDUIClientLayer*>::iterator)
	{
		NDUIClientLayer* tmp = *it;
		SAFE_DELETE_NODE(tmp);
	}
	
	m_vClientLayer.clear();
	
	m_vClientBackground.clear();
	
	for (unsigned int i = 0; i < tabCount; i++) 
	{
		VerticalTabNode* tabnode = m_tab->CreateTabNode();
		
		tabnode->SetImage(pool.AddPicture(GetImgPathNew("newui_tab_unsel2.png"), 0, unselHeight), 
						  pool.AddPicture(GetImgPathNew("newui_tab_sel2.png"), 0, selHeight));
		
		if(i == 0)
			tabnode->SetFoucusOffset(9);
		else if (i == 3)
			tabnode->SetFoucusOffset(-9);			  
		
		NDUIClientLayer* client = new NDUIClientLayer;
		
		client->Initialization();
		
		client->SetFrameRect(CGRectMake(0, 0, winsize.width, winsize.height));
		
		this->AddChild(client);
		
		m_vClientLayer.push_back(client);
		
		NDUIImage* imageBg = new NDUIImage;
		
		imageBg->Initialization();
		
		imageBg->EnableEvent(false);
		
		client->AddChild(imageBg);
		
		m_vClientBackground.push_back(imageBg);
	}
}

void NDCommonSocialScene::SetClientLayerBackground(unsigned int tabIndex, bool bFullClient/*=false*/, int bgwidth/*=280*/)
{
	if (tabIndex >= m_vClientLayer.size()) return;
	
	if (tabIndex >= m_vClientBackground.size()) return;
	
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	NDPicture *picBg = NULL;
	
	int width = bFullClient ? 480 : bgwidth;
	
	//if (bFullClient) {
		picBg = pool.AddPicture(GetImgPathNew("bag_bag_bg.png"), width - m_tab->GetTabNodeSize().width, 276, false);
	//} else {
	//	picBg = pool.AddPicture(GetImgPathNew("bag_bag_bg.png"));
	//}
	
	CGSize bgsize = picBg->GetSize();
	
	NDUIImage* image = m_vClientBackground[tabIndex];
	image->SetPicture(picBg, true);
	image->SetFrameRect(CGRectMake(bFullClient ? 0.0f : 480.0f-bgwidth, 5+main_tab_bg_h, bgsize.width+3-(bFullClient? 1 : 0), bgsize.height));
}

TabNode* NDCommonSocialScene::GetTabNode(unsigned int tabIndex)
{
	if (!m_tab) return NULL;
	
	if (tabIndex >= m_tab->GetTabNodeCount()) return NULL;
	
	return m_tab->GetTabNode(tabIndex);
}

NDUIClientLayer* NDCommonSocialScene::GetClientLayer(unsigned int tabIndex)
{
	size_t size = m_vClientLayer.size();
	
	if (tabIndex >= size) return NULL;
	
	return m_vClientLayer[tabIndex];
}

#include <sstream>
#include "Chat.h"
void NDCommonSocialScene::SetTabFocusOnIndex(unsigned int index, bool dispatchEvent/*=false*/)
{
	if (!m_tab || index >= m_tab->GetTabNodeCount()) return;
	
	size_t size = m_vClientLayer.size();
	
	std::stringstream ss;
	//ss << "param size" << sizeof(unsigned int) << " " << "client count" << sizeof(size_t) << "\n";
	Chat::DefaultChat()->AddMessage(ChatTypeSystem, ss.str().c_str());
	
	//std::stringstream ss;
	//ss << "当前选中" << index << " " << "总共" << size << "\n";
	//Chat::DefaultChat()->AddMessage(ChatTypeSystem, ss.str().c_str());
	
	for (size_t i = 0; i < size; i++) 
	{
		//std::stringstream ss;
		//ss << "for 当前选中" << index << " " << "遍历" << i << "\n";
		//Chat::DefaultChat()->AddMessage(ChatTypeSystem, ss.str().c_str());
		
		m_vClientLayer[i]->SetVisible(i == index);
	}
	
	m_tab->SetFocusTabIndex(index, dispatchEvent);
}

bool NDCommonSocialScene::OnBaseButtonClick(NDUIButton* button)
{
	if (button == m_btnClose) 
	{
		NDDirector::DefaultDirector()->PopScene();
		
		return true;
	}
	
	return false;
}

void NDCommonSocialScene::OnTabLayerSelect(TabLayer* tab, unsigned int lastIndex, unsigned int curIndex)
{
	if (tab == m_tab) 
	{
		size_t size = m_vClientLayer.size();
		
		if (lastIndex < size) 
		{
			m_vClientLayer[lastIndex]->SetVisible(false);
		}
		
		if (curIndex < size) 
		{
			NDUIClientLayer *layer = m_vClientLayer[curIndex];
			layer->SetVisible(true);
		}
		
		TabLayerDelegate* delegate = dynamic_cast<TabLayerDelegate*> (this->GetDelegate());
		if (delegate) 
		{
			delegate->OnTabLayerSelect(tab, lastIndex, curIndex);
		}
	}
}

#pragma mark 水平型功能tab

IMPLEMENT_CLASS(NDHFuncTab, NDUILayer)

NDHFuncTab::NDHFuncTab()
{
	m_tab = NULL;
	
	m_layerBackground = NULL;
}

NDHFuncTab::~NDHFuncTab()
{
}

void NDHFuncTab::Initialization(unsigned int tabCount, CGSize sizeTabNode/*=CGSizeMake(70, 34)*/, unsigned int interval/*=5*/)
{
	NDUILayer::Initialization();
	
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	CGSize size = NDDirector::DefaultDirector()->GetWinSize();
	
	m_layerBackground = new NDUILayer;
	
	m_layerBackground->Initialization();
	
	m_layerBackground->SetFrameRect(CGRectMake(0, 0, size.width, size.height));
	
	this->AddChild(m_layerBackground);
	
	m_tab = new HorizontalTabLayer;
	
	m_tab->Initialization(interval);
	
	m_tab->SetFrameRect(CGRectMake(6, main_tab_bg_h-sizeTabNode.height, 0, sizeTabNode.height));
	
	m_tab->SetTabNodeSize(sizeTabNode);
	
	m_tab->SetDelegate(this);
	
	m_layerBackground->AddChild(m_tab);
	
	for (unsigned int i = 0; i < tabCount; i++) 
	{
		NDUIClientLayer* client = new NDUIClientLayer;
		
		client->Initialization();
		
		client->SetFrameRect(CGRectMake(0, main_tab_bg_h, size.width, size.height-main_tab_bg_h));
		
		m_layerBackground->AddChild(client);
		
		m_vClientLayer.push_back(client);
		
		CGRect rect = m_tab->GetFrameRect();
		
		rect.size.width = (interval+sizeTabNode.width)*(tabCount+1)-interval;
		
		m_tab->SetFrameRect(rect);
		
		TabNode* tabnode = m_tab->CreateTabNode();
		
		tabnode->SetImage(pool.AddPicture(GetImgPathNew("newui_tab_unsel.png"), sizeTabNode.width, 31), 
						  pool.AddPicture(GetImgPathNew("newui_tab_sel.png"), sizeTabNode.width, sizeTabNode.height),
						  pool.AddPicture(GetImgPathNew("newui_tab_selarrow.png")));
		
		
		tabnode->SetTextColor(ccc4(245, 226, 169, 255));
		
		tabnode->SetFocusColor(ccc4(173, 70, 25, 255));
		
		tabnode->SetTextFontSize(18);
	}
}

TabNode* NDHFuncTab::GetTabNode(unsigned int index)
{
	if (!m_tab) return NULL;
	
	if (index >= m_tab->GetTabNodeCount()) return NULL;
	
	return m_tab->GetTabNode(index);
}	

NDUIClientLayer* NDHFuncTab::GetClientLayer(unsigned int tabIndex)
{
	size_t size = m_vClientLayer.size();
	
	if (tabIndex >= size) return NULL;
	
	return m_vClientLayer[tabIndex];
}

void NDHFuncTab::SetVisible(bool visible)
{
	unsigned int index;
	
	if (m_tab && visible) 
	{
		index = m_tab->GetFocusIndex();
	}
	
	NDUILayer::SetVisible(visible);
	
	if (m_tab && visible) 
	{
		m_tab->SetFocusTabIndex(index, false);
	}
	
	size_t size = m_vClientLayer.size();
	
	for (size_t i = 0; i < size; i++) 
	{
		m_vClientLayer[i]->SetVisible(i == index);
	}
}
	
void NDHFuncTab::OnTabLayerSelect(TabLayer* tab, unsigned int lastIndex, unsigned int curIndex)
{
	if (tab == m_tab) 
	{
		size_t size = m_vClientLayer.size();
		
		if (lastIndex < size) 
		{
			m_vClientLayer[lastIndex]->SetVisible(false);
		}
		
		if (curIndex < size) 
		{
			NDUIClientLayer *layer = m_vClientLayer[curIndex];
			layer->SetVisible(true);
		}
		
		HFuncTabDelegate* delegate = dynamic_cast<HFuncTabDelegate*> (this->GetDelegate());
		if (delegate) 
		{
			delegate->OnHFuncTabSelect(this, lastIndex, curIndex);
		}
	}
}

void NDHFuncTab::OnTabLayerClick(TabLayer* tab, uint curIndex)
{
	HFuncTabDelegate* delegate = dynamic_cast<HFuncTabDelegate*> (this->GetDelegate());
	if (delegate) 
	{
		delegate->OnHFuncTabClick(this, curIndex);
	}
}

void NDHFuncTab::SetTabFocusOnIndex(unsigned int index, bool dispatchEvent/*=false*/)
{
	if (!m_tab || index >= m_tab->GetTabNodeCount()) return;
	
	size_t size = m_vClientLayer.size();
	
	for (size_t i = 0; i < size; i++) 
	{
		m_vClientLayer[i]->SetVisible(i == index);
	}
	
	m_tab->SetFocusTabIndex(index, dispatchEvent);
}


#pragma mark 通用界面层

#define main_tab_bg_h (37)

#define main_tab_bg_startw (7)

IMPLEMENT_CLASS(NDCommonLayer, NDUILayer)

NDCommonLayer::NDCommonLayer()
{
	m_tab = NULL;
	
	m_curTabIndex = 0;
	
	m_genralLayer = NULL;
	
	m_genralEventLayer = NULL;
	
	m_btnNext = NULL;
	
	m_uiTabInterval = 5;
	
	m_tabNodeSize = CGSizeMake(70, 34);
	
	m_layerBackground = NULL;
}

NDCommonLayer::~NDCommonLayer()
{
}

void NDCommonLayer::Initialization(bool showPage/*=false*/, unsigned int perPageCount/*=0*/)
{
	NDUILayer::Initialization();
	
	CGSize winsize = NDDirector::DefaultDirector()->GetWinSize();
	
	this->SetFrameRect(CGRectMake(0, 0, winsize.width, winsize.height));
	
	NDPicturePool& pool = *(NDPicturePool::DefaultPool());
	
	m_layerBackground = new NDUILayer;
	
	m_layerBackground->Initialization();
	
	m_layerBackground->SetBackgroundColor(ccc4(245, 226, 168, 0));
	
	m_layerBackground->SetFrameRect(CGRectMake(0, 0, winsize.width, winsize.height));
	
	this->AddChild(m_layerBackground);
	
	NDUIImage* imageTabCut = new NDUIImage;
	
	imageTabCut->Initialization();
	
	imageTabCut->SetPicture(NDPicturePool::DefaultPool()->AddPicture(GetImgPathNew("bag_bg.png"), winsize.width, main_tab_bg_h), true);
	
	imageTabCut->SetFrameRect(CGRectMake(0, 0, winsize.width, main_tab_bg_h));
	
	imageTabCut->EnableEvent(false);
	
	m_layerBackground->AddChild(imageTabCut);
	
	NDPicture *picTabCut = pool.AddPicture(GetImgPathNew("newui_tab_fengge.png"), winsize.width, 5);
	
	imageTabCut = new NDUIImage;
	
	imageTabCut->Initialization();
	
	imageTabCut->SetPicture(picTabCut, true);
	
	imageTabCut->SetFrameRect(CGRectMake(0, main_tab_bg_h-5, winsize.width, 5));
	
	imageTabCut->EnableEvent(false);
	
	m_layerBackground->AddChild(imageTabCut);
	
	InitTab(showPage, perPageCount);
	
	NDPicture *picNext = pool.AddPicture(GetImgPathNew("newui_btn.png"));
	
	CGSize sizeNext = picNext->GetSize();
	
	m_btnNext = new NDUIButton;
	
	m_btnNext->Initialization();
	
	m_btnNext->SetFrameRect(CGRectMake(main_tab_bg_startw, main_tab_bg_h-sizeNext.height, sizeNext.width, sizeNext.height));
	
	m_btnNext->SetImage(picNext, false, CGRectZero, true);
	
	m_btnNext->SetTitle(NDCommonCString("RollPage"));
	
	m_btnNext->SetFontSize(14);
	
	m_btnNext->SetFontColor(ccc4(116, 13, 13, 255));
	
	m_btnNext->SetDelegate(this);
	
	m_layerBackground->AddChild(m_btnNext);
}

// maxTabNodeCharWidth-最大的tab节点字符的宽度
void NDCommonLayer::Initialization(float maxTabNodeCharWidth)
{
	CGSize winsize = NDDirector::DefaultDirector()->GetWinSize();
	
	float maxTitleLen = maxTabNodeCharWidth;
	
	int iW = winsize.width-(7+42+m_uiTabInterval)-(7+42);
	
	m_tabNodeSize = CGSizeMake(maxTitleLen, 34);
	
	this->Initialization(true, iW / (maxTitleLen+m_uiTabInterval));
}

void NDCommonLayer::SetVisible(bool visible)
{
	NDUINode::SetVisible(visible);
	
	if (visible && m_tab)
	{
		this->SetTabFocusOnIndex(m_tab->GetFocusIndex(), true);
	}
}

// 增加一个tab标签
// 标签索引从0开始递增
// 同时为该标签创建了一个客户层
TabNode* NDCommonLayer::AddTabNode()
{
	if (!m_tab) InitTab();
	
	CGSize size = NDDirector::DefaultDirector()->GetWinSize();
	
	NDUIClientLayer* client = new NDUIClientLayer;
	
	client->Initialization();
	
	client->SetFrameRect(CGRectMake(0, main_tab_bg_h, size.width, size.height-main_tab_bg_h));
	
	m_layerBackground->AddChild(client);
	
	m_vClientLayer.push_back(client);
	
	CGRect rect = m_tab->GetFrameRect();
	
	if (!m_tab->IsShowPage() || m_tab->GetTabNodeCount() < m_tab->GetPerPageCount())
		rect.size.width = (m_uiTabInterval+m_tabNodeSize.width)*(m_tab->GetTabNodeCount()+1)-m_uiTabInterval;
	m_tab->SetFrameRect(rect);
	
	return m_tab->CreateTabNode();
}

// 获取标签的客户层
// 大多数工作是获取客户层后往层里加节点(具体展现),至于标签的切换工作(客户层切换)内部完成
// 如果该客户层需要支持多个功能,可以把加入节点的工作重心转移到NDUIClientLayer->GetFuncLayer
NDUIClientLayer* NDCommonLayer::GetClientLayer(unsigned int tabIndex)
{
	size_t size = m_vClientLayer.size();
	
	if (!m_tab && size == 0) 
	{
		CGSize size = NDDirector::DefaultDirector()->GetWinSize();
		
		NDUIClientLayer* client = new NDUIClientLayer;
		
		client->Initialization();
		
		client->SetFrameRect(CGRectMake(0, main_tab_bg_h, size.width, size.height-main_tab_bg_h));
		
		m_layerBackground->AddChild(client);
		
		m_vClientLayer.push_back(client);
		
		return client;
	}
	else if (!m_tab)
	{
		if (size == 1) 
			return m_vClientLayer[0];
		
		return NULL;
	}
	
	
	if (tabIndex >= size) return NULL;
	
	return m_vClientLayer[tabIndex];
}

CGSize NDCommonLayer::GetClientSize()
{
	CGSize size = NDDirector::DefaultDirector()->GetWinSize();
	
	return CGSizeMake(size.width, size.height-main_tab_bg_h);
}

// 创建通用层
// 通用层与tab无关 
// 通用层一直处于显示状态(不会因为tab切换而隐藏或显示)
NDUILayer* NDCommonLayer::CetGernalLayer(bool dealEvent,unsigned int zOrder/*=0*/)
{
	NDUILayer*& layer = dealEvent ? m_genralEventLayer : m_genralLayer;
	
	if  (layer) return layer;
	
	CGPoint pos = CGPointZero;
	
	if (m_tab) pos.y = main_tab_bg_h;
	
	CGSize winsize = NDDirector::DefaultDirector()->GetWinSize();
	
	layer = new NDUILayer;
	
	layer->Initialization();
	
	layer->SetFrameRect(CGRectMake(pos.x, pos.y, winsize.width, winsize.height-pos.y));
	
	layer->EnableEvent(dealEvent);
	
	m_layerBackground->AddChild(layer);
	
	return layer;
}

void NDCommonLayer::SetTabFocusOnIndex(unsigned int index, bool dispatchEvent/*=false*/)
{
	if (!m_tab || index >= m_tab->GetTabNodeCount()) return;
	
	size_t size = m_vClientLayer.size();
	
	for (size_t i = 0; i < size; i++) 
	{
		m_vClientLayer[i]->SetVisible(i == index);
	}
	
	m_tab->SetFocusTabIndex(index, dispatchEvent);
}

unsigned int NDCommonLayer::GetCurTabIndex()
{
	if (!m_tab) return -1;
	
	return m_tab->GetFocusIndex();
}

void NDCommonLayer::OnTabLayerSelect(TabLayer* tab, unsigned int lastIndex, unsigned int curIndex)
{
	if (tab == m_tab) 
	{
		size_t size = m_vClientLayer.size();
		
		if (lastIndex < size) 
		{
			m_vClientLayer[lastIndex]->SetVisible(false);
		}
		
		if (curIndex < size) 
		{
			NDUIClientLayer *layer = m_vClientLayer[curIndex];
			layer->SetVisible(true);
			
			layer->SetFocusFuncTabIndex(layer->GetCurFuncTabIndex(), true);
		}
	}
}

void NDCommonLayer::OnTabLayerNextPage(TabLayer* tab, unsigned int lastPage, unsigned int nextPage)
{
	if (tab != m_tab && !tab->IsKindOfClass(RUNTIME_CLASS(HorizontalTabLayer))) return;
	
	size_t size = m_vClientLayer.size();
	
	unsigned int perPageCount = ((HorizontalTabLayer*)tab)->GetPerPageCount();
	
	if (perPageCount == 0) return;
	
	unsigned int lastPageStart = lastPage * perPageCount,
	lastPageEnd = (lastPage+1) * perPageCount,
	nextPageStart = nextPage * perPageCount,
	nextPageEnd = (nextPage+1) * perPageCount;
	
	for (size_t i = 0; i < size; i++) 
	{
		bool visible;
		if ( i >= lastPageStart && i < lastPageEnd )
			visible = false;
		else if ( i >= nextPageStart && i < nextPageEnd)
			if (i == nextPageStart)
				visible = true;
			else
				visible = false;
			else
				continue;
		
		m_vClientLayer[i]->SetVisible(visible);
	}
}

void NDCommonLayer::InitTab(bool showPage/*=false*/, unsigned int perPageCount/*=0*/)
{
	m_tab = new HorizontalTabLayer;
	
	m_tab->Initialization(m_uiTabInterval);
	
	if (showPage)
		m_tab->SetCountPerPage(perPageCount);
	
	m_tab->SetFrameRect(CGRectMake(main_tab_bg_startw+42+m_uiTabInterval, main_tab_bg_h-m_tabNodeSize.height, 0, m_tabNodeSize.height));
	
	m_tab->SetTabNodeSize(m_tabNodeSize);
	
	m_tab->SetDelegate(this);
	
	m_layerBackground->AddChild(m_tab);
}

void NDCommonLayer::OnButtonClick(NDUIButton* button)
{
	OnBaseButtonClick(button);
}

bool NDCommonLayer::OnBaseButtonClick(NDUIButton* button)
{
	if (button == m_btnNext)
	{
		if (m_tab)
		{
			if (m_tab->IsShowPage())
				m_tab->NextPage();
			else
				m_tab->SetFocusTabIndex((m_tab->GetFocusIndex()+1)%m_tab->GetTabNodeCount(), true);
			
			return true;
		}
	}
	
	return false;
}
