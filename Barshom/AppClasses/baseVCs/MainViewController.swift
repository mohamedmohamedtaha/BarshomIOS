//
//  MainViewController.swift
//  Barshom
//
//  Created by Ahmed Yehia on 05/04/2021.
//

import UIKit
class MainViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().semanticContentAttribute = !LanguageManager.isArabic ? .forceLeftToRight : .forceLeftToRight
        if LanguageManager.isArabic
        {
            LanguageManager.currentLanguage = .ar
        }
        else
        {
            LanguageManager.currentLanguage = .en
        }
        UserService.shared.getAppSettings { settings in
            if UserManager.isLoggedIn
            {
                
                UserService.shared.getUserData(userID: UserManager.getUserData!.id!) { (datas) in
                    UserManager.saveUserInfo(user: datas as! [String : Any])
                    self.MakeHomeRoot()
                }
                
            }
            else
            {
                self.delay(time: 0) {
                    self.MakeHomeRoot()
                }
            }
        }
            
        
    }
    
}

