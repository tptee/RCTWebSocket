@import React;
#import "RCTWebSocketManager.h"
#import "RCTWebSocket/RCTWebSocket-Swift.h"

@implementation RCTWebSocketManager
@synthesize bridge = _bridge;

- (void)connect:(NSString *)host callback:(RCTResponseSenderBlock)callback
{
	RCT_EXPORT();
	__weak typeof(self) weakSelf = self;
	
	self.ws = [[WebSocketHandler alloc] init];
	
	self.ws.onConnect = ^void (NSString *message) {
		callback(@[[NSNull null], message]);
	};
	
	self.ws.onMessage = ^void (NSString *message) {
		[weakSelf.bridge.eventDispatcher
			sendDeviceEventWithName:@"WebSocketMessage"
			body:message];
	};
	
	[self.ws connect:host];
}

@end
