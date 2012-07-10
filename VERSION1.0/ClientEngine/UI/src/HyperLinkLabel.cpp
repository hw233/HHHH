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

IMPLEMENT_CLASS(HyperLinkLabel, NDUILabel)

void HyperLinkLabel::draw()
{
	if (!this->IsVisibled())
	{
		return;
	}
	NDUILabel::draw();
	if (m_isLink) {
		CGRect rect = this->GetScreenRect();
		DrawLine(CGPointMake(rect.origin.x, rect.origin.y + rect.size.height), CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height), this->GetFontColor(), 1);
	}
}
