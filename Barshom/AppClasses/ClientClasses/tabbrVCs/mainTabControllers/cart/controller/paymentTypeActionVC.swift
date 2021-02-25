//
//  paymentTypeAction.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/31/20.
//

import UIKit

enum paymentType {
  case cash,ePayment,bank
}
class paymentTypeActionVC: UIViewController {

  @IBOutlet weak var bankTransferContener: UIView!
  
  @IBOutlet weak var cashIcon: UIImageView!
  @IBOutlet weak var epaymentIcon: UIImageView!
  @IBOutlet weak var bankIcon: UIImageView!
  
  @IBOutlet weak var cashBG: UIView!
  @IBOutlet weak var epaymentBG: UIView!
  @IBOutlet weak var bankBG: UIView!
  
  @IBOutlet weak var cashSV: UIView!
  @IBOutlet weak var epaymentSV: UIView!
  @IBOutlet weak var bankSV: UIView!
  
  var roundNumber:CGFloat = 20.0
  var selectedVColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1).cgColor
  
  var type:paymentType = .cash
  
  override func viewDidLoad() {
        super.viewDidLoad()

      Utilities.addLogoTitleView(self)
      clearViewa()
    }
    
  func selectType(_ img:UIImageView,BG:UIView,SV:UIView){
    clearViewa()
    BG.layer.borderColor = Color.mainColor?.cgColor
    BG.removeShadow()
    SV.backgroundColor = Color.tintColor
    SV.layer.borderColor = UIColor.clear.cgColor
    switch type {
    case .cash:
      img.image = #imageLiteral(resourceName: "cashSelected")
    case .ePayment:
      img.image = #imageLiteral(resourceName: "epaymentSelected")
    case .bank:
      img.image = #imageLiteral(resourceName: "bankTransferSelected")
      
    }
  }
  
  func clearViewa(){
    cashIcon.image = #imageLiteral(resourceName: "cash")
    epaymentIcon.image = #imageLiteral(resourceName: "epayment")
    bankIcon.image = #imageLiteral(resourceName: "bankTransfer")
    
    cashBG.layer.borderColor = selectedVColor
    epaymentBG.layer.borderColor = selectedVColor
    bankBG.layer.borderColor = selectedVColor
    
    cashBG.dropShadow(roundCorner:roundNumber)
    epaymentBG.dropShadow(roundCorner:roundNumber)
    bankBG.dropShadow(roundCorner:roundNumber)
    
    cashSV.backgroundColor = .clear
    epaymentSV.backgroundColor = .clear
    bankSV.backgroundColor = .clear
    
    cashSV.layer.borderColor = selectedVColor
    epaymentSV.layer.borderColor = selectedVColor
    bankSV.layer.borderColor = selectedVColor
   
    bankTransferContener.isHidden = true
  }
  
  
  @IBAction func cashAction(_ sender: UIButton) {
    type = .cash
    selectType(cashIcon, BG: cashBG, SV: cashSV)
  }
  
  @IBAction func ePaymentAction(_ sender: UIButton) {
    type = .ePayment
    selectType(epaymentIcon, BG: epaymentBG, SV: epaymentSV)
  }
  
  @IBAction func bankAction(_ sender: UIButton) {
    type = .bank
    selectType(bankIcon, BG: bankBG, SV: bankSV)
    bankTransferContener.isHidden = false
  }
}
