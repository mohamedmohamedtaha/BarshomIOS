//
//  addDepartmentTVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 08/04/2021.
//

import UIKit
import DropDown
import SDWebImage

class addDepartmentTVC: baseTVC, imgsCollectionDelegate {
    func reload(imgs: [Data]) {
        selectedImg = imgs
    }
    
    func imgsEmpty(imgs: [Data]) {
        imgsCollectionView.reloadData()
    }
    

  @IBOutlet weak var imgsCollectionView: imagesCollectionView!
    @IBOutlet weak var addBt: UIButton!
    @IBOutlet weak var nameTxt: RVTxtFaild!
    
    var selectedImg = [Data]()
    
    var type:traderProductActionEnum = .add
    var selectedProduct : Category?
    override func viewDidLoad() {
        super.viewDidLoad()
      handleUI()
    }
  
  func handleUI(){
    imgsCollectionView.dlegate = self
    switch type {
    case .add:
        let titl = Resources.Common.addCategory
      self.title = titl
        imgsCollectionView.collectionConfigration(self, limit: 1)

      addBt.setTitle(titl, for: .normal)
    case .edit:
        let titl = Resources.Common.editCategory
      self.title = titl
        self.nameTxt.text = selectedProduct!.cat_name!
        
        let img = UIImageView()
        img.sd_setImage(with: URL(string: selectedProduct!.image ?? "empty")) { (img, error, cache, url) in
            if img != nil
            {
                let imgData = img!.jpeg(.highest)!
                self.imgsCollectionView.imgsData.append(imgData)
                let imgc = imageClass()
                imgc.img = img!
                imgc.url = ""
                self.selectedImg = [imgData]
                self.imgsCollectionView.imgs.append(imgc)
                self.imgsCollectionView.selectedPhotos.append(img!)
                self.imgsCollectionView.collectionConfigration(self, limit: 1)
                self.imgsCollectionView.reloadCollection()
            }
        }

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
    @IBAction func addProductClicked(_ sender: UIButton) {
        var isValid = true
        var errorMessages: [String] = []
        var pars = ["":""]
        if !ValidationHelper.isValidName(nameTxt.text!) {
            isValid = false
            errorMessages.append(Resources.Common.required(fieldName: Resources.Common.categoryName))
        }
        
        if selectedImg.count == 0 {
            isValid = false
            errorMessages.append(Resources.Common.required(fieldName: Resources.Common.addImages))
        }
        if !isValid {
            AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
            return
        }
        pars.updateValue(UserManager.getUserData!.id!, forKey: "userId")
        pars.updateValue(nameTxt.text!, forKey: "catName")
        
        if type == .edit {
            pars.updateValue(selectedProduct!.cat_id!, forKey: "catId")

        }
        let selectedAttach = Attachment()
        selectedAttach.data = selectedImg[0]
        selectedAttach.name = "imageData"
        selectedAttach.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
        selectedAttach.mimeType = "image/jpeg"
        UserService.shared.addEditCategory(isAdd: type == .add , parameters: pars, image: selectedAttach) { (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)
            self.delay(time: 2) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
