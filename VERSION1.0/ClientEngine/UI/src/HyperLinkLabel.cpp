/*
 *  HyperLinkLabel.mm
 *  SMYS
 *
 *  Created by jhzheng on 12-2-23.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#include "HyperLinkLabel.h"
#include "NDUIBaseGraphics.h"
#include "ObjectTracker.h"

IMPLEMENT_CLASS(HyperLinkLabel, NDUILabel)

HyperLinkLabel::HyperLinkLabel()
{
	INC_NDOBJ_RTCLS
	m_bIsLink = false;
}

HyperLinkLabel::~HyperLinkLabel()
{
	DEC_NDOBJ_RTCLS
}

void HyperLinkLabel::SetIsLink(bool isLink)
{
	m_bIsLink = isLink;
}

void HyperLinkLabel::draw()
{
	if (!this->IsVisibled())
	{
		return;
	}

	NDUILabel::draw();

	if (m_bIsLink)
	{
		CCRect kRect = this->GetScreenRect();
		DrawLine(CCPointMake(kRect.origin.x, kRect.origin.y + kRect.size.height),
				CCPointMake(kRect.origin.x + kRect.size.width,
						kRect.origin.y + kRect.size.height), 
						this->GetFontColor(),1);
	}
}