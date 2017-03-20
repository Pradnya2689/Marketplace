//
//  PMStyle.h
//  PaynimoApp
//
//  Created by Mobapp2 on 16/12/14.
//  Copyright (c) 2014 Mobapp2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// Project Text
#define alertNetwork @"Network Connection Issue."
#define alertException @"Something wrong. Try other option."
#define alertMerchantException @"Something wrong. Try some time later."
#define OTPLabelText @"Enter OTP"
#define alertOTPCancel @"Are you sure you want to cancel payment?"
#define alertWebCancel @"Are you sure you want to cancel payment?"

//Tabel Section
#define selectPayment @"Select your preferred card for this payment"
#define MobileText @"Mobile Number"
#define MMIDText @"MMID"
#define OTPText @"OTP"
#define CVCText @"CVC"
#define CardNumberText @"Card Number"
#define AccountHolderText @"Account Holder"
#define ExpirationDate @"Expiration Date"
#define RememberCard @"Remember this card for the next time"
#define RememberIMPS @"Remember this IMPS for the next time"
#define RememberNote @"Your information is secured using industry standard encryption"
#define standingInstruction @"Register For Auto-Debit"
#define viewDetail @"View SI Details"
#define addDetail @"Detail"

//font
#define fontRegular @"Roboto-Regular"
#define fontBold @"Roboto-Bold"

//color
#define BackgroundColor @"ffffff"
#define NavbarColor @"ffffff"
#define InputFieldTextColor @"000000"
#define InputFieldBackgroundColor @"DFDFDF"
#define InputFieldTitleColor @"EF5000"
#define InputFieldBorderColor @"d71921"
#define InputFieldConfirmColor @"000000"
#define InputFieldWrongColor @"ff0000"
#define ButtonBackgroundColor @"d71921"
#define ButtonTitleColor @"ffffff"
#define SegmentColor @"ffffff"
#define TabBarBackgroundColor @"cecece"
#define TabBarTextColor @"ffffff"
#define TabBarBorderColor @"d71921"
#define TabBarSelectedColor @"d71921"
#define TabBarSelectedTextColor @"ffffff"

//#define cardVault @"true" //set true/false


@interface PayminoStyle : NSObject
{
    
}
/**
 backgroundColor
 */
@property (nonatomic) UIColor *backgroundColor;
/**
 navbarColor
 */
@property (nonatomic) UIColor *navbarColor;
/**
 inputFieldBackgroundColor
 */
@property (nonatomic) UIColor *inputFieldBackgroundColor;
/**
 inputFieldTextColor
 */
@property (nonatomic) UIColor *inputFieldTextColor;
/**
 inputFieldTitleColor
 */
@property (nonatomic) UIColor *inputFieldTitleColor;
/**
 inputFieldBorderColor
 */
@property (nonatomic) UIColor *inputFieldBorderColor;
/**
 inputFieldConfirmColor
 */
@property (nonatomic) UIColor *inputFieldConfirmColor;
/**
 inputFieldNonConfirmColor
 */
@property (nonatomic) UIColor *inputFieldNonConfirmColor;
/**
 inputFieldWrongColor
 */
@property (nonatomic) UIColor *inputFieldWrongColor;
/**
 buttonBackgroundColor
 */
@property (nonatomic) UIColor *buttonBackgroundColor;
/**
 buttonTitleColor
 */
@property (nonatomic) UIColor *buttonTitleColor;
/**
 segmentColor
 */
@property (nonatomic) UIColor *segmentColor;
/**
 modalTransitonStyle
 */
@property (nonatomic) UIModalTransitionStyle modalTransitonStyle;
/**
 TabBarBackgroundColor
 */
@property (nonatomic) UIColor *tabBarBackgroundColor;
/**
 TabBarTextColor
 */
@property (nonatomic) UIColor *tabBarTextColor;
/**
 TabBarSelectedColor
 */
@property (nonatomic) UIColor *tabBarSelectedColor;
/**
 TabBarSelectedTextColor
 */
@property (nonatomic) UIColor *tabBarSelectedTextColor;
/**
 TabBarBorderColor
 */
@property (nonatomic) UIColor *tabBarBorderColor;
/**
 Card Vault Value
 */
@property (nonatomic) BOOL isCardVault;
/**
 Table section font size
 */
@property (nonatomic) float tableSectionFontSize;
/**
 Card Scanner Enable or Desable
 */
@property (nonatomic) BOOL isCardScanner;





@end
