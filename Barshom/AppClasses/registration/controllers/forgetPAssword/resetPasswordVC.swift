//
//  resetPasswordVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

class resetPasswordVC: UIViewController {

  @IBOutlet weak var passwordTxt: RVTxtFaild!
  @IBOutlet weak var rePasswordTxt: RVTxtFaild!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      passwordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
      rePasswordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
    }
    

 

}
