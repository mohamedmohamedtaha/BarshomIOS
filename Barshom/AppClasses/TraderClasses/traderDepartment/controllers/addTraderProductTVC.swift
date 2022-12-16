//
//  addTraderProductTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit
import DropDown
import SDWebImage
enum traderProductActionEnum {
  case add,edit
}
class addTraderProductTVC: baseTVC, imgsCollectionDelegate {
    func reload(imgs: [Data]) {
        selectedImg = imgs
    }
    
    func imgsEmpty(imgs: [Data]) {
        imgsCollectionView.reloadData()
    }
    

  @IBOutlet weak var imgsCollectionView: imagesCollectionView!
    @IBOutlet weak var addBt: UIButton!
    @IBOutlet weak var nameTxt: RVTxtFaild!
    @IBOutlet weak var descTxt: RVTxtFaild!
    @IBOutlet weak var catTxt: RVTxtFaild!
    @IBOutlet weak var quantityKgTxt: RVTxtFaild!
    @IBOutlet weak var quantityBoxTxt: RVTxtFaild!
    @IBOutlet weak var priceKgTxt: RVTxtFaild!
    @IBOutlet weak var priceBoxTxt: RVTxtFaild!
    @IBOutlet weak var discPriceKgTxt: RVTxtFaild!
    @IBOutlet weak var discPriceBoxTxt: RVTxtFaild!
    @IBOutlet weak var numberKgInBoxTxt: RVTxtFaild!
    @IBOutlet weak var quantityOfUnit: RVTxtFaild!
    @IBOutlet weak var priceOfUnit: RVTxtFaild!
    @IBOutlet weak var discountPriceOfUnit: RVTxtFaild!
    
    

    var selectedImg = [Data]()
    var dropDown = DropDown()
    var allCities = [Category]()
    var selectedCity : Category?
  var type:traderProductActionEnum?
    var selectedProduct : Products?
    override func viewDidLoad() {
        super.viewDidLoad()
      handleUI()
    }
  
  func handleUI(){
    imgsCollectionView.dlegate = self
    switch type {
    case .add:
        let titl = Resources.Common.addProduct
      self.title = titl
        imgsCollectionView.collectionConfigration(self, limit: 1)

      addBt.setTitle(titl, for: .normal)
    case .edit:
        let titl = Resources.Common.editProduct
      self.title = titl
        self.nameTxt.text = selectedProduct!.pro_name!
        self.catTxt.text = selectedProduct!.cat_name!
        self.descTxt.text = selectedProduct!.pro_details!
        self.priceKgTxt.text = selectedProduct!.pro_kg_price!
        self.priceBoxTxt.text = selectedProduct!.pro_box_price!
        self.discPriceKgTxt.text = selectedProduct!.pro_kg_discount_price!
        self.discPriceBoxTxt.text = selectedProduct!.pro_box_discount_price!
        self.quantityKgTxt.text = selectedProduct!.pro_kg_quantity!
        self.quantityBoxTxt.text = selectedProduct!.pro_box_quantity!
        self.numberKgInBoxTxt.text = selectedProduct!.pro_box_kilos_number!
        self.quantityOfUnit.text = selectedProduct!.pro_unit_quantity!
        self.priceOfUnit.text = selectedProduct!.pro_unit_price!
        self.discountPriceOfUnit.text = selectedProduct!.pro_unit_discount_price
        
        
        selectedCity = Category(JSON: ["" : ""])!
        selectedCity!.cat_id = selectedProduct!.pro_cat_id!
        selectedCity!.cat_name = selectedProduct!.cat_name!
        let img = UIImageView()
        img.sd_setImage(with: URL(string: selectedProduct!.imageUrl ?? "empty")) { (img, error, cache, url) in
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
    @IBAction func catClicked(_ sender: UIButton) {
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.backgroundColor = UIColor.white
        //dropDown.cellNib = UINib(nibName: "dropdowenCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            //guard let cell = cell as? dropdowenCell else { return }
            cell.optionLabel.textAlignment = LanguageManager.isArabic ? .right : .left
            
        }
        if allCities.count == 0
        {
            UserService.shared.getMarketCategory(userId: UserManager.getUserData!.id!) { (dat) in
                self.allCities = dat
                self.showDirectionsMenu(cities: self.allCities)
            }
        
        }
        else
        {
            self.showDirectionsMenu(cities: allCities)
        }
    }
    func showDirectionsMenu(cities : [Category])
    {
        let cit = cities
        self.dropDown.dataSource = cit.map{$0.cat_name!}
        self.dropDown.selectionAction = { [self](index: Int, item: String) in
        
                selectedCity = allCities[index]
                catTxt.text = item

            
        }
        self.dropDown.show()
    }
    @IBAction func addProductClicked(_ sender: UIButton) {
        var isValid = true
        var errorMessages: [String] = []
        var pars = ["":""]
        if !ValidationHelper.isValidName(nameTxt.text!) {
            isValid = false
            errorMessages.append(Resources.Common.required(fieldName: Resources.Common.productName))
        }
        if !ValidationHelper.isValidName(descTxt.text!) {
            isValid = false
            errorMessages.append(Resources.Common.required(fieldName: Resources.Common.producDesc))
        }
        if selectedCity == nil {
            isValid = false
            errorMessages.append(Resources.Common.required(fieldName: Resources.Common.prodCategory))
        }
        if !ValidationHelper.isValidName(quantityKgTxt.text!) {
            isValid = false
            errorMessages.append(Resources.Common.required(fieldName: Resources.Common.productQuanKG))
        }
        if !ValidationHelper.isValidName(priceKgTxt.text!) {
            isValid = false
            errorMessages.append(Resources.Common.required(fieldName: Resources.Common.productPriceKG))
        }
        // for unit
        if !ValidationHelper.isValidName(quantityOfUnit.text!) {
            isValid = false
            errorMessages.append(Resources.Common.required(fieldName: Resources.Common.productQuanUnit))
        }
        if !ValidationHelper.isValidName(priceOfUnit.text!) {
            isValid = false
            errorMessages.append(Resources.Common.required(fieldName: Resources.Common.productPriceUnit))
        }
        if !ValidationHelper.isValidName(discountPriceOfUnit.text!) {
            isValid = false
            errorMessages.append(Resources.Common.required(fieldName: Resources.Common.unitDiscPriceBox))
        }
        
        // for unit

        
        
//        @IBOutlet weak var quantityOfUnit: RVTxtFaild!
//        @IBOutlet weak var priceOfUnit: RVTxtFaild!
//        @IBOutlet weak var discountPriceOfUnit: RVTxtFaild!
//
        
        if discPriceKgTxt.text! != "" && priceKgTxt.text! != "" {
            if (Double(discPriceKgTxt.text!) ?? 0) > (Double(priceKgTxt.text!) ?? 0)   {
                isValid = false
                errorMessages.append(Resources.Common.required(fieldName: Resources.Common.invalidDiscPriceKG))
            }
            
        }
        if discPriceBoxTxt.text! != "" && priceBoxTxt.text! != "" {
            if (Double(discPriceBoxTxt.text!) ?? 0) > (Double(priceBoxTxt.text!) ?? 0)   {
                isValid = false
                errorMessages.append(Resources.Common.required(fieldName: Resources.Common.invalidDiscPriceBox))
            }
            
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
        pars.updateValue(nameTxt.text!, forKey: "proName")
        pars.updateValue(descTxt.text!, forKey: "proDetails")
        pars.updateValue(quantityKgTxt.text!, forKey: "numberOfKilos")
        pars.updateValue(quantityBoxTxt.text!, forKey: "numberOfBoxs")
        pars.updateValue(quantityOfUnit.text!, forKey: "numberOfUnit")

        pars.updateValue(priceKgTxt.text!, forKey: "priceOfKilo")
        pars.updateValue(priceBoxTxt.text!, forKey: "priceOfBox")
        pars.updateValue(priceOfUnit.text!, forKey: "priceOfUnit")

        pars.updateValue(discPriceKgTxt.text!, forKey: "priceOfKiloDiscount")
        pars.updateValue(discPriceBoxTxt.text!, forKey: "priceOfBoxDiscount")
        pars.updateValue(discountPriceOfUnit.text!, forKey: "priceOfUnitDiscount")

        pars.updateValue(numberKgInBoxTxt.text!, forKey: "boxKilos")
        pars.updateValue(selectedCity!.cat_id!, forKey: "catId")
        if type == .edit {
            pars.updateValue(selectedProduct!.pro_id!, forKey: "proId")

        }
        print("parmeter parmeter = \(pars)")
        let selectedAttach = Attachment()
        selectedAttach.data = selectedImg[0]
        selectedAttach.name = "imageData"
        selectedAttach.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
        selectedAttach.mimeType = "image/jpeg"
        UserService.shared.addEditProduct(isAdd: type == .add , parameters: pars, image: selectedAttach) { (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)
            self.delay(time: 2) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
