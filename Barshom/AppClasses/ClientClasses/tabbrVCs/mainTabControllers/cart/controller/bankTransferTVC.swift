//
//  bankTransferVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/1/21.
//

import UIKit

class bankTransferTVC: baseTVC {

  @IBOutlet weak var imgsCollectionView: imagesCollectionView!
  
  @IBOutlet weak var accountHolderTxt: RVTxtFaild!
  @IBOutlet weak var accountNameTxt: RVTxtFaild!
  @IBOutlet weak var bankNameTxt: RVTxtFaild!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    imgsCollectionView.collectionConfigration(self, limit: 1)

    }
    
  @IBAction func addPhoto(_ sender: UIButton) {
    imgsCollectionView.addNewphoto()
  }
  
  @IBAction func checkValidation(_ sender: UIButton) {
    let validate = RVTxtFaild.validationTxts([accountHolderTxt,accountNameTxt,bankNameTxt])
    if !validate.status {
      Utilities.showAlert(self, messageToDisplay: validate.msg)
    }
  }
  
}

