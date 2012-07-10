//
//  NDUIMenuLayer.h
//  DragonDrive
//
//  Created by xiezhenghai on 10-12-29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#ifndef __NDUIMenuLayer_H
#define __NDUIMenuLayer_H

#include "NDUILayer.h"
#include "NDUIButton.h"

#import "CCTexture2D.h"

namespace NDEngine
{
	class NDPicture;
	class NDUIMenuLayer : public NDUILayer , public NDNodeDelegate
	{
		DECLARE_CLASS(NDUIMenuLayer)
		NDUIMenuLayer();
		~NDUIMenuLayer();
	public:
		void Initialization(); override

		unsigned int GetTitleHeight();
		unsigned int GetOperationHeight();
		unsigned int GetTextHeight();
		
		void draw(); override
		void OnBeforeNodeRemoveFromParent(NDNode* node, bool bCleanUp); override
		
		NDUIButton* GetCancelBtn() const
		{
			return m_btnCancel;
		}
		
		NDUIButton* GetOkBtn() const
		{
			return m_btnOk;
		}
		
		void ShowOkBtn();
	private:
		NSMutableArray *m_tiles;
		NDPicture* m_picCancel;
		NDPicture* m_picOk;
		NDUIButton	   *m_btnCancel;
		NDUIButton	   *m_btnOk;
		void MakeLeftTopTile();
		void MakeRightTopTile();
		void MakeLeftBottomTile();
		void MakeRightBottomTile();
		
		void drawBackground();
		
		void SetFrameRect(CGRect rect){}hide
		
		
	};
}

#endif
