Pod::Spec.new do |s|
  s.name               = "LastfmClient"
  s.version            = "0.1.9"
  s.summary            = "A Swifty last.fm api client using Codable."
  s.homepage           = "https://github.com/starhoshi/LastfmClient"
  s.license            = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "star__hoshi" => "kensuke1751@gmail.com" }
  s.social_media_url   = "https://twitter.com/star__hoshi"
  s.platform           = :ios, "10.0"
  s.source             = { :git => "https://github.com/starhoshi/LastfmClient.git", :tag => s.version.to_s }
  s.source_files       = "LastfmClient/**/*.{swift}"

  s.dependency         "APIKit", "~> 3.1.1"
end

