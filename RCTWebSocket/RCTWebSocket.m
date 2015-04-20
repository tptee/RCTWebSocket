#import "RCTWebSocket.h"
#import <Foundation/Foundation.h>
#import <PocketSocket/PSWebSocket.h>
#import <RCTLog.h>
#import <RCTBridge.h>
#import <RCTBridgeModule.h>
#import <RCTEventDispatcher.h>

@implementation RCTWebSocket

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(connect:(NSString *)host callback:(RCTResponseSenderBlock)callback) {
	self.callback = callback;
	self.ws = [[PSWebSocket alloc] init];
	// create the NSURLRequest that will be sent as the handshake
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:host]];
	
	// create the socket and assign delegate
	self.ws = [PSWebSocket clientSocketWithRequest:request];
	self.ws.delegate = self;
	
	[self.ws open];
}

-(void)webSocketDidOpen:(PSWebSocket *)webSocket {
	self.callback(@[[NSNull null], @"Connected to WebSocket."]);

}

-(void)webSocket:(PSWebSocket *)webSocket didReceiveMessage:(id)message {
	[self.bridge.eventDispatcher
		sendDeviceEventWithName:@"WebSocketMessage"
		body:(NSString *)message];
}

- (void)webSocket:(PSWebSocket *)webSocket didFailWithError:(NSError *)error {
	NSLog(@"The websocket handshake/connection failed with an error: %@", error);
	[self.bridge.eventDispatcher
		sendDeviceEventWithName:@"WebSocketError"
		body:error.localizedDescription];
}
- (void)webSocket:(PSWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
	NSLog(@"The websocket closed with code: %@, reason: %@, wasClean: %@", @(code), reason, (wasClean) ? @"YES" : @"NO");
	[self.bridge.eventDispatcher
		sendDeviceEventWithName:@"WebSocketDisconnect"
		body:@"Disconnected from WebSocket."];
}

@end
