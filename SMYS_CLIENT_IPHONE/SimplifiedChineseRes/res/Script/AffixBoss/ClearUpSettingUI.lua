---------------------------------------------------
--描述: 普通副本
--时间: 2012.3.15
--作者: wjl
---------------------------------------------------
ClearUpSettingUI = {}
local p = ClearUpSettingUI;

local ID_CLEARLIST_A_RIGHT_CTRL_CHECK_BUTTON_SELL			= 26;
local ID_CLEARLIST_A_RIGHT_CTRL_RANDOM_BUTTON_C				= 25;
local ID_CLEARLIST_A_RIGHT_CTRL_RANDOM_BUTTON_B				= 24;
local ID_CLEARLIST_A_RIGHT_CTRL_RANDOM_BUTTON_A				= 21;
local ID_CLEARLIST_A_RIGHT_CTRL_BUTTON_BEGIN				= 150;
local ID_CLEARLIST_A_RIGHT_CTRL_TEXT_BLANK					= 11;
local ID_CLEARLIST_A_RIGHT_CTRL_TEXT_10						= 10;
local ID_CLEARLIST_A_RIGHT_CTRL_PICTURE_BLANK				= 70;



local ID_CLEARLIST_B_CTRL_VERTICAL_LIST_LEFT			= 5;
local ID_CLEARLIST_B_CTRL_BUTTON_CLOSE					= 4;
local ID_CLEARLIST_B_CTRL_TEXT_TASK_NAME				= 3;
local ID_CLEARLIST_B_CTRL_PICTURE_LEFT_BG				= 72;
local ID_CLEARLIST_B_CTRL_LIST_RIGHT					= 248;
local ID_CLEARLIST_B_CTRL_PICTURE_BG					= 1;


local ID_CLEARLIST_B_RIGHT_CTRL_BUTTON_FINISH				= 15;
local ID_CLEARLIST_B_RIGHT_CTRL_BUTTON_CANCEL				= 14;
local ID_CLEARLIST_B_RIGHT_CTRL_TEXT_MONSTER				= 13;
local ID_CLEARLIST_B_RIGHT_CTRL_TEXT_BLANK					= 11;
local ID_CLEARLIST_B_RIGHT_CTRL_TEXT_10						= 10;
local ID_CLEARLIST_B_RIGHT_CTRL_TEXT_NUM					= 9;
local ID_CLEARLIST_B_RIGHT_CTRL_TEXT_8						= 8;
local ID_CLEARLIST_B_RIGHT_CTRL_TEXT_TIME					= 7;
local ID_CLEARLIST_B_RIGHT_CTRL_TEXT_6						= 6;
local ID_CLEARLIST_B_RIGHT_CTRL_PICTURE_NUM					= 69;
local ID_CLEARLIST_B_RIGHT_CTRL_PICTURE_BLANK				= 70;
local ID_CLEARLIST_B_RIGHT_CTRL_PICTURE_MONSTER_BG			= 71;

p.TagAutoSell = ID_CLEARLIST_A_RIGHT_CTRL_CHECK_BUTTON_SELL;
p.TagPhUseUp = ID_CLEARLIST_A_RIGHT_CTRL_RANDOM_BUTTON_A;
p.TagPhUse30 = ID_CLEARLIST_A_RIGHT_CTRL_RANDOM_BUTTON_B;
p.TagPhUse60 = ID_CLEARLIST_A_RIGHT_CTRL_RANDOM_BUTTON_C;
p.TagBagNUmA = ID_CLEARLIST_A_RIGHT_CTRL_TEXT_BLANK;
p.TagStartA  = ID_CLEARLIST_A_RIGHT_CTRL_BUTTON_BEGIN;

p.TagUiLayer = NMAINSCENECHILDTAG.AffixBossClearUp;
p.TagClose = ID_CLEARLIST_B_CTRL_BUTTON_CLOSE;
p.TagContainer = ID_CLEARLIST_B_CTRL_VERTICAL_LIST_LEFT;
p.TagRightContainer = ID_CLEARLIST_B_CTRL_LIST_RIGHT;
p.TimeText = ID_CLEARLIST_B_RIGHT_CTRL_TEXT_TIME;
p.TagTitle = ID_CLEARLIST_B_CTRL_TEXT_TASK_NAME;
p.TagMonster = ID_CLEARLIST_B_RIGHT_CTRL_TEXT_MONSTER;
p.TagBagNum = ID_CLEARLIST_B_RIGHT_CTRL_TEXT_BLANK;
p.TagBout = ID_CLEARLIST_B_RIGHT_CTRL_TEXT_NUM;

-- 界面控件坐标定义
local winsize = GetWinSize();

local CONTAINTER_W = RectUILayer.size.w / 2;
local CONTAINTER_H = RectUILayer.size.h;
local CONTAINTER_X = 0;
local CONTAINTER_Y = 0;

local ATTR_OFFSET_X = RectUILayer.size.w / 2;
local ATTR_OFFSET_Y = 0;

local TagBtStart_Cancel = ID_CLEARLIST_B_RIGHT_CTRL_BUTTON_CANCEL;
local TagBtClose_Finish = ID_CLEARLIST_B_RIGHT_CTRL_BUTTON_FINISH;

local TagListBt ={
	138,
	139,
	57,
	58,
	59,
	55,
	56,
	60,
	61,
	62,
}

p.Flag = {
	Prepare = 1,
	Running = 2,
}

p.OpenText = {
	"开始",
	"取消",
}

p.FinishText = {
	"关闭",
	"立即完成",
}

p.UseType = {
	UseUp = 1,
	Use30 = 2,
	Use60 = 3,
}


p.mList = {}
p.mInstId = 0;
p.mRunFlag = 1;
p.mTimerTaskTag = nil;
p.mTimeSeconds = 0;
p.mTimeNeedSeconds = 0;
p.mAutoSell = false;
p.mPhUseType = p.UseType.UseUp;
p.mItemCount = 0;
p.mType = 1;
p.mBossZone= {};


function p.LoadUI(instId)
	p.mInstId = instId;
	p.mRunFlag = p.Flag.Prepare;
	
	local scene = GetSMGameScene();	
	--local scene = director:GetRunningScene();
	if scene == nil then
		LogInfo("scene == nil,load PlayerAttr failed!");
		return;
	end
	
	local layer = createNDUILayer();
	if layer == nil then
		return false;
	end
	layer:Init();
	layer:SetTag(p.TagUiLayer);
	layer:SetFrameRect(RectUILayer);
	layer:SetBackgroundColor(ccc4(125, 125, 125, 125));
	scene:AddChild(layer);
	
	--初始化ui
	local uiLoad = createNDUILoad();
	if not CheckP(uiLoad) then
		return false;
	end
	
	uiLoad:Load("ClearList_B.ini", layer, p.OnUIEvent, CONTAINTER_X, CONTAINTER_Y);
	uiLoad:Free();
	
	p.initData();
	p.initSubUI();

	
	return true;
end

function p.OnUIEvent(uiNode, uiEventType, param)
	local tag = uiNode:GetTag();
	LogInfo("p.OnUIEvent:%d" , tag);
	
	if uiEventType == NUIEventType.TE_TOUCH_BTN_CLICK then
		if p.TagClose == tag then
			p.freeData();
			CloseUI(p.TagUiLayer);
			return true;
		elseif (TagBtStart_Cancel == tag ) then
			p.clickStarBt();
			--MsgAffixBoss.sendNmlOpen();
		elseif (TagBtClose_Finish == tag) then
			p.clickFinishBt();
		elseif (TagListBt[1] == tag) then
			MsgAffixBoss.sendEnter(p.mList[1].typeId);
		elseif (TagListBt[2] == tag) then
			MsgAffixBoss.sendClean(p.mList[1].typeId, 2);
		elseif (TagListBt[3] == tag) then
			MsgAffixBoss.sendCancel(p.mList[1].typeId);
		elseif (TagListBt[4] == tag) then
			MsgAffixBoss.sendFinish(p.mList[1].typeId);
		end
	end
	return true;
end

function p.OnSettingUIEvent(uiNode, uiEventType, param)
	local tag = uiNode:GetTag();
	LogInfo("p.OnUIEvent:%d" , tag);
	
	if uiEventType == NUIEventType.TE_TOUCH_BTN_CLICK then
		if p.TagStartA == tag then
			local type = 1
			p.mTimeNeedSeconds = 0;
			if (p.mPhUseType == p.UseType.UseUp) then
				p.mTimeNeedSeconds = 60;
				type = 0;
			elseif (p.mPhUseType == p.UseType.Use30) then
				p.mTimeNeedSeconds = 30 * 60;
				type = 1
			elseif (p.mPhUseType == p.UseType.Use60) then
				p.mTimeNeedSeconds = 60 * 60;
				type = 2
			end
			
			local st = PlayerFunc.GetUserTotalStamina();
			if (st <= 0 or (type == 1 and st <20) or (type == 2 and st < 40) ) then
				CommonDlg.ShowTipInfo("","体力不足无法挂机");
				return true;
			end
			
			p.mType = type
		
			if ( p.mAutoSell == false and p.mItemCount <=3 ) then
				CommonDlg.ShowNoPrompt("背包剩余容量不多，是否继续清剿？",p.confirmSend, true);
				return true;
			elseif (p.mAutoSell == false and p.mItemCount <=0 ) then
				CommonDlg.ShowTipInfo("","背包满无法挂机");
				return true;
			end
			p.setCleanLayout();
			MsgAffixBoss.sendNmlClean(p.mInstId, type, p.mAutoSell);
			p.clickStarBt();
		elseif (TagBtStart_Cancel == tag ) then
			--p.clickStarBt();
			--MsgAffixBoss.sendNmlOpen();
		elseif (TagBtClose_Finish == tag) then
			p.clickFinishBt();
		elseif (TagListBt[1] == tag) then
			MsgAffixBoss.sendEnter(p.mList[1].typeId);
		elseif (TagListBt[2] == tag) then
			MsgAffixBoss.sendClean(p.mList[1].typeId, 2);
		elseif (TagListBt[3] == tag) then
			MsgAffixBoss.sendCancel(p.mList[1].typeId);
		elseif (TagListBt[4] == tag) then
			MsgAffixBoss.sendFinish(p.mList[1].typeId);
		end
	elseif uiEventType == NUIEventType.TE_TOUCH_CHECK_CLICK then
		local check = ConverToCheckBox(uiNode);
		if (p.TagAutoSell == tag) then
			local isSelect = check:IsSelect();
			if (isSelect) then
				p.mAutoSell = true;
			else 
				p.mAutoSell = false;
			end
		else
			local useUpV = p.getRadioButton(p.TagPhUseUp);
			local use30V = p.getRadioButton(p.TagPhUse30);
			local use60V = p.getRadioButton(p.TagPhUse60);
			useUpV:SetSelect(false);
			use30V:SetSelect(false);
			use60V:SetSelect(false);
			if (p.TagPhUseUp == tag) then
				p.mPhUseType = p.UseType.UseUp;
				useUpV:SetSelect(true);
			elseif(p.TagPhUse30 == tag) then
				p.mPhUseType = p.UseType.Use30;
				use30V:SetSelect(true);
			elseif(p.TagPhUse60 == tag) then
				p.mPhUseType = p.UseType.Use60;
				use60V:SetSelect(true);
			end
		end
	end
	return true;
end

function p.getRadioButton(tag)
	local container = p.getContainerById(p.TagRightContainer);
	local view = container:GetBeginView();
	local nod = GetUiNode(view, tag);
	if CheckP(nod) then
		local check = ConverToCheckBox(nod);
		return check;
	end
	return nil;
end

function p.confirmSend(tag, event, parm)
	if event == CommonDlg.EventOK then
		p.setCleanLayout();
		MsgAffixBoss.sendNmlClean(p.mInstId, p.mType, p.mAutoSell);
		p.clickStarBt();
	end
end


function p.initSubUI()
	--p.iniContainer();
	p.setSettingLayout();
	p.refreshRightLayout();
end

function p.setSettingLayout()
	local container = p.getContainerById(p.TagRightContainer);
	if not CheckP(container) then
		LogInfo("nil == container");
		return;
	end
	container:RemoveAllView();
	local rectview = container:GetFrameRect();
	
	container:SetViewSize(CGSizeMake(rectview.size.w, rectview.size.h));
	
	local view = createUIScrollView();
	
	if not CheckP(view) then
		LogInfo("view == nil");
		return;
	end
	view:Init(false);
	view:SetScrollStyle(UIScrollStyle.Horzontal);
	view:SetViewId(1);
	view:SetMovableViewer(container);
	view:SetScrollViewer(container);
	view:SetContainer(container);
	container:AddView(view);
	
	--初始化ui
	local uiLoad = createNDUILoad();
	if not CheckP(uiLoad) then
		return false;
	end
	
	uiLoad:Load("ClearList_A_right.ini", view, p.OnSettingUIEvent, 0, 0);
	uiLoad:Free();
	
	local titleV = GetLabel(p.getUiLayer(), p.TagTitle);
	--local mosterV = GetLabel(view, p.TagMonster);
	--local boutV = GetLabel(view, p.TagBout);
	local bagNum =  GetLabel(view, p.TagBagNUmA);
	--local useUpV = RecursiveRadioBtn(view, {24})
	--local  useUpV = ConverToRadioBtn(GetUiNode(view, p.TagPhUseUp));
	--useUpV:SetSelect(true);
	
	local check = p.getRadioButton(p.TagPhUseUp);
	check:SetSelect(true);
	
	local name = AffixBossFunc.findName(p.mInstId);
	name = name or "普通副本"
	local title = "扫荡"..name;
	titleV:SetText(title);

	
	local items = ItemFunc.getBackBagCapability() - ItemFunc.getBackBagItemCount();
	if not items or items < 1 then
		items = 0;
	end 
	
	p.mItemCount = items;
	
	--local lst, count = AffixBossFunc.findBossList(p.mInstId, 1);
	--boutV:SetText(SafeN2S(count));
	bagNum:SetText(SafeN2S(items));
	p.setLeftLayout();
	
end

function p.refreshBackNum()
	local container = p.getContainerById(p.TagRightContainer);
	local bagNum =  GetLabel(container, p.TagBagNUmA);
	if not p.mItemCount or p.mItemCount < 1 then
		p.mItemCount = 0;
	end
	bagNum:SetText(SafeN2S(p.mItemCount));
end


function p.setLeftLayout()
	local container = p.getContainerById(p.TagContainer);
	if not CheckP(container) then
		LogInfo("nil == container");
		return;
	end
	local rectview = container:GetFrameRect();
	container:SetViewSize(CGSizeMake(rectview.size.w, 100));--rectview.size.h));
	
	local lst, count = nil, 1;--MsgMagic.getRoleMatrixList();
	p.mMatrixList = lst;
	p.mCurrentPage = 1;
	
	
	if (count == nil or count < 1) then
		count = 1
	end
	local page = 1;--math.ceil((count-1)/3);
	
	for i = 1,  page do
	
	local view = createUIScrollView();
	
	if not CheckP(view) then
		LogInfo("view == nil");
		return;
	end
	view:Init(false);
	view:SetScrollStyle(UIScrollStyle.Horzontal);
	view:SetViewId(i);
	view:SetMovableViewer(container);
	view:SetScrollViewer(container);
	view:SetContainer(container);
	container:AddView(view);
	
	local nWidthLimit = 220 * ScaleFactor;
	local fontsize = 12;
	local str = "挂机小提示：\n1、请保证背包有足够的空间来拾取战利品\n2、离线也可进行副本扫荡"
	local lb = _G.CreateColorLabel(str, fontsize, nWidthLimit);
	if CheckP(lb) then
		lb:SetFrameRect(CGRectMake(10, 20, nWidthLimit, 20 * ScaleFactor));
		view:AddChild(lb);
		return true;
	end
	
	end
end

function p.setCleanLayout()
	local leftC = p.getContainerById(p.TagContainer);
	leftC:RemoveAllView();
	local container = p.getContainerById(p.TagRightContainer);
	if not CheckP(container) then
		LogInfo("nil == container");
		return;
	end
	container:RemoveAllView();
	local rectview = container:GetFrameRect();
	
	container:SetViewSize(CGSizeMake(rectview.size.w, rectview.size.h));
	
	local view = createUIScrollView();
	
	if not CheckP(view) then
		LogInfo("view == nil");
		return;
	end
	view:Init(false);
	view:SetScrollStyle(UIScrollStyle.Horzontal);
	view:SetViewId(1);
	view:SetMovableViewer(container);
	view:SetScrollViewer(container);
	view:SetContainer(container);
	container:AddView(view);
	
	--初始化ui
	local uiLoad = createNDUILoad();
	if not CheckP(uiLoad) then
		return false;
	end
	
	uiLoad:Load("ClearList_B_right.ini", view, p.OnUIEvent, 0, 0);
	uiLoad:Free();
	
	local mosterV = GetLabel(view, p.TagMonster);
	local boutV = GetLabel(view, p.TagBout);
	local bagNum =  GetLabel(view, p.TagBagNum);
	
	
	p.mBossZone = {};
	local ids	= _G.GetDataBaseIdList("mapzone");
	for i = 1, #ids do
		local mapid = GetDataBaseDataN("mapzone", ids[i], DB_MAPZONE.MAPID); -- GENERATE_RULE_ID
		if (mapid == p.mInstId) then
			local type = GetDataBaseDataN("mapzone", ids[i], DB_MAPZONE.MONSTER_TYPE)--DB_MAPZONE.GENERATE_RULE_ID); -- 
			p.mBossZone[ids[i]] = GetDataBaseDataS("monstertype", type, DB_MONSTERTYPE.NAME);
		end
	end
	
	local bossName = "";
	for k, v in pairs(p.mBossZone) do
		bossName = bossName .. v;
		bossName = bossName .. "\n"
	end
	
	mosterV:SetText(bossName);
	
	local lst, count = AffixBossFunc.findBossList(p.mInstId, 1);
	boutV:SetText(SafeN2S(count));
	if (p.mItemCount < 0 ) then
		p.mItemCount = 0;
	end
	bagNum:SetText(SafeN2S(p.mItemCount));
	
end

function p.refreshRightLayout()
	p.refreshButton();
end

function p.battleItemInfo(data)
	local nameId = data.nameId;
	local bossName = "";
	local count = data.count;
	local lst = data.list;
	local rtn = "";
	rtn = "打败:"..bossName .. "\n";
	for i = 1, count do
	local strPetName = ConvertS(RolePetFunc.GetPropDesc(lst[i].petId, PET_ATTR.PET_ATTR_NAME));
	strPetName = strPetName or ""
	if (i ~= 1) then
		rtn = rtn ..","
	end
	rtn = rtn .. strPetName .."<c00ff00经验+" .. lst[i].petExp .. "/e";
	end
	
	LogInfo("rtn%s", rtn);
	
	return rtn;
	
end

function p.raiseItemInfo(data)
	local rtn = "副本评价奖励\n"
	local soph = data.soph;
	local money = data.money;
	local itemId = data.item;
	local count = data.count;
	local lst = data.list;
	
	for i = 1, count do
		local strPetName = ConvertS(RolePetFunc.GetPropDesc(lst[i].petId, PET_ATTR.PET_ATTR_NAME));
		strPetName = strPetName or ""
		if (i ~= 1) then
		rtn = rtn ..","
		end
		local sexp = SafeN2S(lst[i].petExp);
		rtn = rtn .. strPetName .."<c00ff00经验+" .. sexp .. "/e";
	end
	rtn = rtn .. "\n副本奖励 " ;
	if soph > 0 then
		local ssoph = SafeN2S(soph)
		rtn  = rtn .. "<cfb6003阅历+" .. ssoph .. "/e";
	end
	if money > 0 then
		local smoney = SafeN2S(money);
		rtn = rtn .. " <c00ff00铜钱+" .. smoney .. "/e";
	end
	rtn = rtn .."\n战利品 "
	if (itemId > 0) then
		local name = ItemFunc.GetName(itemId);
		name = name or "无";
		if name == "" then
			name = "无";
		end
		rtn = rtn .. name;
	else
		rtn = rtn .. "无"
	end
	
	LogInfo("rase boss rtn%s", rtn);
	
	return rtn;
	
end

function p.addLeftItem(strData)
	
	if not strData then
		LogInfo("addLeftItem strData is nil");
		return;
	end

	local container = p.getContainerById(p.TagContainer);
	if not CheckP(container) then
		LogInfo("nil == container");
		return;
	end
	local rectview = container:GetFrameRect();
	container:SetViewSize(CGSizeMake(rectview.size.w, 150));--rectview.size.h));
	
	local lst, count = nil, 1;--MsgMagic.getRoleMatrixList();
	p.mMatrixList = lst;
	p.mCurrentPage = 1;
	
	
	if (count == nil or count < 1) then
		count = 1
	end
	local page = 1;--math.ceil((count-1)/3);
	
	for i = 1,  page do
	
	local view = createUIScrollView();
	
	if not CheckP(view) then
		LogInfo("view == nil");
		return;
	end
	view:Init(false);
	view:SetScrollStyle(UIScrollStyle.Horzontal);
	view:SetViewId(i);
	view:SetMovableViewer(container);
	view:SetScrollViewer(container);
	view:SetContainer(container);
	container:AddView(view);
	
	local nWidthLimit = 220 * ScaleFactor;
	local fontsize = 12;
	local str = strData;
	local lb = _G.CreateColorLabel(str, fontsize, nWidthLimit);
	if CheckP(lb) then
		lb:SetFrameRect(CGRectMake(10, 20, nWidthLimit, 20 * ScaleFactor));
		view:AddChild(lb);
		return true;
	end
	--local label = createNDUILabel();
	--label:SetText("myTextILLIU");
	--view:AddChild(label);
	end
end

function p.refreshButton()
	local layer = p.getRightLayer();
	local btSatr = GetButton(layer, TagBtStart_Cancel);
	local btClose = GetButton(layer, TagBtClose_Finish);
	if CheckP(btSatr) then
		btSatr:SetTitle(p.OpenText[p.mRunFlag]);
	end
	
	if CheckP(btClose) then
		btClose:SetTitle(p.FinishText[p.mRunFlag]);
	end
end

function p.iniContainer()
	local container = p.getContainerById(p.TagContainer);
	if not CheckP(container) then
		LogInfo("nil == container");
		return;
	end
	container:RemoveAllView();
	local rectview = container:GetFrameRect();
	
	container:SetViewSize(CGSizeMake(rectview.size.w, rectview.size.h));
	
	local lst, count = MsgMagic.getRoleMatrixList();
	p.mMatrixList = lst;
	p.mCurrentPage = 1;
	
	
	if (count == nil or count < 1) then
		count = 1
	end
	local page = 1;--math.ceil((count-1)/3);
	
	for i = 1,  page do
	
	local view = createUIScrollView();
	
	if not CheckP(view) then
		LogInfo("view == nil");
		return;
	end
	view:Init(false);
	view:SetScrollStyle(UIScrollStyle.Horzontal);
	view:SetViewId(i);
	view:SetMovableViewer(container);
	view:SetScrollViewer(container);
	view:SetContainer(container);
	container:AddView(view);
	
	--初始化ui
	local uiLoad = createNDUILoad();
	if not CheckP(uiLoad) then
		return false;
	end
	
	uiLoad:Load("NormalCopy_M.ini", view, p.OnUIEvent, 0, 0);
	
	uiLoad:Free();
   end
end


function p.getContainerById(nId)
	local layer = p.getUiLayer();
	local container = GetScrollViewContainer(layer, nId);
	return container;
	
end

function p.getUiLayer()
	local scene = GetSMGameScene();
	if not CheckP(scene) then
		return nil;
	end
	
	local layer = GetUiLayer(scene, p.TagUiLayer);
	if not CheckP(layer) then
		LogInfo("nil == layer")
		return nil;
	end
	
	return layer;
end


function p.clickButton(node) 
	
end

function p.clickStarBt()
	if (p.mRunFlag == p.Flag.Prepare) then
		p.mRunFlag = p.Flag.Running;
		--MsgAffixBoss.sendPickItem(1);
		--MsgAffixBoss.sendNmlClean(p.mInstId, 0, true);
		local time = GetCurrentTime();
		LogInfo("time:%d", p.mTimeNeedSeconds);
		p.mTimeSeconds =  time + p.mTimeNeedSeconds;
		if (p.mTimerTaskTag) then
			UnRegisterTimer(p.mTimerTaskTag);
		end
		p.refreshRightLayout();
		p.mTimerTaskTag = RegisterTimer(p.timerCallback, 1);
	else 
		MsgAffixBoss.sendNmlCancel(p.mInstId);
		p.mRunFlag = p.Flag.Prepare;
		if (p.mTimerTaskTag) then
			UnRegisterTimer(p.mTimerTaskTag);
		end
		p.mTimeSeconds = 0;
		p.refreshRightLayout();
	end
	
end

function p.clickFinishBt()
	--MsgAffixBoss.sendBoxList();
	--MsgAffixBoss.sendPickItem(1);
	if p.mRunFlag == p.Flag.Running then
		MsgAffixBoss.sendNmlFinish(p.mInstId);
		p.mTimeSeconds = 0;
	else
		p.freeData();
		CloseUI(p.TagUiLayer);
	end
end


function p.processNet(msgId, m)
	if (msgId == nil ) then
		LogInfo("processNet msgId == nil" );
	end
	--LogInfo(string.format("processNet%d" , msgId));
	if msgId == NMSG_Type._MSG_AFFIX_BOSS_CLEANUP_BATTLE then
		local str = p.battleItemInfo(m);
		p.addLeftItem(str);
		if (m and m.item and m.item > 0 ) then
			p.mItemCount = p.mItemCount - 1;
			p.refreshBackNum();
		end
	
	elseif msgId == NMSG_Type._MSG_AFFIX_BOSS_CLEANUP_RAISE then
		local str = p.raiseItemInfo(m);
		p.addLeftItem(str);
		if (m and m.item and m.item > 0 ) then
			p.mItemCount = p.mItemCount - 1;
			p.refreshBackNum();
		end
	end
	
	CloseLoadBar();
end

function p.initData()
	MsgAffixBoss.mUIListener = p.processNet;
end

function p.freeData()
	MsgAffixBoss.mUIListener = nil;
	if (p.mTimerTaskTag) then
		UnRegisterTimer(p.mTimerTaskTag);
	end
end

function p.timerCallback(tag)
	if (tag and tag == p.mTimerTaskTag) then
		LogInfo("timerCallback");
		p.refreshTimeUI();
	end
end

function p.getRightLayer() 
	local container = p.getContainerById(p.TagRightContainer);
	
	local layer = container:GetViewById(1);
	if not CheckP(layer) then
		return nil;
	end
	return layer;
end

function p.refreshTimeUI()
	
	local layer = p.getRightLayer();
	local txtV = GetLabel(layer, p.TimeText);
	local cool = p.mTimeSeconds;
	local curTime = GetCurrentTime();
	local time =  cool - curTime;
	LogInfo("cool:%d,cur:%d,time:%d", cool, curTime,time);
	--local isVisible = true;
	if (time < 1) then
		--isVisible = false;
		p.timeFinish();
	end
	--if (txtV and isVisible) then
	if (txtV) then
		local s = p.formatTime(time);
		LogInfo(s);
		txtV:SetText(s);
	end
	
	if (txtV) then
		--txtV:SetVisible(isVisible);
	end
	
	--p.addLeftItem("Test test");
	
end

function p.timeFinish()
	if ( p.mTimerTaskTag ) then
		UnRegisterTimer(p.mTimerTaskTag);
	end
	p.mRunFlag = p.Flag.Prepare;
	p.refreshRightLayout();
end

--返回时间hh:mm:ss---
function p.formatTime(timeNum, format)
	if (timeNum < 0) then
		timeNum = 0;
	end
	if format == nil then
		format = "%02d:%02d:%02d"
	end
	return string.format(format, p.calculateTime(timeNum))
end

function p.calculateTime(timeNum)
	local nSec=timeNum
	local h=0
	local m=0
	local s=0
	h=math.floor(nSec/ 3600)
	m=math.floor((nSec%3600) /60)
	s=nSec%60

	return h,m,s
end


