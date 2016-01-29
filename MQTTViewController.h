//
//  MQTTViewController.h
//  
//
//  Created by Roney Francis on 09/10/15.
//
//

//#import <Cordova/Cordova.h>
#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface MQTTViewController : CDVPlugin

-(void)publish:(CDVInvokedUrlCommand*)command;
-(void)subscribe:(CDVInvokedUrlCommand*)command;
@end
