//
//  contactUsTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

class contactUsTVC: baseTVC {

  @IBOutlet weak var userNameTxt: RVTxtFaild!
  @IBOutlet weak var emailTxt: RVTxtFaild!
  @IBOutlet weak var titleTxt: RVTxtFaild!
  
  override func viewDidLoad() {
        super.viewDidLoad()
      userNameTxt.AddImage(#imageLiteral(resourceName: "info"))
      emailTxt.AddImage(#imageLiteral(resourceName: "email"))
      titleTxt.AddImage(#imageLiteral(resourceName: "requests"))
    }

}
