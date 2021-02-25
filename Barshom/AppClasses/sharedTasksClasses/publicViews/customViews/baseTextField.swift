//
//  baseTextField.swift
//
//  Created by Mohamed Elmakkawy on 7/8/20.
//  Copyright © 2020 Mohamed Elmakkawy. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class baseTextField: JVFloatLabeledTextField {

  
    override func draw(_ rect: CGRect) {
        // Drawing code
        if Language.currentLanguage() == "ar" {
            self.textAlignment = .right
        }else {
            self.textAlignment = .left
        }
    }
    

}
