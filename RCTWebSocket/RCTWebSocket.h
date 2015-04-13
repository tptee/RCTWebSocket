#import <Foundation/Foundation.h>
#import <jetfire/JFRWebSocket.h>
#import <RCTBridgeModule.h>
#import <RCTEventDispatcher.h>

@interface RCTWebSocket : NSObject<RCTBridgeModule, JFRWebSocketDelegate>

@property (strong, nonatomic) JFRWebSocket *ws;
@property (weak, nonatomic) RCTResponseSenderBlock callback;

@end
