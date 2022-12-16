//
//  AppHelper.swift
//  Nepros
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import AVFoundation
import Photos
import IQKeyboardManagerSwift
import MobileCoreServices
import SCLAlertView
public class AppHelper {
    
    private init() {}
    
    
    public static var appDelegate: BaseAppDelegate {
        get {
            return (UIApplication.shared.delegate as! BaseAppDelegate)
        }
    }
    
    public static var rootViewController: UIViewController? {
        get {
            return (UIApplication.shared.delegate as! BaseAppDelegate).window?.rootViewController
        }
    }
    public static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    //MARK: -Alert Controller
    public static func showInfoAlert(
        message: String,
        title: String = Resources.AlertView.note,
        closeButtonTitle: String = Resources.Common.ok,
        iconImage: UIImage? = nil) -> Void
    {
        SCLAlertView().showTitle(
            title,
            subTitle: message,
            style: SCLAlertViewStyle.info,
            closeButtonTitle: closeButtonTitle,
            timeout: nil,
            colorStyle: 0xEFB94C,
            colorTextButton: 0xFFFFFF,
            circleIconImage: iconImage,
            animationStyle: .topToBottom)
    }
    
    class func showLoginAlert(vc: UIViewController)
    {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        
//        let alertView = SCLAlertView()
//        alertView.addButton(Resources.Login.login) {
//            vc.goToLogin()
//        }
        let timeOut = SCLAlertView.SCLTimeoutConfiguration(timeoutValue: 1) {
            alertView.dismissAnimated()
        }
        let x = alertView.showTitle(
            Resources.AlertView.note,
            subTitle: Resources.Login.loginRequired,
            style: .notice,
            closeButtonTitle: Resources.Common.cancel,
            colorStyle: 0xEFB94C,
            colorTextButton: 0xFFFFFF,
            circleIconImage: nil,
            animationStyle: .topToBottom)
        
        vc.delay(time: 1) {
            x.close()
            vc.goToLogin()
        }
        
    }
    class func scheduleNotification(at date: Date,title: String,body: String) {
           
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents(in: .current, from: date)
            let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
            
//                    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            if #available(iOS 10.0, *) {
                let content = UNMutableNotificationContent()
                
                //adding title, subtitle, body and badge
                content.title = title
                content.body = body
                content.badge = 1
                content.sound = UNNotificationSound.default

                //getting the notification trigger
                //it will be called after 5 seconds
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                
                //getting the notification request
                let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
                
                
                //adding the notification to notification center
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                
            } else {
                // Fallback on earlier versions
            }
        
        }
    public static func showErrorAlert(
        message: String,
        title: String = Resources.AlertView.error,
        closeButtonTitle: String = Resources.Common.ok,
        iconImage: UIImage? = nil) -> Void
    {
        SCLAlertView().showTitle(
            title,
            subTitle: message,
            style: SCLAlertViewStyle.error,
            closeButtonTitle: closeButtonTitle,
            timeout: nil,
            colorStyle: 0xEFB94C,
            colorTextButton: 0xFFFFFF,
            circleIconImage: iconImage,
            animationStyle: .topToBottom)
    }
    
    public static func showWarningAlert(
        message: String,
        title: String = Resources.AlertView.warning,
        closeButtonTitle: String = Resources.Common.ok,
        iconImage: UIImage? = nil) -> Void
    {
        SCLAlertView().showTitle(
            title,
            subTitle: message,
            style: SCLAlertViewStyle.warning,
            closeButtonTitle: closeButtonTitle,
            timeout: nil,
            colorStyle: 0xEFB94C,
            colorTextButton: 0xFFFFFF,
            circleIconImage: iconImage,
            animationStyle: .topToBottom)
    }
    
    public struct KeychainConfiguration {
        public static let serviceName = "MyAppService"
        
        /*
         Specifying an access group to use with `KeychainPasswordItem` instances
         will create items shared accross both apps.
         
         For information on App ID prefixes, see:
         https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/AppID.html
         and:
         https://developer.apple.com/library/ios/technotes/tn2311/_index.html
         */
        //    static let accessGroup = "[YOUR APP ID PREFIX].com.example.apple-samplecode.GenericKeychainShared"
        
        /*
         Not specifying an access group to use with `KeychainPasswordItem` instances
         will create items specific to each app.
         */
        public static let accessGroup: String? = nil
    }
    static func initImagePickerPopup(
        authorizedAction: @escaping (_ sourceType: UIImagePickerController.SourceType, _ sender: UIView?) -> (),
        sender: UIView) {
        // Prepare the popup assets
        let title = Resources.Common.addImages
        let message = Resources.Common.imageSource
        
        // Add buttons to dialog
        let popup = PopupDialog(title: title, message: message, preferredWidth: 580)
        
        let libraryBtn = DefaultButton(title: Resources.Common.photoLibrary) {
            AppHelper.requestLibraryAccess(authorizedAction: authorizedAction, sender: sender)
        }
        let cameraBtn = DefaultButton(title: Resources.Common.camera) {
            AppHelper.requestCameraAccess(authorizedAction: authorizedAction, sender: sender)
        }
        let cancelBtn = CancelButton(title: Resources.Common.cancel)  {
            popup.dismiss(animated: true, completion: nil)
        }
        popup.addButtons([libraryBtn, cameraBtn, cancelBtn])
        
        // Present dialog
        AppHelper.rootViewController?.present(popup, animated: true, completion: nil)
    }
    static func requestCameraAcces(vc: UIViewController ,completionHandler:(()->Void)!) {
        
        let sourceType: UIImagePickerController.SourceType = .camera
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            DispatchQueue.main.async {
                completionHandler()
            }
        case .denied: alertToEncourageCameraAccessInitially()
        case .notDetermined: alertPromptToAllowCameraAccesViaSetting(vc: vc, completionHandler: completionHandler)
        default: alertToEncourageCameraAccessInitially()
        }
    }
    static func requestCameraAccess(
        authorizedAction: @escaping (_ sourceType: UIImagePickerController.SourceType, _ sender: UIView?) -> (),
        sender: UIView? = nil) {
        
        let sourceType: UIImagePickerController.SourceType = .camera
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            DispatchQueue.main.async {
             authorizedAction(sourceType, sender)
        }
        case .denied: alertToEncourageCameraAccessInitially()
        case .notDetermined: alertPromptToAllowCameraAccessViaSetting(authorizedAction: authorizedAction,sender: sender)
        default: alertToEncourageCameraAccessInitially()
        }
    }
    static func requestLibraryAcces(vc: UIViewController ,completionHandler:(()->Void)!) {
        
        let sourceType: UIImagePickerController.SourceType = .photoLibrary
        
        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {
        case .authorized:DispatchQueue.main.async {
            completionHandler()
            }
        case .denied: alertToEncourageLibraryAccessInitially()
        case .notDetermined: alertPromptToAllowLibraryAccesViaSettings(vc: vc, completionHandler: completionHandler)
        default: alertToEncourageLibraryAccessInitially()
        }
    }
    static func requestLibraryAccess(
        authorizedAction: @escaping (_ type: UIImagePickerController.SourceType, _ sender: UIView?) -> (),
        sender: UIView? = nil) {
        
        let sourceType: UIImagePickerController.SourceType = .photoLibrary
        
        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {
        case .authorized:DispatchQueue.main.async {
            authorizedAction(sourceType, sender)
            }
        case .denied: alertToEncourageLibraryAccessInitially()
        case .notDetermined: alertPromptToAllowLibraryAccessViaSettings(authorizedAction: authorizedAction, sender: sender)
        default: alertToEncourageLibraryAccessInitially()
        }
    }
    
    private static  func alertToEncourageLibraryAccessInitially() {
        let alert = UIAlertController(
            title: Resources.Common.important,
            message: Resources.Common.accessLibrary,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: Resources.Common.cancel, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: Resources.Common.allow, style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
        }))
        AppHelper.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private static func alertPromptToAllowLibraryAccesViaSettings(vc: UIViewController ,completionHandler:(()->Void)!) {
        
        let alert = UIAlertController(
            title: Resources.Common.important,
            message: Resources.Common.accessLibrary,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: Resources.Common.ok, style: .cancel) { alert in
            PHPhotoLibrary.requestAuthorization({ (status) in
                self.requestLibraryAcces(vc: vc, completionHandler: completionHandler)
            })
            
        })
        vc.present(alert, animated: true, completion: nil)
    }
    private static func alertPromptToAllowLibraryAccessViaSettings(
        authorizedAction: @escaping (_ sourceType: UIImagePickerController.SourceType, _ sender: UIView?) -> (),
        sender: UIView? = nil) {
        
        let alert = UIAlertController(
            title: Resources.Common.important,
            message: Resources.Common.accessLibrary,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: Resources.Common.ok, style: .cancel) { alert in
            PHPhotoLibrary.requestAuthorization({ (status) in
                self.requestLibraryAccess(authorizedAction: authorizedAction,sender: sender)
            })
            
        })
        AppHelper.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    private static func alertToEncourageCameraAccessInitially() {
        let alert = UIAlertController(
            title: Resources.Common.important,
            message: Resources.Common.accessCamera,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: Resources.Common.cancel, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: Resources.Common.allow, style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
        }))
        AppHelper.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private static func alertPromptToAllowCameraAccessViaSetting(
        authorizedAction: @escaping (_ type: UIImagePickerController.SourceType, _ sender: UIView?) -> (),
        sender: UIView? = nil) {
        
        let alert = UIAlertController(
            title: Resources.Common.important,
            message: Resources.Common.accessCamera,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: Resources.Common.ok, style: .cancel) { alert in
            if AVCaptureDevice.devices(for: AVMediaType.video).count > 0 {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                    DispatchQueue.main.async() {
                        self.requestCameraAccess(
                            authorizedAction: authorizedAction,
                            sender: sender) } }
            }
            }
        )
        AppHelper.rootViewController?.present(alert, animated: true, completion: nil)
    }
    private static func alertPromptToAllowCameraAccesViaSetting(vc: UIViewController ,completionHandler:(()->Void)!) {
        
        let alert = UIAlertController(
            title: Resources.Common.important,
            message: Resources.Common.accessCamera,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: Resources.Common.ok, style: .cancel) { alert in
            if AVCaptureDevice.devices(for: AVMediaType.video).count > 0 {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                    DispatchQueue.main.async() {
                        self.requestCameraAcces(vc: vc, completionHandler: completionHandler)
                        
                    } }
            }
            }
        )
        vc.present(alert, animated: true, completion: nil)
    }
    
   
    
    public static func showInfoAlert(
        title: String = Resources.AlertView.note,
        message: String,
        confirmBtnTitle: String,
        confirmBtnAction: @escaping () -> Void) -> Void  {
        
        let scl = SCLAlertView()
        scl.addButton(confirmBtnTitle) {
            confirmBtnAction()
        }
        scl.showTitle(
            title,
            subTitle: message,
            style: .info,
            closeButtonTitle: Resources.Common.cancel,
            timeout: nil,
            colorStyle: 0xEFB94C,
            colorTextButton: 0xFFFFFF,
            circleIconImage: nil,
            animationStyle: .topToBottom)
    }
    
    public static func showSuccessAlert(
        title: String = Resources.AlertView.success,
        message: String,
        confirmBtnTitle: String,
        confirmBtnAction: @escaping () -> Void) -> Void  {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let scl = SCLAlertView(appearance: appearance)
        scl.addButton(confirmBtnTitle) {
            confirmBtnAction()
        }
        
        scl.showTitle(
            title,
            subTitle: message,
            style: .success,
            closeButtonTitle: Resources.Common.ok,
            timeout: nil,
            colorStyle: 0xEFB94C,
            colorTextButton: 0xFFFFFF,
            circleIconImage: nil,
            animationStyle: .topToBottom)
    }
    class func showSuccessAlertWithoutButtons(vc: UIViewController , message: String)
    {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        let x = alertView.showTitle(
            Resources.AlertView.success,
            subTitle: message,
            style: .success,
            closeButtonTitle: Resources.Common.ok,
            colorStyle: 0xEFB94C,
            colorTextButton: 0xFFFFFF,
            circleIconImage: nil,
            animationStyle: .topToBottom)
        
        vc.delay(time: 1) {
            x.close()
        }
        
    }
    public static func showErrorAlertOneButton(
        title: String = Resources.AlertView.error,
        message: String,
        confirmBtnTitle: String,
        confirmBtnAction: @escaping () -> Void) -> Void  {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let scl = SCLAlertView(appearance: appearance)
        scl.addButton(confirmBtnTitle) {
            confirmBtnAction()
        }
        
        scl.showTitle(
            title,
            subTitle: message,
            style: .error,
            closeButtonTitle: Resources.Common.ok,
            timeout: nil,
            colorStyle: 0xEFB94C,
            colorTextButton: 0xFFFFFF,
            circleIconImage: nil,
            animationStyle: .topToBottom)
    }
    
    public static func showAlertWithTextField(textplaceholder: String,title:String,btnTitle: String,completionHandler:((String)->Void)!
)
    {
        let alertView = SCLAlertView()
                let txt = alertView.addTextField()
                txt.placeholder = textplaceholder
                txt.checkAligment()
                alertView.addButton(btnTitle) {
                    if txt.text!.trimmed == ""
                    {
                        showInfoAlert(message: Resources.ForgotPassword.codeRequired)
                    }
                    else
                    {
                        completionHandler("")
                    }
                }
                alertView.showTitle(Resources.ForgotPassword.activate, subTitle:  title, style: .notice, closeButtonTitle: Resources.Common.cancel, timeout: nil, colorStyle: 0xEFB94C, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: .topToBottom)
    }
    public static func makeWhatsAppMsg(to mobileNumber: String , content :String)
       {
           let urlWhats = "whatsapp://send?phone=\(mobileNumber)&text=\(content)"

           var characterSet = CharacterSet.urlQueryAllowed
           characterSet.insert(charactersIn: "?&")

            if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: characterSet){

           if let whatsappURL = NSURL(string: urlString) {
                           if UIApplication.shared.canOpenURL(whatsappURL as URL){
                               if #available(iOS 10.0, *) {
                                   UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: nil)
                               } else {
                                   UIApplication.shared.openURL(whatsappURL as URL)
                               }
                           }
                           else {
                               AppHelper.showInfoAlert(message: Resources.Common.noWhatsapp)

                           }
                       }
                   }
       }
    public static func showLangAlert(
        title: String = Resources.AlertView.note,
        arabicBtnAction: @escaping () -> Void,
        englishBtnAction: @escaping () -> Void) -> Void  {
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: true
        )
        let scl = SCLAlertView(appearance: appearance)
        scl.addButton("عربي") {
            arabicBtnAction()
        }
        scl.addButton("English") {
            englishBtnAction()
        }
        
        scl.showTitle(
            title,
            subTitle: Resources.Common.changeLang,
            style: .question,
            closeButtonTitle: Resources.Common.cancel,
            timeout: nil,
            colorStyle: 0xEFB94C,
            colorTextButton: 0xFFFFFF,
            circleIconImage: nil,
            animationStyle: .topToBottom)
    }
    
    
    public static func makeCall(to mobileNumber: String) {
        if mobileNumber.isEmpty {
            AppHelper.showInfoAlert(message: Resources.Common.noMobileFound)
            return
        }
        
        let urlPhone = "tel://\(mobileNumber)"
        if let urlString = urlPhone.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            
            if let phoneURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(phoneURL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(phoneURL)
                    }
                    
                } else {
                    AppHelper.showInfoAlert(message: Resources.Common.couldNotCall(phoneNumber: mobileNumber))
                }
            }
        }
    }
    
    public static func openInWeb(instagramHandle: String) {
        guard let url = URL(string: instagramHandle)  else {
            AppHelper.showInfoAlert(message: Resources.Common.noLinksFound)
            return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else
        {
                AppHelper.showInfoAlert(message: Resources.Common.noLinksFound)
        }
    }
    public static func createSms(to mobileNumber: String) {
        if mobileNumber.isEmpty {
            AppHelper.showInfoAlert(message: Resources.Common.noSmsFound)
            return
        }
        let smsUrl = URL(string: "sms:\(mobileNumber)")
        if UIApplication.shared.canOpenURL(smsUrl!) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(smsUrl!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(smsUrl!)
            }
            
        } else {
            AppHelper.showInfoAlert(message: Resources.Common.couldNotText(phoneNumber: mobileNumber))
        }
    }
   
}
