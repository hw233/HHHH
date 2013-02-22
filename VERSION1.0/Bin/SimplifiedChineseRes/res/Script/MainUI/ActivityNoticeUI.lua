-----------------------------------------------------描述: 活动公告界面--时间: 2012.9.28--作者: Guosen---------------------------------------------------ActivityNoticeUI = {}local p = ActivityNoticeUI;---------------------------------------------------local ID_BTN_CLOSE			= 533;	-- Xlocal ID_LABEL_NOTICE		= 14;	-- 公告标签local szTitle	= "2月22號更新公告";local szNotice	= "【更新一】:開啟混服功能\nIOS,Android用戶可以在同一個伺服器內進行遊戲啦\n【更新二】:新服威震九州開啟\n混合新服威震九州開啟諸多新服活動邀你加入\n【更新三】:元宵活動開啟\n慶元宵佳節大話龍將專屬活動開啟\n詳情點擊左上角群組查看詳情介紹"-----------------------------------------------------function p.ShowUI()	LogInfo( "ActivityNoticeUI: ShowUI" );	local scene = GetSMGameScene();	if not CheckP(scene) then	LogInfo( "ActivityNoticeUI: ShowUI failed! scene is nil" );		return false;	end		local layer = createNDUILayer();	if not CheckP(layer) then		LogInfo( "ActivityNoticeUI: ShowUI failed! layer is nil" );		return false;	end		layer:SetPopupDlgFlag( true );	layer:Init();	layer:SetTag( NMAINSCENECHILDTAG.ActivityNoticeUI );	layer:SetFrameRect( RectFullScreenUILayer );	scene:AddChildZ( layer, 1 );	local uiLoad = createNDUILoad();	if ( nil == uiLoad ) then		layer:Free();		LogInfo( "ActivityNoticeUI: ShowUI failed! uiLoad is nil" );		return false;	end	uiLoad:Load( "activity.ini", layer, p.OnUIEventActivityNoticeUI, 0, 0 );	uiLoad:Free();		--	local pLabelNotice = GetLabel( layer, ID_LABEL_NOTICE );	if ( pLabelNotice ~= nil ) then		pLabelNotice:SetText( szNotice );	end	end---------------------------------------------------function p.CloseUI()	local scene = GetSMGameScene();	if ( scene ~= nil ) then		scene:RemoveChildByTag( NMAINSCENECHILDTAG.ActivityNoticeUI, true );	endend---------------------------------------------------function p.OnUIEventActivityNoticeUI( uiNode, uiEventType, param )	local tag = uiNode:GetTag();	if ( uiEventType == NUIEventType.TE_TOUCH_BTN_CLICK ) then        if ( ID_BTN_CLOSE == tag ) then        	p.CloseUI();        end    end    return true;end