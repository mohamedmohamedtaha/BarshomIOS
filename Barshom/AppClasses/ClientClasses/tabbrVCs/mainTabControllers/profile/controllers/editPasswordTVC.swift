//
//  editPasswordTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/6/21.
//

import UIKit

class editPasswordTVC: UITableViewController {

  @IBOutlet weak var oldPassword: RVTxtFaild!
  @IBOutlet weak var newPassword: RVTxtFaild!
  @IBOutlet weak var retypePassword: RVTxtFaild!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      oldPassword.AddImage(#imageLiteral(resourceName: "car-key"))
      newPassword.AddImage(#imageLiteral(resourceName: "car-key"))
      retypePassword.AddImage(#imageLiteral(resourceName: "car-key"))
    }

}
