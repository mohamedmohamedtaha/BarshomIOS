//
//  backButton.swift
//  Gaz
//
//  Created by Mohamed Elmakkawy on 10/11/20.
//  Copyright © 2020 amr gamal. All rights reserved.
//

import UIKit

class backButton: UIButton {

    override func draw(_ rect: CGRect) {

      if LanguageManager.isArabic {
        self.setImage(UIImage(named: "backAr"), for: .normal)
      }else {
        self.setImage(UIImage(named: "backEn"), for: .normal)
      }
    }
    

}

