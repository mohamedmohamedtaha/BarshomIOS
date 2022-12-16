//
//  QuickOrderVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/28/20.
//

import UIKit
import DropDown
enum quickOrderType {
  case barshoomStore,otherStores
}
class QuickOrderVC: UIViewController ,HalfModalPresentable{

  @IBOutlet weak var barshoomBg: UIView!
  @IBOutlet weak var otherStoreBg: UIView!
  
  @IBOutlet weak var barshoomImg: UIImageView!
    @IBOutlet weak var otherStoreImg: UIImageView!
    @IBOutlet weak var cityLb: UILabel!

  @IBOutlet weak var barshoomBt: UIButton!
  @IBOutlet weak var otherStoreBt: UIButton!
    var dropDown = DropDown()
    var allCities = [City]()
  var type:quickOrderType?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      type = .barshoomStore
      selectStore(bg: barshoomBg, img: barshoomImg, bt: barshoomBt)
        selectedCity = UserManager.getUserCity
        if selectedCity != nil {
            cityLb.text = LanguageManager.isArabic ? selectedCity!.city_name! : selectedCity!.city_name!

        }

        
    }
  
  func selectStore(bg:UIView,img:UIImageView,bt:UIButton){
    barshoomBg.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
    otherStoreBg.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
    barshoomBg.dropShadow(roundCorner:20)
    otherStoreBg.dropShadow(roundCorner:20)
    barshoomImg.changeTintColor(Color.mainColor!)
    otherStoreImg.changeTintColor(Color.mainColor!)
    barshoomBt.backgroundColor = Color.mainColor!
    otherStoreBt.backgroundColor = Color.mainColor!
    bg.removeShadow()
    bg.layer.borderColor = Color.tintColor?.cgColor
    img.changeTintColor(Color.tintColor!)
    bt.backgroundColor = Color.tintColor!
    
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    minimizeToSize()
  }
    
  @IBAction func otherStoreAction(_ sender: UIButton) {
    type = .otherStores
    selectStore(bg: otherStoreBg, img: otherStoreImg, bt: otherStoreBt)
  }
  
  @IBAction func barshoomAction(_ sender: UIButton) {
    type = .barshoomStore
    selectStore(bg: barshoomBg, img: barshoomImg, bt: barshoomBt)
  }
  
  @IBAction func closeAction(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
    @IBAction func cityClicked(_ sender: UIButton) {
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
            UserService.shared.getCities { (cities) in
                self.allCities = cities
                self.showDirectionsMenu(cities: self.allCities)

            }
        }
        else
        {
            self.showDirectionsMenu(cities: allCities)
        }
    }
    func showDirectionsMenu(cities : [City])
    {
        let cit = cities
        self.dropDown.dataSource = cit.map{LanguageManager.isArabic ? $0.city_name! : $0.city_name!}
        self.dropDown.selectionAction = { [self](index: Int, item: String) in
        
            selectedCity = allCities[index]
            cityLb.text = LanguageManager.isArabic ? selectedCity?.city_name! : selectedCity?.city_name!

            
        }
        self.dropDown.show()
    }
  @IBAction func complateOrderAction(_ sender: UIButton) {
    var isValid = true
    var errorMessages: [String] = []
    if selectedCity == nil {
        isValid = false
        errorMessages.append(Resources.Login.choosecity)
    }
    
//        if !ValidationHelper.isValidName(addressTxt.text!) {
//            isValid = false
//            errorMessages.append(Resources.Login.familyAddressRequired)
//        }
    

    if !isValid {
        AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
    } else {
        if selectedCity!.city_fast_order! != "1"
        {
            AppHelper.showErrorAlert(message: LanguageManager.isArabic ? "هذه المنطقة لا تقبل الطلب السريع حاليا" : "This region doesn't support fast order at the moment")

            return
        }
    isFastOrder = true
    switch type {
    case .barshoomStore:
      let vc = barshomStoreVC.instantiate(.Stores)
      self.navigationController?.show(vc, sender: nil)
      maximizeToFullScreen()
      
    case .otherStores:
      let vc = storesVC.instantiate(.Stores)
      self.navigationController?.show(vc, sender: nil)
      maximizeToFullScreen()
    default:
      break
    }
    }
    
  }
  
}
