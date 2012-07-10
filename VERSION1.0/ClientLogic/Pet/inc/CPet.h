/*
 *  CPet.h
 *  DragonDrive
 *
 *  Created by jhzheng on 12-1-14.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#pragma once

#include "Singleton.h"
#include "EnumDef.h"
#include "define.h"
#include <string>
#include <map>
#include <set>
#include "globaldef.h"

enum PET_POSITION
{
	PET_POSITION_PETBAG = 0x01,	//宠物背包位(1)
	PET_POSITION_MAIN	= 0x02,	//主将位(2)
	PET_POSITION_FIGHT	= 0x04,	//出战位(4)
	PET_POSITION_SHOW	= 0x08,	//遛宠位(8)
	PET_POSITION_BAG	= 0x10,	//背包位(16)
	PET_POSITION_REST	= 0x20,	//休息(32)
	PET_POSITION_UNSHOW	= 0x40,	//收回(64)	
};

// 英雄宠物信息
typedef struct _tagPetInfo
{
	std::string str_PET_ATTR_NAME; // 名字STRING
	
	typedef struct _tagPetData{
		int int_PET_ID;
		int int_PET_ATTR_LEVEL; // 等级INT
		int int_PET_ATTR_EXP; // 经验INT
		int int_PET_ATTR_LIFE; // 生命值INT
		int int_PET_ATTR_MAX_LIFE; // 最大生命值INT
		int int_PET_ATTR_MANA; // 魔法值INT
		int int_PET_ATTR_MAX_MANA; // 最大魔法值INT
		int int_PET_ATTR_STR; // 力量INT
		int int_PET_ATTR_STA; // 体质INT
		int int_PET_ATTR_AGI; // 敏捷INT
		int int_PET_ATTR_INI; // 智力INT
		int int_PET_ATTR_LEVEL_INIT; // 初始等级INT
		int int_PET_ATTR_STR_INIT; // 初始力量INT
		int int_PET_ATTR_STA_INIT; // 初始体质INT
		int int_PET_ATTR_AGI_INIT; // 初始敏捷INT
		int int_PET_ATTR_INI_INIT; // 初始智力INT
		int  int_PET_ATTR_LOYAL; // 忠诚度INT
		int int_PET_ATTR_AGE; // 寿命INT
		int int_PET_ATTR_FREE_SP; // 剩余技能点数INT
		int int_PET_PHY_ATK_RATE;//物攻资质
		int int_PET_PHY_DEF_RATE;//物防资质
		int int_PET_MAG_ATK_RATE;//法攻资质
		int int_PET_MAG_DEF_RATE;//法防资质
		int int_PET_ATTR_HP_RATE; // 生命资质
		int int_PET_ATTR_MP_RATE; // 魔法资质
		int int_PET_MAX_SKILL_NUM;//最大可学技能数
		int int_PET_SPEED_RATE;//速度资质
		
		int int_PET_PHY_ATK_RATE_MAX;//物攻资质上限
		int int_PET_PHY_DEF_RATE_MAX;//物防资质上限
		int int_PET_MAG_ATK_RATE_MAX;//法攻资质上限
		int int_PET_MAG_DEF_RATE_MAX;//法防资质上限
		int int_PET_ATTR_HP_RATE_MAX; // 生命资质上限
		int int_PET_ATTR_MP_RATE_MAX; // 魔法资质上限
		int int_PET_SPEED_RATE_MAX;//速度资质上限
		
		int int_PET_GROW_RATE;// 成长率
		int int_PET_GROW_RATE_MAX;// 成长率
		int int_PET_HIT ;//命中
		
		int int_ATTR_FREE_POINT; //自由点数
		int int_PET_ATTR_LEVEUP_EXP; // 升级经验
		int int_PET_ATTR_PHY_ATK; // 物理攻击力INT
		int int_PET_ATTR_PHY_DEF; // 物理防御INT
		int int_PET_ATTR_MAG_ATK; // 法术攻击力INT
		int int_PET_ATTR_MAG_DEF; // 法术抗性INT
		int int_PET_ATTR_HARD_HIT;// 暴击
		int int_PET_ATTR_DODGE;// 闪避
		int int_PET_ATTR_ATK_SPEED;// 攻击速度
		int int_PET_ATTR_TYPE;// 类型
		int int_PET_ATTR_LOOKFACE;//外观
		int bindStatus;//绑定状态
		int int_PET_ATTR_POSITION;
		_tagPetData(){ memset(this, 0, sizeof(*this)); }
	}PetData;
	
	int GetQuality()  { return data.int_PET_ATTR_TYPE % 10; }
	
	PetData data;
}PetInfo;

class CPetMgr : public TSingleton<CPetMgr>
{
public:
	CPetMgr();
	~CPetMgr();
	
	// 单纯取操作
	PetInfo*				GetPet(OBJID idPet);
	
	// 无则创建
	PetInfo*				GetPetWithCreate(OBJID idRoleID, OBJID idPet);
	
	// 获取某个角色所有的宠物数据
	bool					GetPets(OBJID idRoleID, ID_VEC& vecid);
	
	// 获取某个位置宠物的数据
	bool					GetPetWithPos(OBJID idRoleID, PET_POSITION pos, ID_VEC& vecid);
	
	// 获取某个玩家的宠物主将
	PetInfo*				GetMainPet(OBJID idRoleID);
	
	// 获取某个玩家的溜宠
	PetInfo*				GetShowPet(OBJID idRoleID);
	
	// 清除某个角色的所有宠物数据
	bool					DelPets(OBJID idRoleID);
	
	// 清除宠物数据
	bool					DelPet(OBJID idPet);
	
	bool					DelAll();
	
	// 增加某只宠物某个技能
	void					AddSkill(OBJID idRoleID, OBJID idPet, OBJID idSkill);
	
	// 删除某只宠物某个技能
	bool					DelSkill(OBJID idRoleID, OBJID idPet, OBJID idSkill);
	
	// 删除某个角色某只宠物的所有技能
	bool					DelSkill(OBJID idRoleID, OBJID idPet);
	
	// 删除某个角色的所有宠物所有技能
	bool					DelSkills(OBJID idRoleID);
	
	bool					DelSkill(OBJID idPet);
	
	std::set<OBJID>&		GetSkillList(SKILL_TYPE type, OBJID idPet);
	
	bool					GetSkillList(OBJID idPet, std::set<OBJID>& setid);
	
	int						SkillSize(OBJID idPet);
	
	static unsigned int		getPetQualityColor(OBJID idType);
	
private:
	
	typedef std::map<OBJID, PetInfo*>				MAP_PETS;
	
	typedef std::map<OBJID, MAP_PETS>				MAP_ROLE_PETS;
	
	typedef std::set<OBJID>							SET_ID;
	
	typedef std::map<OBJID, SET_ID>					MAP_SKILL;
	
	typedef std::map<OBJID, MAP_SKILL>				MAP_PET_SKILL;
	
	MAP_ROLE_PETS	m_mapRolePets;
	
	MAP_PET_SKILL	m_mapPetSkill;
	
	SET_ID			m_setSkillCache;
};

#define PetMgrObj CPetMgr::GetSingleton()

std::string getPetType(int type);