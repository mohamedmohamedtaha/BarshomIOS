//
//  bankTransferVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/1/21.
//

import UIKit
import DropDown
protocol bankTransferDelegate {
    func nameChanged(text:String)
    func holderChanged(text:String)
    func bankNameChanged(text:Bank)
    func imgsChanged(imgs :[Data])
}
class bankTransferTVC: baseTVC, imgsCollectionDelegate {

  @IBOutlet weak var imgsCollectionView: imagesCollectionView!
  @IBOutlet weak var accountHolderTxt: RVTxtFaild!
  @IBOutlet weak var accountNameTxt: RVTxtFaild!
  @IBOutlet weak var bankNameTxt: RVTxtFaild!
    var selectedBank: Bank?
    var dropDown = DropDown()
    var allCities = [Bank]()

    var bankDelegate : bankTransferDelegate?
  override func viewDidLoad() {
        super.viewDidLoad()

    imgsCollectionView.collectionConfigration(self, limit: 1)
    imgsCollectionView.dlegate = self

    }
    func reload(imgs: [Data]) {
        bankDelegate!.imgsChanged(imgs: imgs)
    }
    func imgsEmpty(imgs: [Data]) {
        bankDelegate!.imgsChanged(imgs: imgs)
    }
  @IBAction func addPhoto(_ sender: UIButton) {
    imgsCollectionView.addNewphoto()
  }
  
    @IBAction func holderChanged(_ sender: Any) {
        bankDelegate?.holderChanged(text: accountHolderTxt.text!)
    }
    @IBAction func nameChanged(_ sender: Any) {
        bankDelegate?.nameChanged(text: accountNameTxt.text!)

    }
    @IBAction func bankClicked(_ sender: Any) {
        dropDown.anchorView = sender as! UIButton
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.backgroundColor = UIColor.white
        //dropDown.cellNib = UINib(nibName: "dropdowenCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            //guard let cell = cell as? dropdowenCell else { return }
            cell.optionLabel.textAlignment = LanguageManager.isArabic ? .right : .left
            
        }
        if allCities.count == 0
        {
            UserService.shared.getBanks { (cities) in
                self.allCities = cities
                self.showDirectionsMenu(cities: self.allCities)

            }
        }
        else
        {
            self.showDirectionsMenu(cities: allCities)
        }
    }
    
    
    func showDirectionsMenu(cities : [Bank])
    {
        let cit = cities
        self.dropDown.dataSource = cit.map{$0.bank_name!}
        self.dropDown.selectionAction = { [self](index: Int, item: String) in
        
                selectedBank = allCities[index]
                bankNameTxt.text = selectedBank!.bank_name!
            bankDelegate?.bankNameChanged(text: selectedBank!)
            
        }
        self.dropDown.show()
    }
    @IBAction func checkValidation(_ sender: UIButton) {
    let validate = RVTxtFaild.validationTxts([accountHolderTxt,accountNameTxt,bankNameTxt])
    if !validate.status {
      Utilities.showAlert(self, messageToDisplay: validate.msg)
    }
  }
  
}

