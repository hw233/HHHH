/*
 *  UINpcDlg.h
 *  SMYS
 *
 *  Created by jhzheng on 12-2-21.
 *  Copyright 2012 (����)DeNA. All rights reserved.
 *
 */

#ifndef _UI_NPC_DLG_ZJH_
#define _UI_NPC_DLG_ZJH_

#include "UIDialog.h"
#include "NDPicture.h"

using namespace NDEngine;

class CUINpcDlg : 
public CUIDialog
{
	DECLARE_CLASS(CUINpcDlg)
	
	CUINpcDlg();
	~CUINpcDlg();
	
public:
	void Initialization(int nNpcId); override
	void SetId(int nId);
	void SetTaskState(bool bSet);
	
private:
	void OnClickOpt(int nOptIndex); override
	void OnNpcClick(int nAction);
	void OnTaskClick(int nAction);
private:
	bool			m_bTaskState;
	int				m_nId;
	
	DECLARE_AUTOLINK(CUINpcDlg)
	INTERFACE_AUTOLINK(CUINpcDlg)
};

#endif // _UI_NPC_DLG_ZJH_