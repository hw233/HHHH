/*
 *  CPet.mm
 *  DragonDrive
 *
 *  Created by jhzheng on 12-1-14.
 *  Copyright 2012 (网龙)DeNA. All rights reserved.
 *
 */

#include "CPet.h"
#include "BattleMgr.h"

CPetMgr::CPetMgr()
{
}

CPetMgr::~CPetMgr()
{
}

// 单纯取操作
PetInfo*				
CPetMgr::GetPet(OBJID idPet)
{
	MAP_ROLE_PETS::iterator it = m_mapRolePets.begin();
	
	for (; it != m_mapRolePets.end(); it++) 
	{
		MAP_PETS& pets = it->second;
		
		MAP_PETS::iterator itPet = pets.find(idPet);
		
		if (itPet != pets.end())
			return itPet->second;
	}
	
	return NULL;
}

// 无则创建
PetInfo*				
CPetMgr::GetPetWithCreate(OBJID idRoleID, OBJID idPet)
{
	MAP_ROLE_PETS::iterator it = m_mapRolePets.find(idRoleID);
	
	if (it == m_mapRolePets.end())
	{
		m_mapRolePets.insert(std::pair<OBJID, MAP_PETS>(idRoleID, MAP_PETS()));
	}
	
	MAP_PETS& pets = m_mapRolePets[idRoleID];
	
	MAP_PETS::iterator itPet = pets.find(idPet);
	
	if (itPet == pets.end())
	{
		PetInfo* petInfo = new PetInfo;
		petInfo->data.int_PET_ID = idPet;
		pets.insert(std::pair<OBJID, PetInfo*>(idPet, petInfo));
	}
	
	return pets[idPet];
}

// 获取某个角色所有的宠物数据
bool					
CPetMgr::GetPets(OBJID idRoleID, ID_VEC& vecid)
{
	MAP_ROLE_PETS::iterator it = m_mapRolePets.find(idRoleID);
	
	if (it != m_mapRolePets.end())
	{
		MAP_PETS& pets = it->second;
		
		MAP_PETS::iterator itPet = pets.begin();
		
		for (; itPet != pets.end(); itPet++) 
		{
			vecid.push_back(itPet->first);
		}
		
		return true;
	}

	return false;
}

// 获取某个玩家的宠物主将
PetInfo*				
CPetMgr::GetMainPet(OBJID idRoleID)
{
	MAP_ROLE_PETS::iterator it = m_mapRolePets.find(idRoleID);
	
	if (it != m_mapRolePets.end())
	{
		MAP_PETS& pets = it->second;
		
		MAP_PETS::iterator itPet = pets.begin();
		
		for (; itPet != pets.end(); itPet++) 
		{
			if (itPet->second->data.int_PET_ATTR_POSITION & PET_POSITION_MAIN)
				return itPet->second;
		}
	}
	
	return NULL;
}

// 获取某个玩家的溜宠
PetInfo*				
CPetMgr::GetShowPet(OBJID idRoleID)
{
	MAP_ROLE_PETS::iterator it = m_mapRolePets.find(idRoleID);
	
	if (it != m_mapRolePets.end())
	{
		MAP_PETS& pets = it->second;
		
		MAP_PETS::iterator itPet = pets.begin();
		
		for (; itPet != pets.end(); itPet++) 
		{
			if (itPet->second->data.int_PET_ATTR_POSITION & PET_POSITION_SHOW)
				return itPet->second;
		}
	}
	
	return NULL;
}

// 获取某个位置宠物的数据				
bool					
CPetMgr::GetPetWithPos(OBJID idRoleID, PET_POSITION pos, ID_VEC& vecid)
{
	bool ret = false;
	
	MAP_ROLE_PETS::iterator it = m_mapRolePets.find(idRoleID);
	
	if (it != m_mapRolePets.end())
	{
		MAP_PETS& pets = it->second;
		
		MAP_PETS::iterator itPet = pets.begin();
		
		for (; itPet != pets.end(); itPet++) 
		{
			if (itPet->second->data.int_PET_ATTR_POSITION & pos)
			{
				vecid.push_back(itPet->first);
				
				ret = true;
			}
		}
	}
	
	return ret;
}

// 清除某个角色的所有宠物数据
bool					
CPetMgr::DelPets(OBJID idRoleID)
{
	MAP_ROLE_PETS::iterator it = m_mapRolePets.find(idRoleID);
	
	for (; it != m_mapRolePets.end(); it++) 
	{
		MAP_PETS& pets = it->second;
		
		MAP_PETS::iterator itPet = pets.begin();
		
		for (; itPet != pets.end(); itPet++) 
		{
			delete itPet->second;
		}
	}
	
	m_mapRolePets.erase(it);
	
	return true;
}

// 清除宠物数据
bool					
CPetMgr::DelPet(OBJID idPet)
{
	DelSkill(idPet);
	
	MAP_ROLE_PETS::iterator it = m_mapRolePets.begin();
	
	for (; it != m_mapRolePets.end(); it++) 
	{
		MAP_PETS& pets = it->second;
		
		MAP_PETS::iterator itPet = pets.find(idPet);
		
		if (itPet != pets.end())
		{
			delete itPet->second;
			
			pets.erase(itPet);
			
			return true;
		}
	}
	
	return false;
}

bool					
CPetMgr::DelAll()
{
	MAP_ROLE_PETS::iterator it = m_mapRolePets.begin();
	
	for (; it != m_mapRolePets.end(); it++) 
	{
		MAP_PETS& pets = it->second;
		
		MAP_PETS::iterator itPet = pets.begin();
		
		for (; itPet != pets.end(); itPet++) 
		{
			delete itPet->second;
		}
		
		pets.clear();
	}
	
	m_mapRolePets.clear();
	
	m_mapPetSkill.clear();
	
	return false;
}

// 增加某只宠物某个技能
void					
CPetMgr::AddSkill(OBJID idRoleID, OBJID idPet, OBJID idSkill)
{
	MAP_PET_SKILL::iterator itRole = m_mapPetSkill.find(idRoleID);
	
	if (itRole == m_mapPetSkill.end())
	{
		m_mapPetSkill.insert(std::pair<OBJID, MAP_SKILL>(idRoleID, MAP_SKILL()));
	}
	
	MAP_SKILL& mapPetSkill = m_mapPetSkill[idRoleID];
	
	MAP_SKILL::iterator itSkills = mapPetSkill.find(idPet);
	
	if (itSkills == mapPetSkill.end())
	{
		mapPetSkill.insert(std::pair<OBJID, SET_ID>(idPet, SET_ID()));
	}
	
	SET_ID& setid = mapPetSkill[idPet];
	
	setid.insert(idSkill);
}

// 删除某只宠物某个技能
bool					
CPetMgr::DelSkill(OBJID idRoleID, OBJID idPet, OBJID idSkill)
{
	MAP_PET_SKILL::iterator itRole = m_mapPetSkill.find(idRoleID);
	
	if (itRole == m_mapPetSkill.end())
	{
		return false;
	}
	
	MAP_SKILL& mapPetSkill = itRole->second;
	
	MAP_SKILL::iterator itSkills = mapPetSkill.find(idPet);
	
	if (itSkills == mapPetSkill.end())
	{
		return false;
	}
	
	SET_ID& setid = mapPetSkill[idPet];
	
	setid.erase(idSkill);
	
	return true;
}

// 删除某个角色某只宠物的所有技能
bool					
CPetMgr::DelSkill(OBJID idRoleID, OBJID idPet)
{
	MAP_PET_SKILL::iterator itRole = m_mapPetSkill.find(idRoleID);
	
	if (itRole == m_mapPetSkill.end())
	{
		return false;
	}
	
	MAP_SKILL& mapPetSkill = itRole->second;
	
	MAP_SKILL::iterator itSkills = mapPetSkill.find(idPet);
	
	if (itSkills == mapPetSkill.end())
	{
		return false;
	}
	
	mapPetSkill.erase(itSkills);
	return true;
}

// 删除某个角色的所有宠物所有技能
bool					
CPetMgr::DelSkills(OBJID idRoleID)
{
	MAP_PET_SKILL::iterator itRole = m_mapPetSkill.find(idRoleID);
	
	if (itRole == m_mapPetSkill.end())
	{
		return false;
	}
	
	m_mapPetSkill.erase(itRole);
	
	return true;
}

bool					
CPetMgr::DelSkill(OBJID idPet)
{
	MAP_PET_SKILL::iterator itRole = m_mapPetSkill.begin();
	
	for (; itRole != m_mapPetSkill.end(); itRole++) 
	{
		MAP_SKILL& mapPetSkill = itRole->second;
		
		MAP_SKILL::iterator itSkills = mapPetSkill.find(idPet);
		
		if (itSkills != mapPetSkill.end())
		{
			mapPetSkill.erase(itSkills);
			
			return true;
		}
	}
	
	return false;
}

std::set<OBJID>&					
CPetMgr::GetSkillList(SKILL_TYPE type, OBJID idPet)
{
	m_setSkillCache.clear();
	
	MAP_PET_SKILL::iterator itRole = m_mapPetSkill.begin();
	
	for (; itRole != m_mapPetSkill.end(); itRole++) 
	{
		MAP_SKILL& mapPetSkill = itRole->second;
		
		MAP_SKILL::iterator itSkills = mapPetSkill.find(idPet);
		
		if (itSkills != mapPetSkill.end())
		{
			SET_ID& setid = itSkills->second;
			
			for (SET_ID::iterator itSet = setid.begin(); itSet != setid.end(); itSet++) 
			{
				BattleMgr& bm = BattleMgrObj;
				BattleSkill* skill = bm.GetBattleSkill(*itSet);
				if (!skill) {
					continue;
				}
				
				if (skill->getType() == type) 
				{
					m_setSkillCache.insert(*itSet);
				}
			}
		}
	}
	
	return m_setSkillCache;
}

int						
CPetMgr::SkillSize(OBJID idPet)
{
	MAP_PET_SKILL::iterator itRole = m_mapPetSkill.begin();
	
	for (; itRole != m_mapPetSkill.end(); itRole++) 
	{
		MAP_SKILL& mapPetSkill = itRole->second;
		
		MAP_SKILL::iterator itSkills = mapPetSkill.find(idPet);
		
		if (itSkills != mapPetSkill.end())
		{
			return itSkills->second.size();
		}
	}
	
	return 0;
}

bool					
CPetMgr::GetSkillList(OBJID idPet, std::set<OBJID>& setid)
{
	MAP_PET_SKILL::iterator itRole = m_mapPetSkill.begin();
	
	for (; itRole != m_mapPetSkill.end(); itRole++) 
	{
		MAP_SKILL& mapPetSkill = itRole->second;
		
		MAP_SKILL::iterator itSkills = mapPetSkill.find(idPet);
		
		if (itSkills != mapPetSkill.end())
		{
			setid = itSkills->second;
			
			return true;
		}
	}
	
	return false;
}

unsigned int CPetMgr::getPetQualityColor(OBJID idType)
{
	unsigned int unClr	= 0xe5cc80;
	switch (idType % 10) {
		case 5:
			unClr = 0x9d9d9d;
			break;
		case 6:
			unClr = 0x1eff00;
			break;
		case 7:
			unClr = 0x0088ff;
			break;
		case 8:
			unClr = 0xbb00ff;
			break;
		case 9:
			unClr = 0xffff00;
			break;
		default:
			break;
	}
	return unClr;
}

std::string getPetType(int type) {
	std::string s = "";
	switch (type / 10 % 10) {
		case 1:
			s = NDCommonCString("LuMang");
			break;
		case 2:
			s = NDCommonCString("LengJing");
			break;
		case 3:
			s = NDCommonCString("TaoQi");
			break;
		case 4:
			s = NDCommonCString("HangHou");
			break;
		case 5:
			s = NDCommonCString("DangXiao");
			break;
	}
	return s;
}