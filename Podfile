platform :ios, '9.0'

def shared_pods
  pod 'APIKit'
end

target 'Demo' do
  use_frameworks!

  shared_pods
end

target 'LastfmClient' do
  use_frameworks!
  shared_pods

  target 'LastfmClientTests' do
    inherit! :search_paths
  end
end

