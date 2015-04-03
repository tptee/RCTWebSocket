#import <Foundation/Foundation.h>
@import React;

@class WebSocketHandler;

@interface RCTWebSocketManager: NSObject<RCTBridgeModule>

@property (strong, nonatomic) WebSocketHandler *ws;

@end
