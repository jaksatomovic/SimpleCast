# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SimpleCast' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SimpleCast
  pod 'Alamofire'
  pod 'SMIconLabel'
  pod 'CodableAlamofire'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'Diff' || target.name == 'Bond'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end
