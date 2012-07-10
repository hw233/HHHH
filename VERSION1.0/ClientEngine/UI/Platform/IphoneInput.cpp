/*
 *  IphoneInput.cpp
 *  SMYS
 *
 *  Created by jhzheng on 12-3-26.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#include "IphoneInput.h"
#include "NDDirector.h"
#include "define.h"

using namespace NDEngine;

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)

@interface NSIphoneInput : NSObject <UITextFieldDelegate>
{
	UITextField* tfContent;
	CIphoneInput* _iphoneInput;
	BOOL _bAutoAjust;
	CGFloat _fKeyBoardHeight;
	CGFloat _fMove;
}

@property(nonatomic, retain) UITextField* tfContent;

- (void)SetIphoneInput:(CIphoneInput*) input;
- (void)AutoAdjust:(BOOL) bAuto;
-(void)KeyBoardWillShow:(NSNotification*)notification;
-(void)ChangeView:(float) fMove;

@end

@implementation NSIphoneInput

@synthesize tfContent;

-(id) init
{
	if( (self=[super init]) ) {
		tfContent			= nil;
		_iphoneInput		= NULL;
		_bAutoAjust			= false;
		_fKeyBoardHeight	= 216.0f;
		_fMove				= 0.0f;
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(KeyBoardWillShow:)
													 name:UIKeyboardWillShowNotification
												   object:nil];
	}
	
	return self;
}

-(void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self 
													name:UIKeyboardWillShowNotification 
												  object:nil];
	[self ChangeView: 0.0f];
	[tfContent resignFirstResponder];
	[tfContent removeFromSuperview];
	[tfContent release];
	[super dealloc];
}

-(void)KeyBoardWillShow:(NSNotification*)notification
{
	NSDictionary* info	= [notification userInfo];
	CGSize kbSize		= [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
	_fKeyBoardHeight	= kbSize.width;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if (_bAutoAjust && tfContent)
	{
		CGRect bounds	= tfContent.frame;
		if (bounds.origin.x < _fKeyBoardHeight)
		{
			[self ChangeView: bounds.origin.x - _fKeyBoardHeight];
		}
	}

	if (_iphoneInput)
	{
		_iphoneInput->SetInputState(true);
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if (_bAutoAjust && tfContent)
	{
		[self ChangeView: 0.0f];
	}
    
    if (_iphoneInput)
	{
		CInputBase* input = _iphoneInput->GetInputDelegate();
		if (input)
		{
            input->OnInputFinish(input);
		}
	}
	
	if (_iphoneInput)
	{
		_iphoneInput->SetInputState(false);
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (_iphoneInput)
	{
		CInputBase* input = _iphoneInput->GetInputDelegate();
		if (input && !input->OnInputReturn(input))
		{
			return NO;
		}
	}
	[tfContent resignFirstResponder];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	/*
	 NSUInteger len = [string length] + [[textField text] length] - range.length;
	 if (len > MAX_CHAT_INPUT) {
	 return NO;
	 }
	 */
	if (_iphoneInput)
	{
		CInputBase* input = _iphoneInput->GetInputDelegate();
		if (input && !input->OnInputTextChange(input, [string UTF8String]))
		{
			return NO;
		}
        
        unsigned int nLengthLimit = _iphoneInput->GetLengthLimit();
        if(range.location > nLengthLimit){
            //return NO;
        }
	}
	
	return YES;
}

- (void)SetIphoneInput:(CIphoneInput*) input
{
	_iphoneInput	= input;
}

- (void)AutoAdjust:(BOOL) bAuto
{
	_bAutoAjust		= bAuto;
}

-(void)ChangeView:(float) fMove
{
	float fMoveDis	= -(_fMove) + fMove; 
	_fMove			= fMove;
	
	CGAffineTransform t = [[CCDirector sharedDirector] openGLView].transform;
	[[CCDirector sharedDirector] openGLView].transform = CGAffineTransformTranslate(t, -fMoveDis, 0);
}

@end

CIphoneInput::CIphoneInput()
{
	m_inputCommon	= NULL;
	m_inputIphone	= NULL;
	m_bAutoAdjust	= false;
	m_bInputState	= false;
}

CIphoneInput::~CIphoneInput()
{
	if (m_inputIphone.tfContent && m_inputIphone.tfContent.superview)
	{
		[m_inputIphone.tfContent removeFromSuperview];
	}
	[m_inputIphone release];
}

void CIphoneInput::Init()
{
	m_inputIphone	= [[NSIphoneInput alloc] init];
	UITextField* tf = [[UITextField alloc] init];
	tf.borderStyle = UITextBorderStyleRoundedRect;
	//tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.transform = CGAffineTransformMakeRotation(3.141592f/2.0f);
	tf.textColor = [UIColor blueColor];
	tf.returnKeyType = UIReturnKeyDone;
	tf.delegate = m_inputIphone;
	[m_inputIphone SetIphoneInput:this];
	m_inputIphone.tfContent	=  tf;
	[[[CCDirector sharedDirector] openGLView] addSubview:m_inputIphone.tfContent];
	[tf release];
}

void CIphoneInput::Show()
{
	if (m_inputIphone.tfContent && nil == m_inputIphone.tfContent.superview)
	{
		[[[CCDirector sharedDirector] openGLView] addSubview:m_inputIphone.tfContent];
	}
}

void CIphoneInput::Hide()
{
	if (m_inputIphone.tfContent && nil != m_inputIphone.tfContent.superview)
	{
		[m_inputIphone.tfContent removeFromSuperview];
	}
}

void CIphoneInput::SetFrame(float fX, float fY, float fW, float fH)
{
	float fScale = NDDirector::DefaultDirector()->GetScaleFactor();
	
	if (!CompareEqualFloat(fScale, 0.0f))
	{
		fX	/= fScale;
		fY	/= fScale;
		fW	/= fScale;
		fH	/= fScale;
	}
	
	CGSize winsize = [[CCDirector sharedDirector] winSize];
	
	if (m_inputIphone && m_inputIphone.tfContent)
	{
		m_inputIphone.tfContent.frame	= CGRectMake(winsize.height - fY - fH, fX, fH, fW);
		//m_inputIphone.tfContent.frame	= CGRectMake(290.0f, 54.0f, 25.0f, 326.0f);
	}
}

void CIphoneInput::SetInputDelegate(CInputBase* input)
{
	m_inputCommon	= input;
}

CInputBase* CIphoneInput::GetInputDelegate()
{
	return m_inputCommon;
}

void CIphoneInput::SetText(const char* text)
{
	if (m_inputIphone && m_inputIphone.tfContent)
	{
		NSString *content = [NSString stringWithUTF8String:(text == NULL ? "" : text)];
		m_inputIphone.tfContent.text = content;
	}
}

const char* CIphoneInput::GetText()
{
	if (m_inputIphone && m_inputIphone.tfContent && m_inputIphone.tfContent.text)
	{
		return [m_inputIphone.tfContent.text UTF8String];
	}
	
	return "";
}

void CIphoneInput::EnableSafe(bool bEnable)
{
	if (m_inputIphone && m_inputIphone.tfContent)
	{
		m_inputIphone.tfContent.secureTextEntry = bEnable;
	}
}

void CIphoneInput::EnableAutoAdjust(bool bEnable)
{
	if (m_inputIphone && m_inputIphone)
	{
		[m_inputIphone AutoAdjust:bEnable];
	}
	
	m_bAutoAdjust	= bEnable;
}

bool CIphoneInput::IsInputState()
{
	return m_bInputState;
}

void CIphoneInput::SetInputState(bool bSet)
{
	m_bInputState	= bSet;
}
//////////////////////////////////////////////////////
void CIphoneInput::SetLengthLimit(unsigned int nLengthLimit)
{
    m_usLengthLimit = nLengthLimit;
}
//////////////////////////////////////////////////////
unsigned int CIphoneInput::GetLengthLimit(void)
{
    return m_usLengthLimit;
}

#endif