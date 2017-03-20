//
//  Checkout.h
//  PaynimoApp
//
//  Created by Mobapp2 on 16/01/15.
//  Copyright (c) 2015 Mobapp2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMGlobal.h"
#import "ResponsePayload.h"


@interface Checkout : NSObject
{
    id requestPayload;
    
   
    

}
@property (nonatomic) ResponsePayload *response;
@property (nonatomic) NSMutableDictionary *dicTransaction;

-(id)requestPayload;
-(void)setRequestPayload;


#pragma mark - marchant
/**/
//#ifdef JSONPARSER
-(void)setMerchantIdentifier:(NSString *)MerchantCode;
-(void)setMerchantRequestType:(NSString *)RequestType;
-(void)setMerchantDescription:(NSString *)Description;
-(void)setMerchantResponseType:(NSString *)ResponseType;
-(void)setMerchantResponseEndpointURL:(NSString *)ResponseEndpointURL;
-(void)setMerchantWebhookType:(NSString *)WebhookType;
-(void)setMerchantWebhookEndpointURL:(NSString *)WebhookEndpointURL;
/*#else
-(void)setMerchantIdentifier:(NSString *)MerchantCode;
-(void)setMerchantTransactionIdentifier:(NSString *)MerchantTransactionIdentifier;
-(void)setMerchantReferenceInformation:(NSString *)MerchantReferenceInformation;
-(void)setTransactionAmount:(NSString *)TransactionAmount;
-(void)setTransactionCurrencyCode:(NSString *)TransactionCurrencyCode;
-(void)setTransactionDateTime:(NSString *)TransactionDateTime;
-(void)setMerchantTransactionType:(NSString *)value;
-(void)setMerchantTransactionSubType:(NSString *)value;
#endif*/


#pragma mark - Consumer
//-(void)setConsumerCartDetails:(RequestCartData *)MerchantCartDetails;
/**/
//#ifdef JSONPARSER
-(void)setConsumerIdentifier:(NSString *)ConsumerIdentifier;
-(void)setConsumerMobileNumber:(NSString *)ConsumerMobileNumber;
-(void)setConsumerEmailID:(NSString *)EmailID;
//cart
-(void)setCartIdentifier:(NSString *)value;
-(void)setCartReference:(NSString *)value;
-(void)setCartDescription:(NSString *)value;
-(void)addCartItem:(NSString *)Identifier amount:(NSString *)Amount SurchargeOrDiscount:(NSString *)SurchargeOrDiscountAmount SKU:(NSString *)SKU Description:(NSString *)Descriptor ProviderID:(NSString *)ProviderID Reference:(NSString *)reference CommisionAmt:(NSString *)CommisionAmt;
-(void) setConsumerAccountNumber :(NSString *) value;
/*#else
-(void)setConsumerIdentifier:(NSString *)ConsumerIdentifier;
-(void)setConsumerEmailID:(NSString *)ConsumerEmailID;
-(void)setConsumerMobileNumber:(NSString *)ConsumerMobileNumber;
-(void)addCartItem:(NSString *)Identifier amount:(NSString *)Amount SurchargeOrDiscount:(NSString *)SurchargeOrDiscountAmount SKU:(NSString *)SKU Description:(NSString *)Descriptor ProviderID:(NSString *)ProviderID Reference:(NSString *)reference;
#endif*/


#pragma mark -
#pragma mark Payment Method
#pragma mark -

#pragma mark Instruction
-(void)setPaymentInstructionIdentifier:(NSString *)value;
-(void)setPaymentInstructionReference:(NSString *)value;
-(void)setPaymentInstructionDescription:(NSString *)value;
-(void)setPaymentInstructionAction:(NSString * )value;
-(void)setPaymentInstructionType:(NSString *)value;
-(void)setPaymentInstructionLimit:(NSString *)value;
-(void)setPaymentInstructionAmount:(NSString *)value;
-(void)setPaymentInstructionOccurrence:(NSString *)value;
-(void)setPaymentInstructionFrequency:(NSString *)value;
-(void)setPaymentInstructionValidity:(NSString *)value;
-(void)setPaymentInstructionStartDateTime:(NSString *)value;
-(void)setPaymentInstructionEndDateTime:(NSString *)value;







#pragma mark Method
-(void)setPaymentMethodType:(NSString *)value;
-(void)setPaymentMethodToken:(NSString *)value;

#pragma mark Transaction
-(void)setPaymentTransactionToken:(NSString *)value;
-(void)setPaymentTransactionIdentifier:(NSString *)value;
-(void)setPaymentTransactionType:(NSString *)value;
-(void)setPaymentTransactionSubType:(NSString *)value;
-(void)setPaymentTransactionCurrency:(NSString *)value;
-(void)setPaymentTransactionAmount:(NSString *)value;
-(void)setPaymentTransactionDateTime:(NSString *)value;
-(void)setPaymentTransactionReference:(NSString *)value;
-(void)setPaymentTransactionDescription:(NSString *)value;
-(void)setPaymentTransactionIsRegistration :(NSString *)value;
-(void)setPaymentTransactionmerchantInitiated : (NSString *)value;




#pragma mark Instrument
-(void)setPaymentInstrumentToken:(NSString *)value;
-(void)setPaymentInstrumentAction:(NSString *)value;
-(void)setPaymentInstrumentType:(NSString *)value;
-(void)setPaymentInstrumentSubType:(NSString *)value;
-(void)setPaymentInstrumentIdentifier:(NSString *)value;
-(void)setPaymentInstrumentAlias:(NSString *)value;
-(void)setPaymentInstrumentProvider:(NSString *)value;
-(void)setPaymentInstrumentAcquirer:(NSString *)value;
-(void)setPaymentInstrumentProcessor:(NSString *)value;
-(void)setPaymentInstrumentIssuer:(NSString *)value;
-(void)setPaymentInstrumentIFSC:(NSString *)value;
-(void)setPaymentInstrumentMICR:(NSString *)value;
-(void)setPaymentInstrumentBIC:(NSString *)value;
-(void)setPaymentInstrumentIBAN:(NSString *)value;
-(void)setPaymentInstrumentVerificationCode:(NSString *)value;
//holder
-(void)setPaymentInstrumentHolderName:(NSString *)value;
//holder Address
-(void)setPaymentInstrumentAddressStreet:(NSString *)value;
-(void)setPaymentInstrumentAddressCity:(NSString *)value;
-(void)setPaymentInstrumentAddressState:(NSString *)value;
-(void)setPaymentInstrumentAddressCounty:(NSString *)value;
-(void)setPaymentInstrumentAddressCountry:(NSString *)value;
-(void)setPaymentInstrumentAddressZipCode:(NSString *)value;
//Issuance
-(void)setPaymentInstrumentIssuanceMonth:(NSString *)value;
-(void)setPaymentInstrumentIssuanceYear:(NSString *)value;
-(void)setPaymentInstrumentIssuanceDateTime:(NSString *)value;
//Expiry
-(void)setPaymentInstrumentExpiryMonth:(NSString *)value;
-(void)setPaymentInstrumentExpiryYear:(NSString *)value;
-(void)setPaymentInstrumentExpiryDateTime:(NSString *)value;
//Authentication
-(void)setPaymentInstrumentAuthenticationType:(NSString *)value;
-(void)setPaymentInstrumentAuthenticationSubType:(NSString *)value;
-(void)setPaymentInstrumentAuthenticationToken:(NSString *)value;


#pragma mark - Request Payload
#pragma mark -
-(void)setResponseDictionary:(NSDictionary *)dic;
-(NSString *)getMerchantCode;
-(NSString *)getMerchantTransactionIdentifier;
-(NSString *)getMerchantTransactionRequestType;
-(NSString *)getBankSelectionCode;
-(NSString *)getInstrumentAliasName;
-(NSString *)getInstrumentToken;
-(NSString *)getToken;
//PaymentTransaction
-(NSString *)getAmount;
-(NSString *)getDateTime;
-(NSString *)getStatusMessage;
-(NSString *)getBalanceAmount;
-(NSString *)getBankReferenceIdentifier;
-(NSString *)getErrorMessage;
-(NSString *)getIdentifier;
-(NSString *)getRefundIdentifier;
-(NSString *)getStatusCode;

-(NSString *)getPaymentInstructionAction;
-(NSString *) getPaymentInstructionStartDate;
-(NSString *) getPaymentInstructionEndDate;
-(NSString *) getPaymentInstructionDEbitAmount;
-(NSString *) getPaymentInstructionAmountType;
-(NSString *) getPaymentInstructionFrequencyType;



-(NSString *) getPaymentMethodToken;

-(NSString *) getPaymentTransactionMerchantInitiated;



-(NSString *) getPaymentInstrumentIdentifier;
-(NSString *) getPaymentInstrumenntToken;

-(NSString *) getPAymentInstructionErrorCode;
-(NSString *) getPAymentInstructionErrorDescription;
-(NSString *) getPAymentInstructionErrorStatusCode;
-(NSString *) getPAymentInstructionID;

-(NSString *) getConsumerMobileNumber;
-(NSString *) getPaymentInstrumentVerificationCode;

-(NSString *) getPaymentTransactionType;
-(NSString *) getPaymentTransactionSubType;




@end
