////////////////////////////////////////////////////////////////////////
// Copyright(c) 1999-2009, TQ Digital Entertainment, All Rights Reserved
// Author:  Create By DbDefLoader.exe
// Created: 2012-03-28
////////////////////////////////////////////////////////////////////////

// DBServer = 192.168.9.104
// DBName = smys_db

#ifndef _DB_TABLES_DEF_ENUM_H_
#define _DB_TABLES_DEF_ENUM_H_

enum DB_ACTIVITY
{
	DB_ACTIVITY_ID,
	DB_ACTIVITY_TYPE,
	DB_ACTIVITY_SUBTYPE,
	DB_ACTIVITY_IDOWNER,
	DB_ACTIVITY_NAME,
	DB_ACTIVITY_DATA0,
	DB_ACTIVITY_DATA1,
	DB_ACTIVITY_DATA2,
};

enum DB_ANTHROPOLOGTYPE
{
	DB_ANTHROPOLOGTYPE_USERID,
	DB_ANTHROPOLOGTYPE_ANTHROPOLOG_TIME,
	DB_ANTHROPOLOGTYPE_GENERAL_CHANCE,
	DB_ANTHROPOLOGTYPE_MONEYREIKI_COLLECT,
	DB_ANTHROPOLOGTYPE_MAP_MONSTER1,
	DB_ANTHROPOLOGTYPE_MAP_MONSTER2,
	DB_ANTHROPOLOGTYPE_MAP_BOSSMONSTER,
};

enum DB_AUCTION
{
	DB_AUCTION_ID,
	DB_AUCTION_IDITEM,
	DB_AUCTION_IDOWNER,
	DB_AUCTION_IDITEMTYPE,
	DB_AUCTION_OWNER_NAME,
	DB_AUCTION_BEGINTIME,
	DB_AUCTION_MIN_PRICE,
	DB_AUCTION_IDBIDDER,
	DB_AUCTION_BIDDER_NAME,
	DB_AUCTION_MAX_PRICE,
	DB_AUCTION_PRICETYPE,
	DB_AUCTION_GMONEY,
};

enum DB_BATTLE_RECORD
{
	DB_BATTLE_RECORD_ID,
	DB_BATTLE_RECORD_TYPE,
	DB_BATTLE_RECORD_COUNT,
	DB_BATTLE_RECORD_TIME,
	DB_BATTLE_RECORD_MSG,
};

enum DB_BATTLEFIELD_MAP_TYPE
{
	DB_BATTLEFIELD_MAP_TYPE_ID,
	DB_BATTLEFIELD_MAP_TYPE_NAME,
	DB_BATTLEFIELD_MAP_TYPE_TYPE,
	DB_BATTLEFIELD_MAP_TYPE_MAPDOC,
	DB_BATTLEFIELD_MAP_TYPE_JOIN_LV_MIN,
	DB_BATTLEFIELD_MAP_TYPE_JOIN_NUM_MIN,
	DB_BATTLEFIELD_MAP_TYPE_JOIN_NUM_MAX,
	DB_BATTLEFIELD_MAP_TYPE_BATTLEFIELD_TIME,
	DB_BATTLEFIELD_MAP_TYPE_CAMP_ID_1,
	DB_BATTLEFIELD_MAP_TYPE_CAMP_NAME_1,
	DB_BATTLEFIELD_MAP_TYPE_CAMP_BANNER_1,
	DB_BATTLEFIELD_MAP_TYPE_CAMP_ID_2,
	DB_BATTLEFIELD_MAP_TYPE_CAMP_NAME_2,
	DB_BATTLEFIELD_MAP_TYPE_CAMP_BANNER_2,
	DB_BATTLEFIELD_MAP_TYPE_BIRTH_MAPID_1,
	DB_BATTLEFIELD_MAP_TYPE_BIRTH_X_1,
	DB_BATTLEFIELD_MAP_TYPE_BIRTH_Y_1,
	DB_BATTLEFIELD_MAP_TYPE_BIRTH_MAPID_2,
	DB_BATTLEFIELD_MAP_TYPE_BIRTH_X_2,
	DB_BATTLEFIELD_MAP_TYPE_BIRTH_Y_2,
	DB_BATTLEFIELD_MAP_TYPE_WIN_TYPE,
	DB_BATTLEFIELD_MAP_TYPE_PARAMETER_1,
	DB_BATTLEFIELD_MAP_TYPE_PARAMETER_2,
	DB_BATTLEFIELD_MAP_TYPE_PARAMETER_3,
	DB_BATTLEFIELD_MAP_TYPE_INITIAL_INTEGRAL,
	DB_BATTLEFIELD_MAP_TYPE_ITEM_1,
	DB_BATTLEFIELD_MAP_TYPE_ITEM_2,
	DB_BATTLEFIELD_MAP_TYPE_ITEM_3,
};

enum DB_BOSS_GROW
{
	DB_BOSS_GROW_MONSTER_TYPE,
	DB_BOSS_GROW_LIFE_GROW,
	DB_BOSS_GROW_LIFE_GROW_MAX,
	DB_BOSS_GROW_PHY_ATK_GROW,
	DB_BOSS_GROW_SKILL_ATK_GROW,
	DB_BOSS_GROW_LEVEL_MAX,
	DB_BOSS_GROW_MONEY,
	DB_BOSS_GROW_MONEY_GROW,
	DB_BOSS_GROW_MONEY_GROW_MAX,
};

enum DB_BOX_ITEM
{
	DB_BOX_ITEM_ID,
	DB_BOX_ITEM_ITEMTYPE,
	DB_BOX_ITEM_AMOUNT,
	DB_BOX_ITEM_CHANCE,
};

enum DB_BOX_TYPE
{
	DB_BOX_TYPE_ID,
	DB_BOX_TYPE_NAME,
	DB_BOX_TYPE_MONEY,
	DB_BOX_TYPE_EMONEY,
	DB_BOX_TYPE_ITEMNUM,
	DB_BOX_TYPE_BIND_FLAG,
};

enum DB_BUG_REPORT
{
	DB_BUG_REPORT_ID_REPORTER,
	DB_BUG_REPORT_OCCUR_TIME,
	DB_BUG_REPORT_INFO,
};

enum DB_CAMP_STORAGE
{
	DB_CAMP_STORAGE_ID,
	DB_CAMP_STORAGE_CAMP,
	DB_CAMP_STORAGE_REPUTE_TOTAL,
	DB_CAMP_STORAGE_CAMP_REPUTE_TOTAL,
	DB_CAMP_STORAGE_MONEY,
	DB_CAMP_STORAGE_EMONEY,
	DB_CAMP_STORAGE_WEAPON,
	DB_CAMP_STORAGE_ARMOR,
	DB_CAMP_STORAGE_MEDICINE,
};

enum DB_CHARGEGIFT
{
	DB_CHARGEGIFT_ID,
	DB_CHARGEGIFT_BEGIN_COUNT,
	DB_CHARGEGIFT_COUNT,
	DB_CHARGEGIFT_ITEMTYPE,
	DB_CHARGEGIFT_ITEM_AMOUNT,
	DB_CHARGEGIFT_FLAG,
	DB_CHARGEGIFT_START_TIME,
	DB_CHARGEGIFT_END_TIME,
	DB_CHARGEGIFT_BIND_FLAG,
};

enum DB_COMPETITION
{
	DB_COMPETITION_ID,
	DB_COMPETITION_PERIOD,
	DB_COMPETITION_TYPE,
	DB_COMPETITION_USER_ID,
	DB_COMPETITION_USER_NAME,
	DB_COMPETITION_TARGET_ID,
	DB_COMPETITION_WIN,
	DB_COMPETITION_WIN_NUM,
	DB_COMPETITION_RANKING,
	DB_COMPETITION_USER_LEVEL,
};

enum DB_CONFIG
{
	DB_CONFIG_ID,
	DB_CONFIG_TYPE,
	DB_CONFIG_DATA1,
	DB_CONFIG_DATA2,
	DB_CONFIG_DATA3,
	DB_CONFIG_DATA4,
	DB_CONFIG_DESCRIB,
};

enum DB_CQ_CARD
{
	DB_CQ_CARD_ID,
	DB_CQ_CARD_TYPE,
	DB_CQ_CARD_ACCOUNT_ID,
	DB_CQ_CARD_REF_ID,
	DB_CQ_CARD_CHK_SUM,
	DB_CQ_CARD_TIME_STAMP,
	DB_CQ_CARD_USED,
	DB_CQ_CARD_ORDERNUMBER,
	DB_CQ_CARD_FLAG,
	DB_CQ_CARD_CARD_IN_TIME,
	DB_CQ_CARD_ITEMCOUNT,
	DB_CQ_CARD_SYSTEMTYPE,
};

enum DB_CQ_CARD2
{
	DB_CQ_CARD2_ID,
	DB_CQ_CARD2_TYPE,
	DB_CQ_CARD2_ACCOUNT_ID,
	DB_CQ_CARD2_REF_ID,
	DB_CQ_CARD2_CHK_SUM,
	DB_CQ_CARD2_TIME_STAMP,
	DB_CQ_CARD2_USED,
	DB_CQ_CARD2_ORDERNUMBER,
	DB_CQ_CARD2_FLAG,
	DB_CQ_CARD2_CARD_IN_TIME,
	DB_CQ_CARD2_ITEMCOUNT,
	DB_CQ_CARD2_SYSTEMTYPE,
};

enum DB_DAILY_ACTIVITY
{
	DB_DAILY_ACTIVITY_ID,
	DB_DAILY_ACTIVITY_PRE_TASK,
	DB_DAILY_ACTIVITY_TYPE,
	DB_DAILY_ACTIVITY_PARAM,
	DB_DAILY_ACTIVITY_NAME,
	DB_DAILY_ACTIVITY_DESC,
	DB_DAILY_ACTIVITY_DESC1,
	DB_DAILY_ACTIVITY_EXTRA_EXP,
	DB_DAILY_ACTIVITY_EXTRA_MONEY,
	DB_DAILY_ACTIVITY_EXTRA_SOPH,
	DB_DAILY_ACTIVITY_EXTRA_ITEM,
};

enum DB_DAO_LEVELUP_EXP
{
	DB_DAO_LEVELUP_EXP_ID,
	DB_DAO_LEVELUP_EXP_QUALITY,
	DB_DAO_LEVELUP_EXP_LEVEL,
	DB_DAO_LEVELUP_EXP_EXP,
};

enum DB_DROP_RULE
{
	DB_DROP_RULE_ID,
	DB_DROP_RULE_MONSTER_DROP_RULE,
	DB_DROP_RULE_TYPE,
	DB_DROP_RULE_CHANCE,
	DB_DROP_RULE_ITEMTYPE,
	DB_DROP_RULE_EQUIPTYPE,
	DB_DROP_RULE_QUALITY0,
	DB_DROP_RULE_QUALITY3,
	DB_DROP_RULE_QUALITY5,
	DB_DROP_RULE_QUALITY6,
	DB_DROP_RULE_QUALITY7,
	DB_DROP_RULE_AGAIN_DROP,
	DB_DROP_RULE_BEGIN_TIME,
	DB_DROP_RULE_END_TIME,
};

enum DB_DROP_RULE_NUM
{
	DB_DROP_RULE_NUM_ITEMTYPE,
	DB_DROP_RULE_NUM_NUM_DAY,
	DB_DROP_RULE_NUM_NUM_ALL,
	DB_DROP_RULE_NUM_NUM,
};

enum DB_DYNAMAP
{
	DB_DYNAMAP_ID,
	DB_DYNAMAP_NAME,
	DB_DYNAMAP_DESCR,
	DB_DYNAMAP_MAPDOC,
	DB_DYNAMAP_TYPE,
	DB_DYNAMAP_OWNERID,
	DB_DYNAMAP_OWNERTYPE,
	DB_DYNAMAP_PORTAL0_X,
	DB_DYNAMAP_PORTAL0_Y,
	DB_DYNAMAP_REBORN_MAP_ID,
	DB_DYNAMAP_REBORN_X,
	DB_DYNAMAP_REBORN_Y,
	DB_DYNAMAP_LINK_MAP_ID,
	DB_DYNAMAP_LINK_MAP_X,
	DB_DYNAMAP_LINK_MAP_Y,
	DB_DYNAMAP_RESOURCE_LEV,
	DB_DYNAMAP_IDSERVER,
};

enum DB_DYNAMAP_CFG
{
	DB_DYNAMAP_CFG_ID,
	DB_DYNAMAP_CFG_ID_MOTHERMAP,
	DB_DYNAMAP_CFG_ID_MOTHERMAP_NAME,
	DB_DYNAMAP_CFG_HUMAN_LIMIT,
	DB_DYNAMAP_CFG_ENTER_TIME_LIMIT,
	DB_DYNAMAP_CFG_ENTER_TYPE,
	DB_DYNAMAP_CFG_LEVEL_REQ,
	DB_DYNAMAP_CFG_LEVEL_LIMIT,
	DB_DYNAMAP_CFG_CONDITION_RANGE,
	DB_DYNAMAP_CFG_KEEP_TIME,
};

enum DB_DYNANPC
{
	DB_DYNANPC_ID,
	DB_DYNANPC_NAME,
	DB_DYNANPC_TYPE,
	DB_DYNANPC_LOOKFACE,
	DB_DYNANPC_BASE,
	DB_DYNANPC_IDXSERVER,
	DB_DYNANPC_MAPID,
	DB_DYNANPC_CELLX,
	DB_DYNANPC_CELLY,
	DB_DYNANPC_ID_ACTION,
	DB_DYNANPC_TASK0,
	DB_DYNANPC_TASK1,
	DB_DYNANPC_TASK2,
	DB_DYNANPC_TASK3,
	DB_DYNANPC_TASK4,
	DB_DYNANPC_TASK5,
	DB_DYNANPC_TASK6,
	DB_DYNANPC_TASK7,
	DB_DYNANPC_TASK8,
	DB_DYNANPC_TASK9,
	DB_DYNANPC_DATA0,
	DB_DYNANPC_DATA1,
	DB_DYNANPC_DATA2,
	DB_DYNANPC_DATA3,
	DB_DYNANPC_DATASTR,
	DB_DYNANPC_SORT,
	DB_DYNANPC_SHOPID,
	DB_DYNANPC_CAMP,
	DB_DYNANPC_DYNAFLAG,
	DB_DYNANPC_ID_MONSTER_TYPE,
	DB_DYNANPC_ID_GENERATE,
};

enum DB_EMONEY
{
	DB_EMONEY_ID,
	DB_EMONEY_TYPE,
	DB_EMONEY_ID_SOURCE,
	DB_EMONEY_ID_TARGET,
	DB_EMONEY_NUMBER,
	DB_EMONEY_CHK_SUM,
	DB_EMONEY_TIME_STAMP,
	DB_EMONEY_SOURCE_EMONEY,
	DB_EMONEY_TARGET_EMONEY,
};

enum DB_EMONEY_WATER
{
	DB_EMONEY_WATER_ID,
	DB_EMONEY_WATER_TYPE,
	DB_EMONEY_WATER_ID_SOURCE,
	DB_EMONEY_WATER_IDTARGET,
	DB_EMONEY_WATER_NUMBER,
	DB_EMONEY_WATER_CHK_SUM,
	DB_EMONEY_WATER_TIME_STAMP,
	DB_EMONEY_WATER_SOURCE_EMONEY,
	DB_EMONEY_WATER_TARGET_EMONEY,
};

enum DB_ENHANCED
{
	DB_ENHANCED_ID,
	DB_ENHANCED_REQ_MONEY,
};

enum DB_ENTITY_CONFIG
{
	DB_ENTITY_CONFIG_ID,
	DB_ENTITY_CONFIG_NAME,
	DB_ENTITY_CONFIG_LOOKFACE,
	DB_ENTITY_CONFIG_NPC,
	DB_ENTITY_CONFIG_LEVEL,
	DB_ENTITY_CONFIG_USER_LEVEL,
	DB_ENTITY_CONFIG_UPLEV_DEPEND_1,
	DB_ENTITY_CONFIG_UPLEV_DEPEND_2,
	DB_ENTITY_CONFIG_UPLEV_NEED_RICE,
	DB_ENTITY_CONFIG_UPLEV_NEED_TIMBER,
	DB_ENTITY_CONFIG_UPLEV_NEED_STONE,
	DB_ENTITY_CONFIG_UPLEV_NEED_GOLD,
	DB_ENTITY_CONFIG_UPLEV_NEED_VAMISH,
	DB_ENTITY_CONFIG_UPLEV_NEED_MONEY,
	DB_ENTITY_CONFIG_UPLEV_NEED_EMONEY,
	DB_ENTITY_CONFIG_UPKEEP_NEED_RICE,
	DB_ENTITY_CONFIG_UPKEEP_NEED_TIMBER,
	DB_ENTITY_CONFIG_UPKEEP_NEED_STONE,
	DB_ENTITY_CONFIG_UPKEEP_NEED_GOLD,
	DB_ENTITY_CONFIG_UPKEEP_NEED_VAMISH,
	DB_ENTITY_CONFIG_UPLEV_NEED_TIME,
	DB_ENTITY_CONFIG_AMOUNT_LIMIT,
	DB_ENTITY_CONFIG_PRODUCT_EXP,
	DB_ENTITY_CONFIG_MAX_NUM,
};

enum DB_EQUIPSET_CFG
{
	DB_EQUIPSET_CFG_ID,
	DB_EQUIPSET_CFG_NAME,
	DB_EQUIPSET_CFG_EQUIP_ID_1,
	DB_EQUIPSET_CFG_EQUIP_NAME_1,
	DB_EQUIPSET_CFG_EQUIP_ID_2,
	DB_EQUIPSET_CFG_EQUIP_NAME_2,
	DB_EQUIPSET_CFG_EQUIP_ID_3,
	DB_EQUIPSET_CFG_EQUIP_NAME_3,
	DB_EQUIPSET_CFG_EQUIP_ID_4,
	DB_EQUIPSET_CFG_EQUIP_NAME_4,
	DB_EQUIPSET_CFG_EQUIP_ID_5,
	DB_EQUIPSET_CFG_EQUIP_NAME_5,
	DB_EQUIPSET_CFG_EQUIP_ID_6,
	DB_EQUIPSET_CFG_EQUIP_NAME_6,
	DB_EQUIPSET_CFG_EQUIP_ID_7,
	DB_EQUIPSET_CFG_EQUIP_NAME_7,
	DB_EQUIPSET_CFG_EQUIP_SET_1_NUM,
	DB_EQUIPSET_CFG_EQUIP_SET_1_EFFECT,
	DB_EQUIPSET_CFG_EQUIP_SET_1_DES,
	DB_EQUIPSET_CFG_EQUIP_SET_2_NUM,
	DB_EQUIPSET_CFG_EQUIP_SET_2_EFFECT,
	DB_EQUIPSET_CFG_EQUIP_SET_2_DES,
	DB_EQUIPSET_CFG_EQUIP_SET_3_NUM,
	DB_EQUIPSET_CFG_EQUIP_SET_3_EFFECT,
	DB_EQUIPSET_CFG_EQUIP_SET_3_DES,
	DB_EQUIPSET_CFG_FLAG,
};

enum DB_EVENT
{
	DB_EVENT_ID,
	DB_EVENT_TYPE,
	DB_EVENT_DATA,
	DB_EVENT_PARAM,
};

enum DB_EXCHANGE
{
	DB_EXCHANGE_ID,
	DB_EXCHANGE_TYPE,
	DB_EXCHANGE_TEXT,
	DB_EXCHANGE_ITEMTYPE,
	DB_EXCHANGE_NUM,
};

enum DB_FARM_MESSAGE
{
	DB_FARM_MESSAGE_ID,
	DB_FARM_MESSAGE_FARM_ID,
	DB_FARM_MESSAGE_TYPE,
	DB_FARM_MESSAGE_ENTITY_ID,
	DB_FARM_MESSAGE_PROD_ID,
	DB_FARM_MESSAGE_SENDER_ID,
	DB_FARM_MESSAGE_SENDER_NAME,
	DB_FARM_MESSAGE_CONTENT,
	DB_FARM_MESSAGE_SEND_TIME,
};

enum DB_FARM_PRODUCT
{
	DB_FARM_PRODUCT_ID,
	DB_FARM_PRODUCT_FARM_ID,
	DB_FARM_PRODUCT_ENTITY_ID,
	DB_FARM_PRODUCT_LAND_TYPE,
	DB_FARM_PRODUCT_PRODUCT_CONFIG_ID,
	DB_FARM_PRODUCT_CUR_SEASON,
	DB_FARM_PRODUCT_HARVEST_TIME,
	DB_FARM_PRODUCT_PRODUCT_NUM,
};

enum DB_FARM_PRODUCT_CONFIG
{
	DB_FARM_PRODUCT_CONFIG_ID,
	DB_FARM_PRODUCT_CONFIG_PRODUCT_NAME,
	DB_FARM_PRODUCT_CONFIG_PRODUCT_TYPE,
	DB_FARM_PRODUCT_CONFIG_PRODUCT_SEASON,
	DB_FARM_PRODUCT_CONFIG_SEED_LOOKFACE,
	DB_FARM_PRODUCT_CONFIG_HARVEST_LOOKFACE,
	DB_FARM_PRODUCT_CONFIG_TIME_TO_HARVEST,
	DB_FARM_PRODUCT_CONFIG_NEXT_HARVEST_TIME,
	DB_FARM_PRODUCT_CONFIG_BASIC_PRODUCT_NUM,
	DB_FARM_PRODUCT_CONFIG_PRODUCT_ID,
	DB_FARM_PRODUCT_CONFIG_FARM_EXP,
	DB_FARM_PRODUCT_CONFIG_STEAL_NUM_LIMIT,
};

enum DB_FARMENTITY
{
	DB_FARMENTITY_ID,
	DB_FARMENTITY_NAME,
	DB_FARMENTITY_TYPE,
	DB_FARMENTITY_OWNER_FARMID,
	DB_FARMENTITY_STATUS,
	DB_FARMENTITY_NPC_ID,
	DB_FARMENTITY_CREATE_TIME,
	DB_FARMENTITY_UPLEV_END_TIME,
};

enum DB_FARMLAND
{
	DB_FARMLAND_ID,
	DB_FARMLAND_NAME,
	DB_FARMLAND_ADDRESS,
	DB_FARMLAND_NPC_ID,
	DB_FARMLAND_LOOKFACE,
	DB_FARMLAND_OWNER_ID,
	DB_FARMLAND_OWNER_TYPE,
	DB_FARMLAND_MOTHERLAND,
	DB_FARMLAND_MAP_ID,
	DB_FARMLAND_CREATE_TIME,
	DB_FARMLAND_UPKEEP_TIME,
	DB_FARMLAND_DEL_TIME,
	DB_FARMLAND_RICE,
	DB_FARMLAND_TIMBER,
	DB_FARMLAND_STONE,
	DB_FARMLAND_GOLD,
	DB_FARMLAND_VAMISH,
	DB_FARMLAND_IRON,
	DB_FARMLAND_HORSE,
	DB_FARMLAND_RICE_LIMIT,
	DB_FARMLAND_TIMBER_LIMIT,
	DB_FARMLAND_STONE_LIMIT,
	DB_FARMLAND_GOLD_LIMIT,
	DB_FARMLAND_VAMISH_LIMIT,
	DB_FARMLAND_IRON_LIMIT,
	DB_FARMLAND_HORSE_LIMIT,
	DB_FARMLAND_OWE_DAY,
	DB_FARMLAND_FREEZE,
	DB_FARMLAND_LOCK_STATUS,
	DB_FARMLAND_DOOR_LEVEL,
};

enum DB_FORMULA
{
	DB_FORMULA_ID,
	DB_FORMULA_OWNERID,
	DB_FORMULA_TYPEID,
};

enum DB_FORMULATYPE
{
	DB_FORMULATYPE_ID,
	DB_FORMULATYPE_NAME,
	DB_FORMULATYPE_LEVEL,
	DB_FORMULATYPE_MATERIAL1,
	DB_FORMULATYPE_NUM1,
	DB_FORMULATYPE_MATERIAL2,
	DB_FORMULATYPE_NUM2,
	DB_FORMULATYPE_MATERIAL3,
	DB_FORMULATYPE_NUM3,
	DB_FORMULATYPE_MATERIAL4,
	DB_FORMULATYPE_NUM4,
	DB_FORMULATYPE_MATERIAL5,
	DB_FORMULATYPE_NUM5,
	DB_FORMULATYPE_MATERIAL6,
	DB_FORMULATYPE_NUM6,
	DB_FORMULATYPE_PRODUCT,
	DB_FORMULATYPE_PRODUCT_NUM,
	DB_FORMULATYPE_RATE,
	DB_FORMULATYPE_SUCC_RATE,
	DB_FORMULATYPE_FEE_MONEY,
	DB_FORMULATYPE_FEE_EMONEY,
	DB_FORMULATYPE_ICONINDEX,
	DB_FORMULATYPE_ICONNAME,
};

enum DB_FRIEND
{
	DB_FRIEND_ID,
	DB_FRIEND_USERID,
	DB_FRIEND_FRIENDID,
	DB_FRIEND_FRIENDNAME,
};

enum DB_GAMBLE
{
	DB_GAMBLE_ID,
	DB_GAMBLE_IDNPC,
	DB_GAMBLE_ODDS,
};

enum DB_GAME_LOG
{
	DB_GAME_LOG_ID,
	DB_GAME_LOG_TYPE,
	DB_GAME_LOG_TIME,
	DB_GAME_LOG_TEXT,
};

enum DB_GIFT
{
	DB_GIFT_ID,
	DB_GIFT_SERIES,
	DB_GIFT_BOX_ID,
	DB_GIFT_OWNER_ID,
	DB_GIFT_FLAG,
	DB_GIFT_TEXT,
	DB_GIFT_ITEMAMOUNT,
	DB_GIFT_MONEY,
	DB_GIFT_EMONEY,
	DB_GIFT_JI_FEN,
	DB_GIFT_CAM_START,
	DB_GIFT_CAM_END,
	DB_GIFT_BIND_FLAG,
};

enum DB_GIFTPACK
{
	DB_GIFTPACK_ID,
	DB_GIFTPACK_OWNER_ID,
	DB_GIFTPACK_ITEM_TYPE,
	DB_GIFTPACK_RECEIVE_TIME,
};

enum DB_GMMAIL
{
	DB_GMMAIL_ID,
	DB_GMMAIL_SENDER_ID,
	DB_GMMAIL_SENDER_NAME,
	DB_GMMAIL_RECEIVER_ID,
	DB_GMMAIL_TEXT,
	DB_GMMAIL_ATTACH_STATE,
	DB_GMMAIL_ATTACH_ITEM_ID,
	DB_GMMAIL_ATTACH_ITEM_NUM,
	DB_GMMAIL_ATTACH_MONEY,
	DB_GMMAIL_ATTACH_EMONEY,
	DB_GMMAIL_REQUIRE_MONEY,
	DB_GMMAIL_REQUIRE_EMONEY,
	DB_GMMAIL_SEND_TIME,
	DB_GMMAIL_ANSWER_TIME,
	DB_GMMAIL_ANSWERGM,
	DB_GMMAIL_ATTACH_GMONEY,
};

enum DB_GROUP_BATTLE
{
	DB_GROUP_BATTLE_ID,
	DB_GROUP_BATTLE_WAVE1,
	DB_GROUP_BATTLE_WAVE2,
	DB_GROUP_BATTLE_WAVE3,
	DB_GROUP_BATTLE_WAVE4,
	DB_GROUP_BATTLE_WAVE5,
	DB_GROUP_BATTLE_WAVE6,
};

enum DB_HAMLET
{
	DB_HAMLET_ID,
	DB_HAMLET_NAME,
	DB_HAMLET_OWNER_ID,
	DB_HAMLET_OWNER_TYPE,
	DB_HAMLET_MAP_ID,
	DB_HAMLET_CREATE_TIME,
	DB_HAMLET_FROZEN_TIME,
	DB_HAMLET_DEL_TIME,
};

enum DB_INSTANCING_PROGRESS
{
	DB_INSTANCING_PROGRESS_ID,
	DB_INSTANCING_PROGRESS_OWNER_ID,
	DB_INSTANCING_PROGRESS_INSTANCING_TYPE,
	DB_INSTANCING_PROGRESS_RANK,
	DB_INSTANCING_PROGRESS_CD_TIMESTAMP,
	DB_INSTANCING_PROGRESS_RESET_COUNT,
	DB_INSTANCING_PROGRESS_LAST_RESETTIME,
	DB_INSTANCING_PROGRESS_CLEARUP_MAP,
	DB_INSTANCING_PROGRESS_CLEARUP_RESTCOUNT,
};

enum DB_ITEM
{
	DB_ITEM_ID,
	DB_ITEM_TYPE,
	DB_ITEM_OWNERTYPE,
	DB_ITEM_OWNER_ID,
	DB_ITEM_PLAYER_ID,
	DB_ITEM_POSITION,
	DB_ITEM_AMOUNT,
	DB_ITEM_DATA,
	DB_ITEM_SALE_TIME,
	DB_ITEM_FORGENAME,
	DB_ITEM_ADDITION,
	DB_ITEM_EXP,
	DB_ITEM_CREATE_TIME,
	DB_ITEM_ATTR_TYPE_1,
	DB_ITEM_ATTR_VALUE_1,
	DB_ITEM_ATTR_TYPE_2,
	DB_ITEM_ATTR_VALUE_2,
	DB_ITEM_ATTR_TYPE_3,
	DB_ITEM_ATTR_VALUE_3,
};

enum DB_ITEM_RECORD
{
	DB_ITEM_RECORD_ID,
	DB_ITEM_RECORD_ITEMTYPE,
	DB_ITEM_RECORD_OWNER_ID,
	DB_ITEM_RECORD_TARGET_ID,
	DB_ITEM_RECORD_AMOUNT,
	DB_ITEM_RECORD_TIME,
	DB_ITEM_RECORD_ITEM_ID,
	DB_ITEM_RECORD_TYPE,
};

enum DB_ITEMTYPE
{
	DB_ITEMTYPE_ID,
	DB_ITEMTYPE_NAME,
	DB_ITEMTYPE_REQ_LEVEL,
	DB_ITEMTYPE_PRICE,
	DB_ITEMTYPE_EMONEY,
	DB_ITEMTYPE_SAVE_TIME,
	DB_ITEMTYPE_ID_ACTION,
	DB_ITEMTYPE_AMOUNT_LIMIT,
	DB_ITEMTYPE_MONOPOLY,
	DB_ITEMTYPE_STATE_TYPE,
	DB_ITEMTYPE_LOOKFACE,
	DB_ITEMTYPE_ICONINDEX,
	DB_ITEMTYPE_LIFE,
	DB_ITEMTYPE_ATTR_TYPE_1,
	DB_ITEMTYPE_ATTR_VALUE_1,
	DB_ITEMTYPE_ATTR_GROW_1,
	DB_ITEMTYPE_ATTR_TYPE_2,
	DB_ITEMTYPE_ATTR_VALUE_2,
	DB_ITEMTYPE_ATTR_GROW_2,
	DB_ITEMTYPE_ATTR_TYPE_3,
	DB_ITEMTYPE_ATTR_VALUE_3,
	DB_ITEMTYPE_ATTR_GROW_3,
	DB_ITEMTYPE_DATA,
	DB_ITEMTYPE_DESCRIPT,
	DB_ITEMTYPE_DROP_FLAG,
	DB_ITEMTYPE_RECYCLE_TIME,
	DB_ITEMTYPE_FLAG,
	DB_ITEMTYPE_FORMULA_EMONEY,
	DB_ITEMTYPE_ORIGIN_MAP,
	DB_ITEMTYPE_ENHANCED_ID,
};

enum DB_LEAVEWORD
{
	DB_LEAVEWORD_ID,
	DB_LEAVEWORD_USER_ID,
	DB_LEAVEWORD_SEND_NAME,
	DB_LEAVEWORD_TIME,
	DB_LEAVEWORD_WORDS,
};

enum DB_LEVEXP
{
	DB_LEVEXP_LEVEL,
	DB_LEVEXP_METEMPSYCHOSIS,
	DB_LEVEXP_EXP,
	DB_LEVEXP_PER_BATTLE_MAX,
};

enum DB_LIFESKILL
{
	DB_LIFESKILL_ID,
	DB_LIFESKILL_TYPEID,
	DB_LIFESKILL_OWNERID,
	DB_LIFESKILL_LEVEL,
	DB_LIFESKILL_EXP,
};

enum DB_LUA
{
	DB_LUA_ID,
	DB_LUA_BLOCK,
	DB_LUA_NAME,
};

enum DB_LUA_SCRIPT
{
	DB_LUA_SCRIPT_ID,
	DB_LUA_SCRIPT_NAME,
};

enum DB_LUCK_NUM
{
	DB_LUCK_NUM_CLASS,
	DB_LUCK_NUM_LUCKNUM,
	DB_LUCK_NUM_OWNERID,
	DB_LUCK_NUM_OWNENAME,
	DB_LUCK_NUM_GENTIME,
};

enum DB_LYOL_HZ_CARD_INFO
{
	DB_LYOL_HZ_CARD_INFO_ID,
	DB_LYOL_HZ_CARD_INFO_PAY_USER_AMOUNT,
	DB_LYOL_HZ_CARD_INFO_PAY_USER_NEW,
	DB_LYOL_HZ_CARD_INFO_PAY_AMOUNT,
	DB_LYOL_HZ_CARD_INFO_PAY_CHANNEL,
	DB_LYOL_HZ_CARD_INFO_PAY_DATE,
};

enum DB_LYOL_HZ_ONLINE
{
	DB_LYOL_HZ_ONLINE_ID,
	DB_LYOL_HZ_ONLINE_TOTAL_ONLINE_AMOUNT,
	DB_LYOL_HZ_ONLINE_TOTAL_ONLINE_TIME,
	DB_LYOL_HZ_ONLINE_TOTAL_ONLINE_MAX,
	DB_LYOL_HZ_ONLINE_HZ_HOUR,
	DB_LYOL_HZ_ONLINE_CHANNEL,
};

enum DB_LYOL_HZ_USER_INFO
{
	DB_LYOL_HZ_USER_INFO_ID,
	DB_LYOL_HZ_USER_INFO_TOTAL_USER,
	DB_LYOL_HZ_USER_INFO_TOTAL_ROLE,
	DB_LYOL_HZ_USER_INFO_TOTAL_LOGIN_USER,
	DB_LYOL_HZ_USER_INFO_TOTAL_LOGIN_ROLE,
	DB_LYOL_HZ_USER_INFO_TOTAL_LOGIN_COUNT,
	DB_LYOL_HZ_USER_INFO_TOTAL_NEW_USER,
	DB_LYOL_HZ_USER_INFO_TOTAL_NEW_ROLE,
	DB_LYOL_HZ_USER_INFO_HZ_TYPE,
	DB_LYOL_HZ_USER_INFO_HZ_DATE,
	DB_LYOL_HZ_USER_INFO_CHANNEL,
};

enum DB_LYOL_SHOP_ITEM_WATER
{
	DB_LYOL_SHOP_ITEM_WATER_ID,
	DB_LYOL_SHOP_ITEM_WATER_ITEM_TYPE,
	DB_LYOL_SHOP_ITEM_WATER_ITEM_NAME,
	DB_LYOL_SHOP_ITEM_WATER_ITEM_AMOUNT,
	DB_LYOL_SHOP_ITEM_WATER_SELL_EMONEY,
	DB_LYOL_SHOP_ITEM_WATER_SELL_PRICE,
	DB_LYOL_SHOP_ITEM_WATER_BUY_USERID,
	DB_LYOL_SHOP_ITEM_WATER_BUY_CHANNEL,
	DB_LYOL_SHOP_ITEM_WATER_SELL_DATETIME,
};

enum DB_MAIL
{
	DB_MAIL_ID,
	DB_MAIL_SENDER_ID,
	DB_MAIL_SENDER_NAME,
	DB_MAIL_RECEIVER_ID,
	DB_MAIL_TEXT,
	DB_MAIL_ATTACH_STATE,
	DB_MAIL_ATTACH_ITEM_ID,
	DB_MAIL_ATTACH_ITEM_NUM,
	DB_MAIL_ATTACH_MONEY,
	DB_MAIL_ATTACH_EMONEY,
	DB_MAIL_REQUIRE_MONEY,
	DB_MAIL_REQUIRE_EMONEY,
	DB_MAIL_SEND_TIME,
	DB_MAIL_FAIL_TIME,
	DB_MAIL_ATTACH_GMONEY,
	DB_MAIL_FLAG,
	DB_MAIL_DEL_TIME,
	DB_MAIL_ASS_ID,
};

enum DB_MAP
{
	DB_MAP_ID,
	DB_MAP_NAME,
	DB_MAP_DESCR,
	DB_MAP_MAPDOC,
	DB_MAP_TYPE,
	DB_MAP_OWNERID,
	DB_MAP_OWNERTYPE,
	DB_MAP_PORTAL0_X,
	DB_MAP_PORTAL0_Y,
	DB_MAP_REBORN_MAP_ID,
	DB_MAP_REBORN_X,
	DB_MAP_REBORN_Y,
	DB_MAP_LINK_MAP_ID,
	DB_MAP_LINK_MAP_X,
	DB_MAP_LINK_MAP_Y,
	DB_MAP_RESOURCE_LEV,
	DB_MAP_IDSERVER,
	DB_MAP_MAP_LV,
	DB_MAP_MUSIC,
	DB_MAP_INSTANCING_GROUP,
	DB_MAP_INSTANCING_PRE_CONDITION,
	DB_MAP_INSTANCING_IS_ELITE,
	DB_MAP_INSTANCING_IS_BOSS,
	DB_MAP_INSTANCING_MONSTER_LEVEL,
	DB_MAP_INSTANCING_EXTRA_EXP,
	DB_MAP_INSTANCING_EXTRA_SOPH,
	DB_MAP_INSTANCING_ICON,
	DB_MAP_INSTANCING_ORDER,
	DB_MAP_NEED_STAGE,
	DB_MAP_TITLE,
};

enum DB_MAPZONE
{
	DB_MAPZONE_ID,
	DB_MAPZONE_MAPID,
	DB_MAPZONE_POS_X,
	DB_MAPZONE_POS_Y,
	DB_MAPZONE_MONSTER_TYPE,
	DB_MAPZONE_ELITE_FLAG,
	DB_MAPZONE_GENERATE_RULE_ID,
	DB_MAPZONE_UPDATE_TIME,
	DB_MAPZONE_AI_TYPE,
	DB_MAPZONE_ATK_AREA,
};

enum DB_MARTIAL
{
	DB_MARTIAL_ID,
	DB_MARTIAL_OWNER_ID,
	DB_MARTIAL_TYPE,
	DB_MARTIAL_LEVEL,
};

enum DB_MARTIALTYPE
{
	DB_MARTIALTYPE_ID,
	DB_MARTIALTYPE_NAME,
	DB_MARTIALTYPE_DESCRIPT,
	DB_MARTIALTYPE_LOOKFACE,
	DB_MARTIALTYPE_EFFECT_TYPE,
	DB_MARTIALTYPE_EFFECT_INIT,
	DB_MARTIALTYPE_EFFECT_UP,
	DB_MARTIALTYPE_CD_TIME,
	DB_MARTIALTYPE_INI_SOPH,
	DB_MARTIALTYPE_UP_SOPH,
	DB_MARTIALTYPE_REQ_TASK,
};

enum DB_MATRIX
{
	DB_MATRIX_ID,
	DB_MATRIX_OWNER_ID,
	DB_MATRIX_TYPE,
	DB_MATRIX_LEVEL,
	DB_MATRIX_STATIONS1,
	DB_MATRIX_STATIONS2,
	DB_MATRIX_STATIONS3,
	DB_MATRIX_STATIONS4,
	DB_MATRIX_STATIONS5,
	DB_MATRIX_STATIONS6,
	DB_MATRIX_STATIONS7,
	DB_MATRIX_STATIONS8,
	DB_MATRIX_STATIONS9,
};

enum DB_MATRIX_CONFIG
{
	DB_MATRIX_CONFIG_ID,
	DB_MATRIX_CONFIG_NAME,
	DB_MATRIX_CONFIG_DESCRIPT,
	DB_MATRIX_CONFIG_LOOKFACE,
	DB_MATRIX_CONFIG_EFFECT_TYPE,
	DB_MATRIX_CONFIG_EFFECT,
	DB_MATRIX_CONFIG_REQ_LEVEL1,
	DB_MATRIX_CONFIG_REQ_LEVEL2,
	DB_MATRIX_CONFIG_REQ_LEVEL4,
	DB_MATRIX_CONFIG_REQ_LEVEL5,
	DB_MATRIX_CONFIG_REQ_LEVEL6,
	DB_MATRIX_CONFIG_REQ_LEVEL7,
	DB_MATRIX_CONFIG_REQ_LEVEL3,
	DB_MATRIX_CONFIG_REQ_LEVEL8,
	DB_MATRIX_CONFIG_REQ_LEVEL9,
};

enum DB_MATRIX_UP_LEVEL
{
	DB_MATRIX_UP_LEVEL_LEVEL,
	DB_MATRIX_UP_LEVEL_USER_LEVEL,
	DB_MATRIX_UP_LEVEL_REQ_SOPH,
	DB_MATRIX_UP_LEVEL_CD_TIME,
};

enum DB_MONSTER_BOSS
{
	DB_MONSTER_BOSS_ID,
	DB_MONSTER_BOSS_TYPE,
	DB_MONSTER_BOSS_MAP_ID,
	DB_MONSTER_BOSS_POS_X,
	DB_MONSTER_BOSS_POS_Y,
	DB_MONSTER_BOSS_LEVEL,
	DB_MONSTER_BOSS_LIFE,
	DB_MONSTER_BOSS_MANA,
	DB_MONSTER_BOSS_PHY_ATK,
	DB_MONSTER_BOSS_SKILL_ATK,
	DB_MONSTER_BOSS_MAGIC_ATK,
	DB_MONSTER_BOSS_PHY_DEF,
	DB_MONSTER_BOSS_SKILL_DEF,
	DB_MONSTER_BOSS_MAGIC_DEF,
	DB_MONSTER_BOSS_DRITICAL,
	DB_MONSTER_BOSS_HITRATE,
	DB_MONSTER_BOSS_WRECK,
	DB_MONSTER_BOSS_HURT_ADD,
	DB_MONSTER_BOSS_TENACITY,
	DB_MONSTER_BOSS_DODGE,
	DB_MONSTER_BOSS_BLOCK,
	DB_MONSTER_BOSS_MONEY,
	DB_MONSTER_BOSS_BORN_TIME,
};

enum DB_MONSTER_GENERATE
{
	DB_MONSTER_GENERATE_ID,
	DB_MONSTER_GENERATE_STATIONS1,
	DB_MONSTER_GENERATE_STATIONS2,
	DB_MONSTER_GENERATE_STATIONS3,
	DB_MONSTER_GENERATE_STATIONS4,
	DB_MONSTER_GENERATE_STATIONS5,
	DB_MONSTER_GENERATE_STATIONS6,
	DB_MONSTER_GENERATE_STATIONS7,
	DB_MONSTER_GENERATE_STATIONS8,
	DB_MONSTER_GENERATE_STATIONS9,
};

enum DB_MONSTERTYPE
{
	DB_MONSTERTYPE_ID,
	DB_MONSTERTYPE_NAME,
	DB_MONSTERTYPE_LOOKFACE,
	DB_MONSTERTYPE_TYPE,
	DB_MONSTERTYPE_ATK_TYPE,
	DB_MONSTERTYPE_DISTANCE,
	DB_MONSTERTYPE_LEVEL,
	DB_MONSTERTYPE_LIFE,
	DB_MONSTERTYPE_MANA,
	DB_MONSTERTYPE_PHY_ATK,
	DB_MONSTERTYPE_SKILL_ATK,
	DB_MONSTERTYPE_MAGIC_ATK,
	DB_MONSTERTYPE_PHY_DEF,
	DB_MONSTERTYPE_SKILL_DEF,
	DB_MONSTERTYPE_MAGIC_DEF,
	DB_MONSTERTYPE_DRITICAL,
	DB_MONSTERTYPE_HITRATE,
	DB_MONSTERTYPE_WRECK,
	DB_MONSTERTYPE_HURT_ADD,
	DB_MONSTERTYPE_TENACITY,
	DB_MONSTERTYPE_DODGE,
	DB_MONSTERTYPE_BLOCK,
	DB_MONSTERTYPE_AI_TYPE,
	DB_MONSTERTYPE_AWARD_EXP,
	DB_MONSTERTYPE_SKILL,
	DB_MONSTERTYPE_DROP_RULE0,
	DB_MONSTERTYPE_DROP_RULE1,
	DB_MONSTERTYPE_DROP_RULE2,
	DB_MONSTERTYPE_ATK_AREA,
	DB_MONSTERTYPE_RARE_RATE,
};

enum DB_NPC
{
	DB_NPC_ID,
	DB_NPC_NAME,
	DB_NPC_TYPE,
	DB_NPC_LOOKFACE,
	DB_NPC_BASE,
	DB_NPC_IDXSERVER,
	DB_NPC_MAPID,
	DB_NPC_CELLX,
	DB_NPC_CELLY,
	DB_NPC_ID_ACTION,
	DB_NPC_TASK0,
	DB_NPC_TASK1,
	DB_NPC_TASK2,
	DB_NPC_TASK3,
	DB_NPC_TASK4,
	DB_NPC_TASK5,
	DB_NPC_TASK6,
	DB_NPC_TASK7,
	DB_NPC_TASK8,
	DB_NPC_TASK9,
	DB_NPC_DATA0,
	DB_NPC_DATA1,
	DB_NPC_DATA2,
	DB_NPC_DATA3,
	DB_NPC_DATASTR,
	DB_NPC_SORT,
	DB_NPC_SHOPID,
	DB_NPC_CAMP,
	DB_NPC_DYNAFLAG,
	DB_NPC_ID_MONSTER_TYPE,
	DB_NPC_ID_GENERATE,
	DB_NPC_FOREWORD,
	DB_NPC_BEGIN_TIME,
	DB_NPC_END_TIME,
	DB_NPC_MAP_GROUP,
};

enum DB_PASSWAY
{
	DB_PASSWAY_ID,
	DB_PASSWAY_MAPID,
	DB_PASSWAY_PASSWAY_INDEX,
	DB_PASSWAY_DEST_MAPID,
	DB_PASSWAY_DEST_PORTAL_INDEX,
};

enum DB_PASSWAY_COPY
{
	DB_PASSWAY_COPY_ID,
	DB_PASSWAY_COPY_MAPID,
	DB_PASSWAY_COPY_PASSWAY_INDEX,
	DB_PASSWAY_COPY_DEST_MAPID,
	DB_PASSWAY_COPY_DEST_PORTAL_INDEX,
};

enum DB_PET
{
	DB_PET_ID,
	DB_PET_NAME,
	DB_PET_TYPE,
	DB_PET_MAIN,
	DB_PET_OWNER_ID,
	DB_PET_POSITION,
	DB_PET_LEVEL,
	DB_PET_GRADE,
	DB_PET_EXP,
	DB_PET_LIFE,
	DB_PET_LIFE_LIMIT,
	DB_PET_MANA,
	DB_PET_MANA_LIMIT,
	DB_PET_SKILL,
	DB_PET_PHYSICAL,
	DB_PET_SUPER_SKILL,
	DB_PET_MAGIC,
	DB_PET_PHY_FOSTER,
	DB_PET_SUPER_SKILL_FOSTER,
	DB_PET_MAGIC_FOSTER,
	DB_PET_PHY_ELIXIR1,
	DB_PET_PHY_ELIXIR2,
	DB_PET_PHY_ELIXIR3,
	DB_PET_PHY_ELIXIR4,
	DB_PET_PHY_ELIXIR5,
	DB_PET_PHY_ELIXIR6,
	DB_PET_SUPER_SKILL_ELIXIR1,
	DB_PET_SUPER_SKILL_ELIXIR2,
	DB_PET_SUPER_SKILL_ELIXIR3,
	DB_PET_SUPER_SKILL_ELIXIR4,
	DB_PET_SUPER_SKILL_ELIXIR5,
	DB_PET_SUPER_SKILL_ELIXIR6,
	DB_PET_MAGIC_ELIXIR1,
	DB_PET_MAGIC_ELIXIR2,
	DB_PET_MAGIC_ELIXIR3,
	DB_PET_MAGIC_ELIXIR4,
	DB_PET_MAGIC_ELIXIR5,
	DB_PET_MAGIC_ELIXIR6,
	DB_PET_IMPART,
	DB_PET_OBTAIN,
};

enum DB_PET_CONFIG
{
	DB_PET_CONFIG_ID,
	DB_PET_CONFIG_NAME,
	DB_PET_CONFIG_PROFESSION,
	DB_PET_CONFIG_PRO_NAME,
	DB_PET_CONFIG_ATK_TYPE,
	DB_PET_CONFIG_LOCKFACE,
	DB_PET_CONFIG_ICON,
	DB_PET_CONFIG_SKILL,
	DB_PET_CONFIG_LIFE_GROW,
	DB_PET_CONFIG_INIT_LIFE,
	DB_PET_CONFIG_INIT_MANA,
	DB_PET_CONFIG_INIT_PHYSICAL,
	DB_PET_CONFIG_INIT_SUPER_SKILL,
	DB_PET_CONFIG_INIT_MAGIC,
	DB_PET_CONFIG_INIT_DRITICAL,
	DB_PET_CONFIG_INIT_HITRATE,
	DB_PET_CONFIG_INIT_WRECK,
	DB_PET_CONFIG_INIT_HURT_ADD,
	DB_PET_CONFIG_INIT_TENACITY,
	DB_PET_CONFIG_INIT_DODGE,
	DB_PET_CONFIG_INIT_BLOCK,
	DB_PET_CONFIG_CAN_CALL,
	DB_PET_CONFIG_REPUTE,
	DB_PET_CONFIG_REPUTE_LEV,
	DB_PET_CONFIG_RECOMMEND,
	DB_PET_CONFIG_MONEY,
	DB_PET_CONFIG_DESCRIBE,
	DB_PET_CONFIG_NEED_STAGE,
};

enum DB_PET_LEVEXP
{
	DB_PET_LEVEXP_LEVEL,
	DB_PET_LEVEXP_EXP,
};

enum DB_PORTAL
{
	DB_PORTAL_ID,
	DB_PORTAL_MAPID,
	DB_PORTAL_PORTAL_INDEX,
	DB_PORTAL_PORTALX,
	DB_PORTAL_PORTALY,
	DB_PORTAL_LOOKFACE,
};

enum DB_REPUTE
{
	DB_REPUTE_USER_ID,
	DB_REPUTE_REPUTE_COUNTRY,
	DB_REPUTE_REPUTE_CAMP,
	DB_REPUTE_HONOUR,
	DB_REPUTE_SOLDIER_PAY_FLAG,
	DB_REPUTE_EXPEND_HONOUR,
	DB_REPUTE_SIGNIN_TIMESTAMP,
	DB_REPUTE_SIGNIN_CHAINCOUNT,
};

enum DB_SERVER_CFG
{
	DB_SERVER_CFG_SERVER_ID,
	DB_SERVER_CFG_SERVER_NAME,
	DB_SERVER_CFG_SERVER_IP,
	DB_SERVER_CFG_SERVER_PORT,
};

enum DB_SHOP
{
	DB_SHOP_ID,
	DB_SHOP_NAME,
	DB_SHOP_ITEMTYPE,
	DB_SHOP_PAY_TYPE,
	DB_SHOP_SALE_AMOUNT,
	DB_SHOP_REQ_REPUTE,
	DB_SHOP_REQ_RANK,
	DB_SHOP_REQ_COUNTRY_REPUTE,
	DB_SHOP_DISCOUNT_FLAG,
	DB_SHOP_GIFTTYPE,
	DB_SHOP_BEGIN_TIME,
	DB_SHOP_END_TIME,
	DB_SHOP_TYPE,
	DB_SHOP_MEDAL_ID,
	DB_SHOP_MEDAL_NUM,
	DB_SHOP_HONOUR,
	DB_SHOP_BIND_FLAG,
};

enum DB_SKILL_CONFIG
{
	DB_SKILL_CONFIG_ID,
	DB_SKILL_CONFIG_NAME,
	DB_SKILL_CONFIG_ACT_ID,
	DB_SKILL_CONFIG_LOOKFACE_ID,
	DB_SKILL_CONFIG_LOOKFACE_TARGET_ID,
	DB_SKILL_CONFIG_ATK_TYPE,
	DB_SKILL_CONFIG_TARGET_TYPE,
	DB_SKILL_CONFIG_BLOCK_TYPE,
	DB_SKILL_CONFIG_MAIN_RATE,
	DB_SKILL_CONFIG_EFFECT1,
	DB_SKILL_CONFIG_EFFECT2,
	DB_SKILL_CONFIG_EFFECT3,
	DB_SKILL_CONFIG_DESCRRIPTION,
};

enum DB_SKILL_RESULT_CFG
{
	DB_SKILL_RESULT_CFG_ID,
	DB_SKILL_RESULT_CFG_LOOKFACE,
	DB_SKILL_RESULT_CFG_BACK,
	DB_SKILL_RESULT_CFG_SELF,
	DB_SKILL_RESULT_CFG_EFFECT_TYPE,
	DB_SKILL_RESULT_CFG_RELY_SELF,
	DB_SKILL_RESULT_CFG_RELY_TYPE,
	DB_SKILL_RESULT_CFG_VALUE,
	DB_SKILL_RESULT_CFG_RATE,
	DB_SKILL_RESULT_CFG_BOUT,
};

enum DB_SPORTS_PRIZE
{
	DB_SPORTS_PRIZE_RANKING,
	DB_SPORTS_PRIZE_MONEY,
	DB_SPORTS_PRIZE_REPUTE,
};

enum DB_SPORTS_REPORT
{
	DB_SPORTS_REPORT_ID,
	DB_SPORTS_REPORT_USER_ID,
	DB_SPORTS_REPORT_RANKING,
	DB_SPORTS_REPORT_BATTLE,
	DB_SPORTS_REPORT_TARGET,
	DB_SPORTS_REPORT_NAME,
	DB_SPORTS_REPORT_TIME,
	DB_SPORTS_REPORT_WIN,
	DB_SPORTS_REPORT_IS_ATK,
};

enum DB_STONE
{
	DB_STONE_ID,
	DB_STONE_ITEMID,
	DB_STONE_TYPE,
	DB_STONE_OWNERID,
};

enum DB_STORAGE
{
	DB_STORAGE_ID,
	DB_STORAGE_ID_USER,
	DB_STORAGE_ID_MAP,
	DB_STORAGE_TYPE,
	DB_STORAGE_ITEM0,
	DB_STORAGE_ITEM1,
	DB_STORAGE_ITEM2,
	DB_STORAGE_ITEM3,
	DB_STORAGE_ITEM4,
	DB_STORAGE_ITEM5,
	DB_STORAGE_ITEM6,
	DB_STORAGE_ITEM7,
};

enum DB_SYNDICATE
{
	DB_SYNDICATE_ID,
	DB_SYNDICATE_NAME,
	DB_SYNDICATE_CREATER_ID,
	DB_SYNDICATE_CREATER_NAME,
	DB_SYNDICATE_CREATE_TIME,
	DB_SYNDICATE_CAMP,
	DB_SYNDICATE_FLAG,
	DB_SYNDICATE_MONEY,
	DB_SYNDICATE_EMONEY,
	DB_SYNDICATE_CONTRIBUTION,
	DB_SYNDICATE_COUNTRY_REPUTE,
	DB_SYNDICATE_MBR_NUM_LIMIT,
	DB_SYNDICATE_APPLY_NUM_LIMIT,
	DB_SYNDICATE_RANK,
	DB_SYNDICATE_WOOD,
	DB_SYNDICATE_STONE,
	DB_SYNDICATE_PAINT,
	DB_SYNDICATE_COAL,
	DB_SYNDICATE_ANNOUNCE,
};

enum DB_SYNDICATE_LEVEL
{
	DB_SYNDICATE_LEVEL_LEVEL,
	DB_SYNDICATE_LEVEL_MBR_LIMIT,
	DB_SYNDICATE_LEVEL_APPLY_LIMIT,
	DB_SYNDICATE_LEVEL_CONSUME_MONEY,
	DB_SYNDICATE_LEVEL_CONSUME_WOOD,
	DB_SYNDICATE_LEVEL_CONSUME_STONE,
	DB_SYNDICATE_LEVEL_CONSUME_PAINT,
	DB_SYNDICATE_LEVEL_CONSUME_COAL,
	DB_SYNDICATE_LEVEL_REQUIRE_CONTRIBUTE,
	DB_SYNDICATE_LEVEL_REQUIRE_MBR,
};

enum DB_SYNDICATE_VOTE
{
	DB_SYNDICATE_VOTE_ID,
	DB_SYNDICATE_VOTE_SYN_ID,
	DB_SYNDICATE_VOTE_TYPE,
	DB_SYNDICATE_VOTE_DATA,
	DB_SYNDICATE_VOTE_SPONSOR_ID,
	DB_SYNDICATE_VOTE_START_TIME,
	DB_SYNDICATE_VOTE_END_TIME,
};

enum DB_SYNMBR
{
	DB_SYNMBR_ID,
	DB_SYNMBR_SYN_ID,
	DB_SYNMBR_PLAYER_ID,
	DB_SYNMBR_PLAYER_NAME,
	DB_SYNMBR_RANK,
	DB_SYNMBR_DONATE_MONEY,
	DB_SYNMBR_CONTRIBUTE,
};

enum DB_SYNMBR_REQUEST
{
	DB_SYNMBR_REQUEST_ID,
	DB_SYNMBR_REQUEST_PLAYER_ID,
	DB_SYNMBR_REQUEST_PLAYER_NAME,
	DB_SYNMBR_REQUEST_SYN_ID,
	DB_SYNMBR_REQUEST_FLAG,
	DB_SYNMBR_REQUEST_OVER_TIME,
};

enum DB_SYNMBR_VOTE
{
	DB_SYNMBR_VOTE_ID,
	DB_SYNMBR_VOTE_VOTE_ID,
	DB_SYNMBR_VOTE_VOTER_ID,
	DB_SYNMBR_VOTE_RESULT,
};

enum DB_TASK
{
	DB_TASK_ID,
	DB_TASK_ID_NEXT,
	DB_TASK_ID_NEXTFAIL,
	DB_TASK_ITEMNAME1,
	DB_TASK_ITEMNAME2,
	DB_TASK_MONEY,
	DB_TASK_PROFESSION,
	DB_TASK_SEX,
	DB_TASK_MIN_PK,
	DB_TASK_MAX_PK,
	DB_TASK_TEAM,
	DB_TASK_METEMPSYCHOSIS,
	DB_TASK_QUERY,
	DB_TASK_MARRIAGE,
	DB_TASK_CLIENT_ACTIVE,
};

enum DB_TASK_AGENT
{
	DB_TASK_AGENT_ID,
	DB_TASK_AGENT_OWNER_ID,
	DB_TASK_AGENT_TASK_TYPE,
	DB_TASK_AGENT_TAGS,
	DB_TASK_AGENT_SET_TIME,
};

enum DB_TASK_DETAIL
{
	DB_TASK_DETAIL_ID,
	DB_TASK_DETAIL_USER_ID,
	DB_TASK_DETAIL_TASK_ID,
	DB_TASK_DETAIL_TASK_STATE,
	DB_TASK_DETAIL_DATA1,
	DB_TASK_DETAIL_DATA2,
	DB_TASK_DETAIL_DATA3,
	DB_TASK_DETAIL_DATA4,
	DB_TASK_DETAIL_DATA5,
	DB_TASK_DETAIL_DATA6,
};

enum DB_TASK_DONE
{
	DB_TASK_DONE_ID,
	DB_TASK_DONE_USER_ID,
	DB_TASK_DONE_TASK_ID,
	DB_TASK_DONE_COMPLETE_TIME_DAY,
	DB_TASK_DONE_COMPLETE_TIME_ALL,
};

enum DB_TASK_DROP
{
	DB_TASK_DROP_ID,
	DB_TASK_DROP_MONSTER_ID,
	DB_TASK_DROP_TASK_ID,
	DB_TASK_DROP_ITEMTYPE,
	DB_TASK_DROP_RANK,
	DB_TASK_DROP_NUM,
};

enum DB_TASK_TYPE
{
	DB_TASK_TYPE_ID,
	DB_TASK_TYPE_NAME,
	DB_TASK_TYPE_TYPE,
	DB_TASK_TYPE_PRE_TASK_ID,
	DB_TASK_TYPE_PRE_TASK_ID_2,
	DB_TASK_TYPE_LV_MIN,
	DB_TASK_TYPE_LV_MAX,
	DB_TASK_TYPE_NPC,
	DB_TASK_TYPE_FINISH_NPC,
	DB_TASK_TYPE_PRE_AWARD_ITEM,
	DB_TASK_TYPE_COMPLETE_TIME_LIMIT_DAY,
	DB_TASK_TYPE_COMPLETE_TIME_LIMIT_ALL,
	DB_TASK_TYPE_DEL_ITEMTYPE1,
	DB_TASK_TYPE_DEL_ITEMTYPE1_NUM,
	DB_TASK_TYPE_DEL_ITEMTYPE2,
	DB_TASK_TYPE_DEL_ITEMTYPE2_NUM,
	DB_TASK_TYPE_DEL_ITEMTYPE3,
	DB_TASK_TYPE_DEL_ITEMTYPE3_NUM,
	DB_TASK_TYPE_AWARD_EXP,
	DB_TASK_TYPE_AWARD_MONEY,
	DB_TASK_TYPE_AWARD_ITEM_FLAG,
	DB_TASK_TYPE_AWARD_ITEMTYPE1,
	DB_TASK_TYPE_AWARD_ITEMTYPE1_NUM,
	DB_TASK_TYPE_AWARD_ITEMTYPE2,
	DB_TASK_TYPE_AWARD_ITEMTYPE2_NUM,
	DB_TASK_TYPE_AWARD_ITEMTYPE3,
	DB_TASK_TYPE_AWARD_ITEMTYPE3_NUM,
	DB_TASK_TYPE_CONTENT,
	DB_TASK_TYPE_AWARD_REPUTE,
	DB_TASK_TYPE_AWARD_HONOUR,
	DB_TASK_TYPE_MONSTER1,
	DB_TASK_TYPE_MON_NUM1,
	DB_TASK_TYPE_MONSTER2,
	DB_TASK_TYPE_MON_NUM2,
	DB_TASK_TYPE_MONSTER3,
	DB_TASK_TYPE_MON_NUM3,
	DB_TASK_TYPE_MONSTER4,
	DB_TASK_TYPE_MON_NUM4,
	DB_TASK_TYPE_PRE_AWARD_ITEM_NUM,
	DB_TASK_TYPE_RECYCLE_FLAG,
	DB_TASK_TYPE_BIND_FLAG,
	DB_TASK_TYPE_NEED_REPUTE,
	DB_TASK_TYPE_NEED_SOLDIERRANK,
	DB_TASK_TYPE_NEED_PEERAGE,
	DB_TASK_TYPE_AWARD_PEERAGE,
	DB_TASK_TYPE_AWARD_SOLDIERRANK,
	DB_TASK_TYPE_DEL_MONEY,
	DB_TASK_TYPE_ACTIVE_BEGIN,
	DB_TASK_TYPE_ACTIVE_END,
};

enum DB_TIME_QUEUE
{
	DB_TIME_QUEUE_ID,
	DB_TIME_QUEUE_OWNER_ID,
	DB_TIME_QUEUE_TYPE,
	DB_TIME_QUEUE_NUMBER,
	DB_TIME_QUEUE_LAST_TIME,
};

enum DB_UNLAWFUL_NAME
{
	DB_UNLAWFUL_NAME_ID,
	DB_UNLAWFUL_NAME_NAME,
};

enum DB_UNLAWFUL_TALK
{
	DB_UNLAWFUL_TALK_ID,
	DB_UNLAWFUL_TALK_TALK,
};

enum DB_URL
{
	DB_URL_ID,
	DB_URL_CHANNEL,
	DB_URL_URL,
	DB_URL_MODEL,
};

enum DB_USER
{
	DB_USER_ID,
	DB_USER_ACCOUNT_ID,
	DB_USER_NAME,
	DB_USER_TITLE,
	DB_USER_CREATETIME,
	DB_USER_LOOKFACE,
	DB_USER_PROFESSION,
	DB_USER_HAIR,
	DB_USER_MONEY,
	DB_USER_MONEY_SAVED,
	DB_USER_MONEY_SAVED2,
	DB_USER_EMONEY,
	DB_USER_EMONEY_SAVE,
	DB_USER_EMONEY_CHK,
	DB_USER_STORAGE_LIMIT,
	DB_USER_PACKAGE_LIMIT,
	DB_USER_LOCK_KEY,
	DB_USER_RECORDMAP_ID,
	DB_USER_RECORDX,
	DB_USER_RECORDY,
	DB_USER_LAST_LOGIN,
	DB_USER_ONLINE_TIME2,
	DB_USER_OFFINE_TIME,
	DB_USER_LAST_LOGOUT2,
	DB_USER_LOGIN_TIME,
	DB_USER_IP,
	DB_USER_REBORN_MAPID,
	DB_USER_ONLINE_TIME,
	DB_USER_AUTO_EXERCISE,
	DB_USER_LEVEL,
	DB_USER_EXP,
	DB_USER_PK,
	DB_USER_LIFE,
	DB_USER_MANA,
	DB_USER_PHY_POINT,
	DB_USER_DEX_POINT,
	DB_USER_MAG_POINT,
	DB_USER_DEF_POINT,
	DB_USER_FORBITDDEN_WORDS,
	DB_USER_RANK,
	DB_USER_CAMP,
	DB_USER_MARRYID,
	DB_USER_REIKI,
	DB_USER_CHKSUM,
	DB_USER_CHANNEL,
	DB_USER_GMONEY,
	DB_USER_GMONEY_SAVE,
	DB_USER_ACCOUNT_NAME,
	DB_USER_MOBILE,
	DB_USER_ACTIVITY_POINT,
	DB_USER_MAX_ACTIVITY,
	DB_USER_MAX_SKILL_SLOT,
	DB_USER_VIP_RANK,
	DB_USER_VIP_EXP,
	DB_USER_PEERAGE,
	DB_USER_MATRIX,
	DB_USER_REPUTE,
	DB_USER_SOPH,
	DB_USER_PARTS_BAG,
	DB_USER_DAO_FA_BAG,
	DB_USER_SPORTS,
	DB_USER_SPORTS_COUNT,
	DB_USER_UP_SPORTS,
	DB_USER_WINNING_STREAK,
	DB_USER_ADD_SPORTS_COUNT,
	DB_USER_SP_LEVUP_CD,
	DB_USER_LAST_GRASP_DAO_TIME,
	DB_USER_SPACIAL_GRASP_COUNT,
	DB_USER_EQUIP_QUEUE_COUNT,
	DB_USER_EQUIP_UPGRADE_TIME1,
	DB_USER_EQUIP_UPGRADE_TIME2,
	DB_USER_EQUIP_UPGRADE_TIME3,
	DB_USER_PET_LIMIT,
	DB_USER_STAGE,
	DB_USER_STAMINA,
};

enum DB_USER_ATTRIBUTE_TYPE
{
	DB_USER_ATTRIBUTE_TYPE_ID,
	DB_USER_ATTRIBUTE_TYPE_PROFESSION,
	DB_USER_ATTRIBUTE_TYPE_LEVEL,
	DB_USER_ATTRIBUTE_TYPE_STR,
	DB_USER_ATTRIBUTE_TYPE_AGI,
	DB_USER_ATTRIBUTE_TYPE_STA,
	DB_USER_ATTRIBUTE_TYPE_INT,
	DB_USER_ATTRIBUTE_TYPE_PHY_HITERATE,
	DB_USER_ATTRIBUTE_TYPE_MAGIC_HITERATE,
	DB_USER_ATTRIBUTE_TYPE_LIFE,
	DB_USER_ATTRIBUTE_TYPE_MANA,
	DB_USER_ATTRIBUTE_TYPE_UPLEV_POINT,
	DB_USER_ATTRIBUTE_TYPE_UPLEV_SKILL_POINT,
};

enum DB_USER_STATE
{
	DB_USER_STATE_ID,
	DB_USER_STATE_USER_ID,
	DB_USER_STATE_STATE_TYPE,
	DB_USER_STATE_END_TIME,
	DB_USER_STATE_DATA,
};

enum DB_USER_STATE_TYPE
{
	DB_USER_STATE_TYPE_ID,
	DB_USER_STATE_TYPE_STATE_RULE,
	DB_USER_STATE_TYPE_DATA,
	DB_USER_STATE_TYPE_LAST_TIME,
	DB_USER_STATE_TYPE_NOT_SEND,
	DB_USER_STATE_TYPE_NAME,
	DB_USER_STATE_TYPE_ICONINDEX,
	DB_USER_STATE_TYPE_ICONNAME,
	DB_USER_STATE_TYPE_SHORT_TIP,
	DB_USER_STATE_TYPE_DESCRIPT,
};

enum DB_WISH
{
	DB_WISH_ID,
	DB_WISH_USER_ID,
	DB_WISH_USER_NAME,
	DB_WISH_TIME,
	DB_WISH_CONTENT,
	DB_WISH_EMONEY,
};

#endif