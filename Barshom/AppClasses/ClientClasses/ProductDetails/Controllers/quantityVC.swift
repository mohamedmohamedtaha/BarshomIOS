//
//  quantityVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 29/03/2021.
//



import UIKit

enum unitType : String {
  case kg = "kg"
  case box = "box"
  case unit = "unit"

 
}
protocol addedCartDelegate {
    func reloadCart()
  
}
class quantityVC: UIViewController {
  

  @IBOutlet weak var cashSV: UIView!
  @IBOutlet weak var bankSV: UIView!
    @IBOutlet weak var unitSV: UIView!

    @IBOutlet weak var pluseBt: UIButton!
    @IBOutlet weak var minusBt: UIButton!
    
    @IBOutlet weak var counterLb: UILabel!
    
    var x = 1.0
    var productData:Products?
    var delegate: addedCartDelegate?

  var roundNumber:CGFloat = 20.0
  var selectedVColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1).cgColor
  
  var type:unitType = .kg
  
  override func viewDidLoad() {
        super.viewDidLoad()

    self.title = Resources.Common.chooseUnitAndQuantity
      selectType(SV: cashSV)
      counterLb.text = "\(x)"
    }
    
  func selectType(SV:UIView){
    clearViewa()
    SV.backgroundColor = Color.tintColor
    SV.layer.borderColor = UIColor.clear.cgColor
    
  }
  
  func clearViewa(){
    
   
    
    cashSV.backgroundColor = .clear
    bankSV.backgroundColor = .clear
    unitSV.backgroundColor = .clear
    
    cashSV.layer.borderColor = selectedVColor
    bankSV.layer.borderColor = selectedVColor
      unitSV.layer.borderColor = selectedVColor

      
    
    cashSV.layer.cornerRadius = 12.5
    bankSV.layer.cornerRadius = 12.5
      unitSV.layer.cornerRadius = 12.5

  }
  
  
  @IBAction func kgAction(_ sender: UIButton) {
    type = .kg
    selectType(SV: cashSV)
    counterLb.text = "\(x)"

  }
  
  @IBAction func boxAction(_ sender: UIButton) {
    type = .box
    selectType(SV: bankSV)
    let y = x
    if y < 1
    {
        x = 1
    }
    else
    {
        x = Double(Int(y))
    }
    counterLb.text = "\(Int(x))"
  }
    
    
    @IBAction func unitAction(_ sender: UIButton) {
      type = .unit
      selectType(SV: unitSV)
      let y = x
      if y < 1
      {
          x = 1
      }
      else
      {
          x = Double(Int(y))
      }
      counterLb.text = "\(Int(x))"
    }
    
    
  
  @IBAction func plueAction(_ sender: UIButton) {
    if type ==  .box || type ==  .unit
    {
        x = Double(Int(x) + 1)
        counterLb.text = "\(Int(x))"
    }
    else
    {
        x = x + 0.25
        counterLb.text = "\(x)"
    }
    
    }
    
  @IBAction func negativeAction(_ sender: UIButton) {
    if type == .box || type ==  .unit{
        if x == 1 {
            return
        }
        x = Double(Int(x) - 1)
        counterLb.text = "\(Int(x))"

    }
    else
    {
        if x == 0.25 {
            return
        }
        x = x - 0.25
        counterLb.text = "\(x)"
    }
        
        
    }
    @IBAction func submitAction(_ sender: UIButton) {
        let unit = type.rawValue
        let quantity = type == .box || type == .unit ? Double(Int(x)) : x
        var price = ""
        if (productData!.discount_per == "" || productData!.discount_per == "0" || productData!.discount_per == nil )
        {
             if type == .box {
                 price = productData!.pro_box_price!
             }else if type == .kg{
                 price = productData!.pro_kg_price!
             }else if type == .unit{
                 price = productData!.pro_unit_price!
             }
        }
        else
        {
            
            if type == .box {
                price = productData!.pro_box_discount_price!
            }else if type == .kg{
                price = productData!.pro_kg_discount_price!
            }else if type == .unit{
                price = productData!.pro_unit_discount_price!
            }
            
        }
        var prod = OrderProducts(JSON: ["":""])!
        prod.quantity = "\(quantity)"
        prod.unit = unit
        prod.unitkey = unit
        prod.pro_name = productData!.pro_name!
        prod.pro_id = productData!.pro_id!
        prod.pro_adv_id = productData!.pro_adv_id!
        prod.pro_kg_quantity = productData!.pro_kg_quantity!
        prod.pro_box_quantity = productData!.pro_box_quantity!
        prod.pro_kg_quantity = productData!.pro_kg_quantity!
        prod.pro_box_kilos_number = productData!.pro_box_kilos_number
        prod.pro_unit_quantity = productData!.pro_unit_quantity
        prod.pro_unit_price = productData!.pro_unit_price
        prod.imageUrl = productData!.imageUrl ?? "empty"
        prod.single_price = price
        prod.q_price = Double(price)

        print(prod.toJSON())
        let isCompanyOne = isCompanyCartCount(prod: productData!)
        
        if cartList.count == 0 || isCompanyOne {
            if isHasSameProductInCart(prod: prod)
            {
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: "cart"),
                    object: nil,
                    userInfo: nil)
                self.dismiss(animated: true) {
                    AppHelper.showSuccessAlertWithoutButtons(vc: self, message: Resources.Common.addedToCart)

                }
            }
        }
        else {
            AppHelper.showInfoAlert(message: Resources.Common.invalidCartStores, confirmBtnTitle: Resources.Common.ok) {
                cartList.removeAll()
                let kgQuan = prod.pro_kg_quantity!
                let boxQuan = prod.pro_box_quantity!
                let unitQuan = prod.pro_unit_quantity!
                
                if prod.unit == "kg" {
                    let newQuan = Double(prod.quantity!)!
                    if (newQuan > Double(kgQuan)!)
                    {
                        AppHelper.showInfoAlert(message: Resources.Common.notEnoughQuant)
                        return
                    }
                }
                
                else if prod.unit == "box"{
                    let newQuan = Double(prod.quantity!)!
                    if (newQuan > Double(boxQuan)!)
                    {
                        AppHelper.showInfoAlert(message: Resources.Common.notEnoughQuant)
                        return
                    }
                }else {
                    
                    let newQuan = Double(prod.quantity!)!
                    if (newQuan > Double(unitQuan)!)
                    {
                        AppHelper.showInfoAlert(message: Resources.Common.notEnoughQuant)
                        return
                    }
                }
                
                cartList.append(prod)
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: "cart"),
                    object: nil,
                    userInfo: nil)
                self.dismiss(animated: true) {
                    AppHelper.showSuccessAlertWithoutButtons(vc: self, message: Resources.Common.addedToCart)

                }
            }
        }
      
      }
    @IBAction func cancelAction(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
      
      }
}
