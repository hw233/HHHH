//
//  NDUIImage.mm
//  DragonDrive
//
//  Created by xiezhenghai on 11-1-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NDUIImage.h"
#include "I_Analyst.h"

namespace NDEngine
{
	IMPLEMENT_CLASS(NDUIImage, NDUINode)
	
	NDUIImage::NDUIImage()
	{
		m_pic = NULL;
		m_combinePic = NULL;
		m_clearPicOnFree = false;
	}
	
	NDUIImage::~NDUIImage()
	{
		if (m_clearPicOnFree) 
		{
			delete m_pic;
			delete m_combinePic;
		}
	}
	
	void NDUIImage::SetPicture(NDPicture* pic, bool clearPicOnFree)
	{
		if (m_clearPicOnFree) 
		{
			delete m_pic;
			delete m_combinePic;
		}
		
		m_combinePic = NULL;
		m_pic = pic;
		m_clearPicOnFree = clearPicOnFree;
	}
	
	void NDUIImage::SetPictureLua(NDPicture* pic)
	{
		this->SetPicture(pic, true);
	}
	
	CGSize NDUIImage::GetPicSize()
	{
		if (!m_pic)
		{
			return CGSizeZero;
		}
		
		return m_pic->GetSize();
	}
	
	void NDUIImage::SetCombinePicture(NDCombinePicture* pic, bool clearPicOnFree/*= false*/)
	{
		if (m_clearPicOnFree) 
		{
			delete m_pic;
			delete m_combinePic;
		}
		
		m_pic = NULL;
		m_combinePic = pic;
		m_clearPicOnFree = clearPicOnFree;
	}
	
	void NDUIImage::draw()
	{
        TICK_ANALYST(ANALYST_NDUIImage);
		NDUINode::draw();
		
		if (this->IsVisibled()) 
		{
			if (m_pic) m_pic->DrawInRect(this->GetScreenRect());
			else if (m_combinePic) m_combinePic->DrawInRect(this->GetScreenRect());
		}		

	}
}