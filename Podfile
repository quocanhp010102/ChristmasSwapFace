# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
platform :ios, '13.0'
inhibit_all_warnings!
target 'ChristmasSwapFace' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'CircleProgressView'
  # Pods for ChristmasSwapFace
  pod 'SnapKit', '~> 5.6.0'
  pod 'Toast-Swift'
  pod 'DropDown'
  pod 'R.swift'
  pod 'SwiftLint', :inhibit_warnings => true
  pod 'DeviceKit', '~> 4.0'
  pod 'HGCircularSlider'
  # Network
  pod 'TrailerPlayer'
  pod 'AlamofireImage', '~> 4.1'
  pod 'SETabView'
  pod 'Kingfisher'
  pod 'SwiftKeychainWrapper'
  pod 'SwiftVideoBackground'
  pod 'WCLShineButton'
  
  #chatandcall
  pod 'lottie-ios'
  pod 'RealmSwift'
  pod 'Google-Mobile-Ads-SDK', '~> 7.69.0'
  #pod 'Toast-Swift'
  pod 'MBProgressHUD'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            xcconfig_path = config.base_configuration_reference.real_path
            xcconfig = File.read(xcconfig_path)
            xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
            File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
            config.build_settings["DEVELOPMENT_TEAM"] = "YOUR TEAM ID"
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
         end
    end
  end
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
