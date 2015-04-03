Pod::Spec.new do |s|
  s.name             = "RCTWebSocket"
  s.version          = "0.1.0"
  s.summary          = "A React Native WebSocket client extension."
  s.homepage         = "https://github.com/tptee/RCTWebSocket"
  s.license          = 'MIT'
  s.author           = { "Tyler Thompson" => "tyler@tylerpaulthompson.com" }
  s.source           = { :git => "https://github.com/tptee/WebSocketReactNative.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'RCTWebSocket/**/*'
  s.resource_bundles = {
    'RCTWebSocket' => ['Pod/Assets/*.png']
  }

  s.dependency 'Starscream', '~> 0.9.2'
  s.dependency 'React', '~> 0.2.1'
end
