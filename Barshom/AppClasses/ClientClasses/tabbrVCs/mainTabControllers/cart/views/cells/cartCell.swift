//
//  cartCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/31/20.
//

import UIKit
import GMStepper

protocol cDelegate {
    func delete()
    func reloadData()
}

class cartCell: UITableViewCell {

  @IBOutlet weak var stepper: GMStepper!
  
  @IBOutlet weak var pluseBt: UIButton!
  @IBOutlet weak var minusBt: UIButton!
  
  @IBOutlet weak var counterLb: UILabel!
  
  var x = 0
  var selectedPrice:Double = 0.0
  var delegate:cDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func cellConfigration(){
      if Language.currentLanguage() == "ar" {
          pluseBt.addTarget(self, action: #selector(self.negativeAction(_:)), for: .touchUpInside)
          minusBt.addTarget(self, action: #selector(self.plueAction(_:)), for: .touchUpInside)
      }else {
          pluseBt.addTarget(self, action: #selector(self.plueAction(_:)), for: .touchUpInside)
          minusBt.addTarget(self, action: #selector(self.negativeAction(_:)), for: .touchUpInside)
      }
      
      stepper.value = 1
      counterLb.text = "\(x)"
  }
  
  
  func setPrice(_ count:Int = 1){
      
      //self.priceLb.text = "\(10)" + " " + NSLocalizedString("SAR", comment: "")
      
  }
  
  
  @objc func plueAction(_ sender: UIButton) {
      x = x + 1
      counterLb.text = "\(x)"
      setPrice(x)
      delegate!.reloadData()
  }
  
  @objc func negativeAction(_ sender: UIButton) {
      x = x - 1
      if x < 1 {
          x = 1
          return
      }
     counterLb.text = "\(x)"
      
      setPrice(x)
      delegate!.reloadData()
  }
  
  @IBAction func deleteAction(_ sender: UIButton) {
      delegate?.delete()
  }
    
}
