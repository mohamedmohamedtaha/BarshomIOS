//
//  Localizer.swift
//
//  Created by Mohamed Elmakkawy on 3/3/18.
//  Copyright © 2018 Mohamed Elmakkawy. All rights reserved.
//

import Foundation

class Localizer {
    class func doExtchangeLang() {
        ExtchangeMEthodsForClass(className: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.customLocalizedString(forKey:value:table:)))
    }
}

extension Bundle {
    @objc func customLocalizedString(forKey key: String, value: String?, table tableName: String?) -> String
    {
        let currentLang = Language.currentLanguage()
        var cBundel = Bundle()
        if let path = Bundle.main.path(forResource: currentLang, ofType: "lproj"){
            cBundel = Bundle(path: path)!
        }else{
            let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
            cBundel = Bundle(path: path!)!
        }
        
        return cBundel.customLocalizedString(forKey:key ,value:value, table:tableName)
    }
}

extension String {
    func localized() -> String {
        var path:String!=""
        if  Bundle.main.preferredLocalizations.first == "ar" {

            path = Bundle.main.path(forResource: "ar", ofType: "lproj")
        }else{
            path = Bundle.main.path(forResource: "en", ofType: "lproj")
        }

        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
}
func ExtchangeMEthodsForClass(className:AnyClass,
                              originalSelector:Selector,
                              overrideSelector:Selector)
{
    let originalMethod = class_getInstanceMethod(className, originalSelector)
    let overrideMethod = class_getInstanceMethod(className, overrideSelector)
    
    if class_addMethod(className, originalSelector, method_getImplementation(overrideMethod!), method_getTypeEncoding(overrideMethod!))
    {
        class_replaceMethod(className, overrideSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        
    }else{
        method_exchangeImplementations(originalMethod!, overrideMethod!)
    }
}
