Pod::Spec.new do |s|
  s.name    = 'JUJsonModel'
  s.version = '1.0.3'
  s.summary = 'json转模型，模型转json'
  s.homepage    = 'https://github.com/jutewei/JsonMode'
  s.license = 'MIT'
  s.platform    = :ios
  s.author  = {'Juvid' => 'jutewei@qq.com'}
  s.license          = {
    :type => 'Copyright',
    :text => <<-LICENSE
    © 2016-2021 juvid. All rights reserved.
    LICENSE
  }
#  s.platform    = :osx, '10.9'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  
  
  s.swift_version = '5'
  s.source  = {:git => 'https://github.com/jutewei/JsonMode.git', :tag => s.version}
  s.requires_arc = true
  s.source_files = 'Source/*.{h,m}'
 
end
