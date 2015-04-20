#import <Foundation/Foundation.h>
#import <PocketSocket/PSWebSocket.h>
#import <RCTBridgeModule.h>
#import <RCTEventDispatcher.h>

@interface RCTWebSocket : NSObject<RCTBridgeModule, PSWebSocketDelegate>

@property (strong, nonatomic) PSWebSocket *ws;
@property (weak, nonatomic) RCTResponseSenderBlock callback;

@end
