//
//  font.swift
//  hogozaty
//
//  Created by Mohamed Elmakkawy on 11/19/19.
//  Copyright © 2019 Mohamed Elmakkawy. All rights reserved.
//

import Foundation
import UIKit

struct AppFontName {
    static let Arlight = "DINNextLTW23-Regular"
    static let ArMedium = "DINNextLTW23-Regular"
    static let Arbold = "DINNextLTW23-Regular"
    
    static let Enlight = "DINNextLTW23-Regular"
    static let EnMedium = "DINNextLTW23-Regular"
    static let Enbold = "DINNextLTW23-Regular"
//    static let Enbold = "Poppins-Regular"

}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}


extension UIFont {

    @objc class func myLightSystemFont(ofSize size: CGFloat) -> UIFont {
        return (LanguageManager.isArabic) ? UIFont(name: AppFontName.Arlight, size: size)!:UIFont(name: AppFontName.Enlight, size: size)!

    }
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return (LanguageManager.isArabic) ? UIFont(name: AppFontName.ArMedium, size: size)!:UIFont(name: AppFontName.ArMedium, size: size)!
    }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return (LanguageManager.isArabic) ? UIFont(name: AppFontName.Arbold, size: size)!:UIFont(name: AppFontName.Enbold, size: size)!
    }

    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontLightUsage":
            fontName =  (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight
        case "CTFontMediumUsage":
            fontName = (LanguageManager.isArabic) ? AppFontName.ArMedium:AppFontName.EnMedium
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName =  (LanguageManager.isArabic) ?  AppFontName.Arbold:AppFontName.Enbold
        default:
            fontName =  (LanguageManager.isArabic) ? AppFontName.ArMedium:AppFontName.EnMedium
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideInitialize() {
        
        
        guard self == UIFont.self else { return }

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }

        if let lightSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myLightSystemFontMethod = class_getClassMethod(self, #selector(myLightSystemFont(ofSize:))) {
            method_exchangeImplementations(lightSystemFontMethod, myLightSystemFontMethod)
        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
        let attributes = [NSAttributedString.Key.font: (LanguageManager.isArabic) ? UIFont(name: AppFontName.ArMedium, size: 18)!:UIFont(name: AppFontName.ArMedium, size: 18)!,NSAttributedString.Key.foregroundColor:UIColor.white]

        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.backgroundColor = Color.mainColor
         navigationBarAppearace.titleTextAttributes = attributes
         navigationBarAppearace.barTintColor = Color.mainColor
//        UIApplication.shared.statusBarStyle = .lightContent
//        UIApplication.shared.statusBarUIView?.backgroundColor = Color.mainColor
//        UINavigationBar.appearance().backgroundColor =  Color.mainColor // backgorund color with gradient
//        // or
//        UINavigationBar.appearance().barTintColor =  Color.mainColor
        
        
         //navigationBarAppearace.setBackgroundImage(UIImage(named: "btopbg")!.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0 ,right: 0), resizingMode: .stretch), for: .default)




//        let appearance = UITabBarItem.appearance()
//        if (LanguageManager.isArabic) {
//            let attributes = [NSAttributedString.Key.font:UIFont(name: AppFontName.ArMedium, size: 14)!]
//            appearance.setTitleTextAttributes(attributes, for: .normal)
//        }else {
//            let attributes = [NSAttributedString.Key.font:UIFont(name: AppFontName.Enlight, size: 14)!]
//            appearance.setTitleTextAttributes(attributes, for: .normal)
//        }
        
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
//        
//        if (LanguageManager.isArabic) {
//           navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: AppFontName.ArMedium, size: 20)!]
//        }else {
//        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: AppFontName.Enlight, size: 20)!]
//        }
//        

       
    }
}
