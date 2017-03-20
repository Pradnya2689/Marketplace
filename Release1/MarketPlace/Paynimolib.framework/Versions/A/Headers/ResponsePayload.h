//
//  ResponsePayload.h
//  PaynimoApp
//
//  Created by Mobapp2 on 16/01/15.
//  Copyright (c) 2015 Mobapp2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorRes : NSObject
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *desc;
@end


@interface ResponsePayload : NSObject
@property (nonatomic) NSString *MerchantCode;
@property (nonatomic) NSString *MerchantTransactionIdentifier;
@property (nonatomic) NSString *MerchantTransactionRequestType;
@property (nonatomic) NSString *BankSelectionCode;
@property (nonatomic) NSString *InstrumentAliasName;
@property (nonatomic) NSString *InstrumentToken;
@property (nonatomic) NSString *Token;
@property (nonatomic) NSString *Amount;
@property (nonatomic) NSString *BalanceAmount;
@property (nonatomic) NSString *BankReferenceIdentifier;
@property (nonatomic) NSString *DateTime;
@property (nonatomic) NSString *ErrorMessage;
@property (nonatomic) NSString *Identifier;
@property (nonatomic) NSString *RefundIdentifier;
@property (nonatomic) NSString *StatusCode;
@property (nonatomic) NSString *StatusMessage;
@property (nonatomic) NSString *instructionErrorCode;
@property (nonatomic) NSString *instructionErrorDesc;
@property (nonatomic) NSString *instructionStatusCode;
@property (nonatomic) NSString *InstructionID;

- (instancetype)initWithDictonary:(NSDictionary *)dic;

@end





