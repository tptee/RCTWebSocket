#import "RCTWebSocket.h"
#import <Foundation/Foundation.h>
#import <jetfire/JFRWebSocket.h>
#import <RCTLog.h>
#import <RCTBridge.h>
#import <RCTBridgeModule.h>
#import <RCTEventDispatcher.h>

@implementation RCTWebSocket

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(connect:(NSString *)host callback:(RCTResponseSenderBlock)callback) {
	self.callback = callback;
	self.ws = [[JFRWebSocket alloc] initWithURL:[NSURL URLWithString:host] protocols:nil];
}

- (void)websocketDidConnect:(JFRWebSocket *)socket {
	self.callback(@[[NSNull null], @"Connected to WebSocket."]);
}

- (void)websocket:(JFRWebSocket *)socket didReceiveMessage:(NSString *)string {
	[self.bridge.eventDispatcher
		sendDeviceEventWithName:@"WebSocketMessage"
		body:string];
}

- (void)websocketDidDisconnect:(JFRWebSocket *)socket error:(NSError *)error {
	if (error) {
		NSLog(@"%@", [error localizedDescription]);
	}
	
	[self.bridge.eventDispatcher
		sendDeviceEventWithName:@"WebSocketDisconnect"
		body:@"Disconnected from WebSocket."];
}
@end
