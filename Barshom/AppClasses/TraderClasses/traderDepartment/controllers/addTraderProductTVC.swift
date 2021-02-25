//
//  addTraderProductTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit

enum traderProductActionEnum {
  case add,edit
}
class addTraderProductTVC: baseTVC {

  @IBOutlet weak var imgsCollectionView: imagesCollectionView!
  @IBOutlet weak var addBt: UIButton!
  var type:traderProductActionEnum?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      handleUI()
    }
  
  func handleUI(){
    imgsCollectionView.collectionConfigration(self, limit: 4)
    switch type {
    case .add:
      let titl = Strings.addProduct.Localized
      self.title = titl
      addBt.setTitle(titl, for: .normal)
    case .edit:
      let titl = Strings.editProduct.Localized
      self.title = titl
      addBt.setTitle(titl, for: .normal)
    default:break
    }
    Utilities.delay(0.1) {
      self.tableView.reloadData()
    }
  }
  
  
  
@IBAction func addPhoto(_ sender: UIButton) {
  imgsCollectionView.addNewphoto()
}

}
