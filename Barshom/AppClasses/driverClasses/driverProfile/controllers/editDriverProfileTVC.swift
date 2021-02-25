//
//  editDriverProfileTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit

class editDriverProfileTVC: UITableViewController {

  @IBOutlet weak var nameTxt: RVTxtFaild!
  @IBOutlet weak var storeTxt: RVTxtFaild!
  @IBOutlet weak var mobileTxt: RVTxtFaild!
  @IBOutlet weak var emailTxt: RVTxtFaild!
  @IBOutlet weak var cityTxt: RVTxtFaild!
  
  @IBOutlet weak var identityTXT: RVTxtFaild!
  @IBOutlet weak var carTypeTxt: RVTxtFaild!
  @IBOutlet weak var carPlateTxt: RVTxtFaild!
  
  @IBOutlet weak var bankNameTxt: RVTxtFaild!
  @IBOutlet weak var ownerNameTxt: RVTxtFaild!
  @IBOutlet weak var accountNumberTxt: RVTxtFaild!
  @IBOutlet weak var swiftCodeTxt: RVTxtFaild!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      nameTxt.AddImage(#imageLiteral(resourceName: "info"))
      storeTxt.AddImage(#imageLiteral(resourceName: "info"))
      mobileTxt.AddImage(#imageLiteral(resourceName: "contact"))
      emailTxt.AddImage(#imageLiteral(resourceName: "email"))
      cityTxt.AddImage(#imageLiteral(resourceName: "store"))
      
      identityTXT.AddImage(#imageLiteral(resourceName: "storePaper"))
      carTypeTxt.AddImage(#imageLiteral(resourceName: "car"))
      carPlateTxt.AddImage(#imageLiteral(resourceName: "car"))
    }

}
