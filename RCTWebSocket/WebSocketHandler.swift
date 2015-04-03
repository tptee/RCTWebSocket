import Foundation
import Starscream

public class WebSocketHandler: NSObject, WebSocketDelegate {
	public var socket: WebSocket?
	public var onMessage: ((message: String) -> ())?
	public var onData: ((data: NSData) -> ())?
	public var onConnect: ((message: String) -> ())?
	public var onDisconnect: ((message: String) -> ())?

	public func connect(host: String) {
		let wsURL = NSURL(string: host)
		
		if let URL = wsURL {
			socket = WebSocket(url: URL)
			
			if let sock = socket {
				sock.delegate = self
				sock.connect()
			}
		
		}
	}
	
	public func websocketDidReceiveData(socket: WebSocket, data: NSData) {
		println("Not implemented")
	}

	public func websocketDidConnect(socket: WebSocket) {
		if let cb = onConnect {
			cb(message: "Connected to server.")
		}
	}
	
	public func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
		if let cb = onDisconnect {
			if let err = error {
				cb(message: err.localizedDescription)
				return
			}
			cb(message: "Disconnected from server.")
		}
	}
	
	public func websocketDidReceiveMessage(socket: WebSocket, text: String) {
		if let cb = onMessage {
			cb(message: text)
		}
	}
	
	public func writeString(message: String) {
		if let sock = socket {
			sock.writeString(message)
		}
	}
}