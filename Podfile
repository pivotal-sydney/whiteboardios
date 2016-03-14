workspace 'whiteboardios'

use_frameworks!

def whiteboardios_pods
  pod 'Alamofire', '~> 3.0'
end

def testing_pods
  pod 'Quick', '~> 0.9.0'
  pod 'Nimble', '3.0.0'
end

target 'whiteboardios' do
  whiteboardios_pods
end

target 'whiteboardiosTests' do
  whiteboardios_pods
  testing_pods
end

target 'whiteboardiosUITests' do
  whiteboardios_pods
  testing_pods
end
