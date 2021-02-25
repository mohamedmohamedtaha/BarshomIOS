 platform :ios, '11.0'

target 'Barshom' do
  use_frameworks!

pod 'Alamofire'
pod 'ObjectMapper'
pod 'MBProgressHUD'
pod 'Reachability'
pod 'SDWebImage'
pod 'NitroUIColorCategories'
pod 'DZNEmptyDataSet'
pod 'IQKeyboardManagerSwift'
pod 'HRRoundAndBorderedView'
pod 'SwiftyUserDefaults'
pod 'DropDown'
pod 'CCMPopup', :inhibit_warnings => true
pod 'Toaster', :git => 'https://github.com/devxoul/Toaster.git', :branch => 'master'
pod 'JVFloatLabeledTextField'
pod 'Cosmos'
pod 'SideMenu'
pod 'GMStepper'
pod 'PKHUD'
#pod 'TextFieldEffects'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end


end
