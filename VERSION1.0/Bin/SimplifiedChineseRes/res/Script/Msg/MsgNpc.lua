-----------------------------------------------------描述: 玩家npc网络消息处理及其逻辑--时间: 2012.2.24--作者: jhzheng---------------------------------------------------MsgNpc = {}local p = MsgNpc;local NPC_ACTION_NPC_OPERATION_REQUEST						= 1;function p.SendOpt(nNpcId, nAction)	if not CheckN(nTaskId) or not CheckN(nAction) then		return false;	end		local netdata = createNDTransData(NMSG_Type._MSG_TASK_NPC_ACTION);	if nil == netdata then		return false;	end	netdata:WriteByte(NPC_ACTION_NPC_OPERATION_REQUEST);	netdata:WriteInt(nNpcId);	netdata:WriteInt(nAction);	SendMsg(netdata);	netdata:Free();	LogInfo("send npc opt action[%d]", nAction);	return true;end