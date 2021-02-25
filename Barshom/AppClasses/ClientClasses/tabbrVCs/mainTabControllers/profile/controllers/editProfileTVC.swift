//
//  editProfileTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/6/21.
//

import UIKit

class editProfileTVC: UITableViewController {

  @IBOutlet weak var nameTxt: RVTxtFaild!
  @IBOutlet weak var mobileTxt: RVTxtFaild!
  @IBOutlet weak var emailTxt: RVTxtFaild!
  @IBOutlet weak var cityTxt: RVTxtFaild!
  @IBOutlet weak var clientCodeTxt: RVTxtFaild!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    nameTxt.AddImage(#imageLiteral(resourceName: "info"))
    mobileTxt.AddImage(#imageLiteral(resourceName: "contact"))
    emailTxt.AddImage(#imageLiteral(resourceName: "email"))
    cityTxt.AddImage(#imageLiteral(resourceName: "locate"))
    clientCodeTxt.AddImage(#imageLiteral(resourceName: "info"))
    }
}
