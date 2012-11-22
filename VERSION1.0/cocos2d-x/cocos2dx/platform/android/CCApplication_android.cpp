#include "CCApplication.h"
#include "jni/JniHelper.h"
#include "CCDirector.h"
#include "CCEGLView.h"
#include "android/jni/SystemInfoJni.h"
#include <android/log.h>
#include <jni.h>

#include <cstring>

#define  LOG_TAG    "CCApplication_android Debug"
#define  LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)
#define  LOGDAHUA(...) __android_log_print(ANDROID_LOG_ERROR,"DaHua",__VA_ARGS__)

NS_CC_BEGIN;

// sharedApplication pointer
CCApplication * CCApplication::sm_pSharedApplication = 0;

CCApplication::CCApplication()
{
	LOGD("entry CCApplication::CCApplication()");
	
    CC_ASSERT(! sm_pSharedApplication);
    sm_pSharedApplication = this;

	LOGDAHUA("sm_pSharedApplication value = %d",(int)sm_pSharedApplication);
}

CCApplication::~CCApplication()
{
    CC_ASSERT(this == sm_pSharedApplication);
	LOGDAHUA("Why entry here????????? ����");
    sm_pSharedApplication = NULL;
}

int CCApplication::run()
{
    // Initialize instance and cocos2d.
	LOGD("Initialize instance and cocos2d.");
    if (! initInstance() || ! applicationDidFinishLaunching())
    {
		return 0;
    }
	
	return -1;
}

void CCApplication::setAnimationInterval(double interval)
{
	JniMethodInfo methodInfo = {0};

	if (! JniHelper::getStaticMethodInfo(methodInfo, "org/cocos2dx/lib/Cocos2dxRenderer", "setAnimationInterval", 
		"(D)V"))
	{
		CCLOG("%s %d: error to get methodInfo", __FILE__, __LINE__);
	}
	else
	{
		methodInfo.env->CallStaticVoidMethod(methodInfo.classID, methodInfo.methodID, interval);
	}
}

CCApplication::Orientation CCApplication::setOrientation(Orientation orientation)
{
    return orientation;
}

void CCApplication::statusBarFrame(CCRect * rect)
{
    if (rect)
    {
        // android doesn't have status bar.
		*rect = CCRectMake(0, 0, 0, 0);
    }
}

//////////////////////////////////////////////////////////////////////////
// static member function
//////////////////////////////////////////////////////////////////////////
CCApplication& CCApplication::sharedApplication()
{
	LOGDAHUA("entry CCApplication::sharedApplication(),the sm_pSharedApplication value is %d.",(int)sm_pSharedApplication);
    //CC_ASSERT(sm_pSharedApplication);
    return *sm_pSharedApplication;
}

ccLanguageType CCApplication::getCurrentLanguage()
{
    const char *pLanguageName = getCurrentLanguageJNI();
    ccLanguageType ret = kLanguageEnglish;

    if (0 == strcmp("zh", pLanguageName))
    {
        ret = kLanguageChinese;
    }
    else if (0 == strcmp("en", pLanguageName))
    {
        ret = kLanguageEnglish;
    }
    else if (0 == strcmp("fr", pLanguageName))
    {
        ret = kLanguageFrench;
    }
    else if (0 == strcmp("it", pLanguageName))
    {
        ret = kLanguageItalian;
    }
    else if (0 == strcmp("de", pLanguageName))
    {
        ret = kLanguageGerman;
    }
    else if (0 == strcmp("es", pLanguageName))
    {
        ret = kLanguageSpanish;
    }
	else if (0 == strcmp("ru", pLanguageName))
    {
        ret = kLanguageRussian;
    }
    
    return ret;
}

bool CCApplication::setApplication( CCApplication* pkApp )
{
	if (0 == pkApp)
	{
		LOGDAHUA("���ݽ����Ĳ���pkAppΪ��ֵ");
		return false;
	}
	
	LOGDAHUA("�Ѿ���sm_pSharedApplication��ֵ��value = %d",(int)sm_pSharedApplication);
	sm_pSharedApplication = pkApp;

	return true;
}

bool CCApplication::SetApp( CCApplication* pkApp )
{
	if (0 == pkApp)
	{
		LOGDAHUA("���ݽ����Ĳ���pkAppΪ��ֵ");
		return false;
	}

	LOGDAHUA("�Ѿ���sm_pSharedApplication��ֵ��value = %d",(int)sm_pSharedApplication);
	sm_pSharedApplication = pkApp;

	return true;
}

NS_CC_END;