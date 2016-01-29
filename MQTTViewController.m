//

//  MQTTViewController.m

//  ScanNPayScanNPayIphone

//  Created by IT Dept on 09/10/15

//  @author Roney Francis

#import "MQTTViewController.h"
#import "MQTTKit.h"

#define kMQTTServerHost @"iot.eclipse.org"


@interface MQTTViewController ()

// create a property for the MQTTClient that is used to send and receive the message
@property (nonatomic, strong) MQTTClient *client;

@end

@implementation MQTTViewController

///Subscribe////
- (void)subscribe:(CDVInvokedUrlCommand*)command
{
    
    NSString *clientID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    self.client = [[MQTTClient alloc] initWithClientId:clientID];
    NSString *kTopic = [command.arguments objectAtIndex:0];
    NSLog(@"====================clientid========== %@", clientID);
    NSLog(@"====================self.client ========== %@", self.client );
    NSLog(@"====================kTopic========== %@", kTopic);
    
    //__block NSString *text = nil;
    [self.client setMessageHandler:^(MQTTMessage *message) {
       NSString *text = [message payloadString];
        //text = [message payloadString];
        NSLog(@"received message %@", text);
        
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:text];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
        // connect the MQTT client
    
        [self.client connectToHost:kMQTTServerHost completionHandler:^(MQTTConnectionReturnCode code) {
            if (code == ConnectionAccepted) {
                // The client is connected when this completion handler is called
                NSLog(@"client is connected with id %@", clientID);
                // Subscribe to the topic
                [self.client subscribe:kTopic withCompletionHandler:^(NSArray *grantedQos) {
                    // The client is effectively subscribed to the topic when this completion handler is called
                    NSLog(@"subscribed to topic %@", kTopic);
                }];
                
            }
        }];
    
}
///Subscribe////

/////publish MQTT////
-(void)publish:(CDVInvokedUrlCommand*)command
{
    NSString *clientID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    self.client = [[MQTTClient alloc] initWithClientId:clientID];
    
    NSString *kTopic = [command.arguments objectAtIndex:0];
    NSString *payload = [command.arguments objectAtIndex:1];
    NSLog(@"=====1======%@", kTopic);
    
    // use the MQTT client to send a message with the switch status to the topic
    [self.client connectToHost:kMQTTServerHost
             completionHandler:^(NSUInteger code) {
                 
                 if(code == ConnectionAccepted){
                     [self.client publishString:payload
                                        toTopic:kTopic
                                        withQos:AtMostOnce
                                         retain:NO
                              completionHandler:nil];
                     
                     
                    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Response Sent"];
                     
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                     // [self disconnect];

                 }
    }];
}
/////publish MQTT////


///Disconnect///
-(void)disconnect:(CDVInvokedUrlCommand*)command
{
    
    [self.client disconnectWithCompletionHandler:^(NSUInteger code) {
        
        // The client is disconnected when this completion handler is called
        
        NSLog(@"MQTT client is disconnected");
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Disconnected"];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
    }];
}
///Disconnect///
@end
