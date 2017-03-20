//
//  PMGlobal.h
//  PaynimoApp
//
//  Created by Payal Patel on 17/12/14.
//  Copyright (c) 2014 Payal Patel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <objc/runtime.h>
#import <unistd.h>

#import "PayminoStyle.h"
#import "PMPaymentOptionView.h"
//#import "PayminoStyle.h"


//#import "Checkout.h"


//switch statement with nsstring
#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@protocol PMGlobal <NSObject>

@end
