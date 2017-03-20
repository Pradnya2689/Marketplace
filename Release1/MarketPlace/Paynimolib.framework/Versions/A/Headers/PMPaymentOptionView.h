//
//  PMPaymentOptionView.h
//  Paynimolib
//
//  Created by Mobapp2 on 12/05/15.
//  Copyright (c) 2015 Mobapp2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checkout.h"
#import "CustomIOSAlertView.h"


@class Checkout;


@interface PMPaymentOptionView : UIViewController<UITableViewDataSource, UITableViewDelegate,CustomIOSAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
/**
 Designated initializer for creating PMPaymentOptionView.
 @param checkOut Checkout class object.
 @param publicKey Paynimo merchant public key.
 @param success a block callback that is executed when the requested Paynimo operation returns success.
 @param failure a block callback that is executed when the requested Paynimo operation returns error.
 */
-(PMPaymentOptionView *)initWithPublicKey:(NSString *)pubKey checkout:(Checkout *)checkOut paymentType:(NSString *)paymenttype  success:(void (^)(id))success failure:(void (^)(NSDictionary *))failure cancel:(void (^)())back;
@end
