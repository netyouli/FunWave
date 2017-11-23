Pod::Spec.new do |s|
  s.name         = "FunWave"
  s.version      = "1.0.1"
  s.summary      = "FunWave is Swift3.+ wave controll"

  s.homepage     = "https://github.com/netyouli/FunWave"

  s.license      = "MIT"

  s.author             = { "吴海超(WHC)" => "712641411@qq.com" }

  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/netyouli/FunWave.git", :tag => "1.0.1"}

  s.source_files  = "FunWave/FunWave/*.{swift}"
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
end
