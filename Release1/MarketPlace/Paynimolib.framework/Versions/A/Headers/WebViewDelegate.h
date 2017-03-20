//
//  WebViewDelegate.h
//
//  Copyright (c) 2014 Ram Kulkarni (ramkulkarni.com). All rights reserved.
//
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "WebViewInterface.h"

@interface WebViewDelegate : NSObject <UIWebViewDelegate>
{
  //  BOOL isFinished;
    NSTimer *t;
    
    
    
}
	@property UIWebView* webView;




	- (id)initWithWebView:(UIWebView*) webView withWebViewInterface:(id<WebViewInterface>) webViewInterface;
	- (void) loadPage:(NSString*) pageName fromFolder:(NSString*) folderName;
    -(void) loadUrl:(NSString *)strUrl withParameters:(NSString *)param;
	-(void) createError:(NSError**) error withCode:(int) code withMessage:(NSString*) msg;
	-(void) callJSFunction:(NSString *) name withArgs:(NSDictionary *) args;

@end

