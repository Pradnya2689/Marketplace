//
//  PMStyle.m
//  PaynimoApp
//
//  Created by Mobapp2 on 16/12/14.
//  Copyright (c) 2014 Mobapp2. All rights reserved.
//

#import "PayminoStyle.h"


@implementation PayminoStyle
@synthesize backgroundColor, navbarColor, inputFieldTextColor, inputFieldBackgroundColor, inputFieldTitleColor, inputFieldBorderColor, inputFieldConfirmColor, inputFieldNonConfirmColor, inputFieldWrongColor, buttonBackgroundColor, buttonTitleColor, segmentColor, modalTransitonStyle;
@synthesize tabBarBackgroundColor;
@synthesize tabBarTextColor;
@synthesize tabBarBorderColor;
@synthesize tabBarSelectedColor;
@synthesize tabBarSelectedTextColor;
@synthesize isCardVault;
@synthesize tableSectionFontSize;
@synthesize isCardScanner;



-(id)init{
    self = [super init];
    if (self) {
        /*UIColor *mainColor = [UIColor colorWithRed:239.0/255.0 green:80/255.0 blue:0/255.0 alpha:1.0];
        backgroundColor = [UIColor whiteColor];
        navbarColor = [UIColor whiteColor];
        inputFieldTextColor = [UIColor darkTextColor];
        inputFieldBackgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
        inputFieldTitleColor = mainColor;
        inputFieldBorderColor = [UIColor colorWithRed:149.0/255.0 green:0/255.0 blue:11.0/255.0 alpha:1.0];
        inputFieldConfirmColor = [UIColor darkTextColor];
        inputFieldWrongColor = [UIColor redColor];
        buttonBackgroundColor = mainColor;
        buttonTitleColor = [UIColor whiteColor];
        segmentColor = [UIColor whiteColor];*/
        
        backgroundColor = [self colorWithHexString:BackgroundColor];
        navbarColor = [self colorWithHexString:NavbarColor];
        inputFieldTextColor = [self colorWithHexString:InputFieldTextColor];
        inputFieldBackgroundColor = [self colorWithHexString:InputFieldBackgroundColor];
        inputFieldTitleColor = [self colorWithHexString:InputFieldTitleColor];//mainColor;
        inputFieldBorderColor = [self colorWithHexString:InputFieldBorderColor];
        inputFieldConfirmColor = [self colorWithHexString:InputFieldConfirmColor];
        inputFieldWrongColor = [self colorWithHexString:InputFieldWrongColor];//[UIColor redColor];
        buttonBackgroundColor = [self colorWithHexString:ButtonBackgroundColor];
        buttonTitleColor = [self colorWithHexString:ButtonTitleColor];
        segmentColor = [self colorWithHexString:SegmentColor];
        tabBarBackgroundColor = [self colorWithHexString:TabBarBackgroundColor];
        tabBarTextColor = [self colorWithHexString:TabBarTextColor];
        tabBarBorderColor = [self colorWithHexString:TabBarBorderColor];
        tabBarSelectedColor = [self colorWithHexString:TabBarSelectedColor];
        tabBarSelectedTextColor = [self colorWithHexString:TabBarSelectedTextColor];
        isCardVault = true;
        isCardScanner = true;
        tableSectionFontSize = 15.0;
        
        
        
    }
    return self;
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
