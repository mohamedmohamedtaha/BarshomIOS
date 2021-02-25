//
//  Language.swift
//
//  Created by Mohamed Elmakkawy on 3/3/18.
//  Copyright © 2018 Mohamed Elmakkawy. All rights reserved.
//

import Foundation
import UIKit

// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"

class Language {
    class func currentLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        if lang == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        userdef.set([lang,currentLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
    
}
