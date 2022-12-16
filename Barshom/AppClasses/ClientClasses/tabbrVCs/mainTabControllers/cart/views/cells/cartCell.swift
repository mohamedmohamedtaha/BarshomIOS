//
//  cartCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/31/20.
//

import UIKit
import GMStepper

protocol cDelegate {
    func delete(index:Int)
    func reloadData(index:Int , quantity:Double)
}

class cartCell: UITableViewCell {

  @IBOutlet weak var stepper: GMStepper!
  
  @IBOutlet weak var pluseBt: UIButton!
  @IBOutlet weak var minusBt: UIButton!
  
  @IBOutlet weak var counterLb: UILabel!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var catLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var totalLb: UILabel!
    @IBOutlet weak var prodIv: UIImageView!
    var x = 0.0
    var index = 0
  var selectedPrice:Double = 0.0
  var delegate:cDelegate?
  var productData:OrderProducts?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func cellConfigration(productData:OrderProducts){
        self.productData = productData
    
        x = Double(productData.quantity!)!
        stepper.value = Double(productData.quantity!) ?? 1.0
        counterLb.text = productData.quantity!
    nameLb.text = productData.pro_name!
    catLb.text = productData.getQuantity()
    priceLb.text = "\(productData.q_price ?? 0) \(Resources.Common.sar)"
        totalLb.text = "\(Double(productData.q_price ?? 0)*Double(productData.quantity!)!) \(Resources.Common.sar)"
    prodIv.sd_setImage(with: URL(string: productData.imageUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "logoWhite"))
  }
  
  
  func setPrice(_ count:Double = 1){
      //self.priceLb.text = "\(10)" + " " + NSLocalizedString("SAR", comment: "")
  }
    @IBAction func plueAction(_ sender: UIButton) {
        if productData!.unitkey! ==  "box"
        {
            x = x + 1
        }
        else
        {
            x = x + 0.25
        }
      counterLb.text = "\(x)"
      setPrice(x)
      delegate!.reloadData(index: index, quantity: x)
  }
  
  @IBAction func negativeAction(_ sender: UIButton) {
    if productData!.unitkey! ==  "box" || productData!.unitkey! == "unit"{
        if x == 1 {
            return
        }
        x = x - 1
    }
    else
    {
        if x == 0.25 {
            return
        }
        x = x - 0.25
    }
       
     counterLb.text = "\(x)"
    
    setPrice(x)
    delegate!.reloadData(index: index, quantity: x)
  }
  
  @IBAction func deleteAction(_ sender: UIButton) {
      delegate?.delete(index: index)
  }
    
}
