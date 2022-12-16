//
//  driverOrderCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit

protocol driverOrderDelegate {
  func showDetails(orderData:Order)
  func delivering(orderData:Order)
  func delivered(orderData:Order)
  func reject(orderData:Order)
  func complaint(orderData:Order)
  func rate(orderData:Order)
  
}

class driverOrderCell: UITableViewCell {

    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var deliveredBtn: UIButton!
    @IBOutlet weak var reportBtn: UIButton!
    @IBOutlet weak var rateBtn: UIButton!

    @IBOutlet weak var statusNameLb: UILabel!

    @IBOutlet weak var orderIdLb: UILabel!
    @IBOutlet weak var orderCountLb: UILabel!
    @IBOutlet weak var orderDateLb: UILabel!
    @IBOutlet weak var orderPriceLb: UILabel!
    @IBOutlet weak var orderPayMethodLb: UILabel!
    @IBOutlet weak var orderStoreLb: UILabel!
    @IBOutlet weak var orderStoreAddressLb: UILabel!
    @IBOutlet weak var orderClientLb: UILabel!
    @IBOutlet weak var orderClientAddressLb: UILabel!
    @IBOutlet weak var orderClientMobileLb: UILabel!
    @IBOutlet weak var orderDeliveryPriceLb: UILabel!
    @IBOutlet weak var orderDriverCommissionLb: UILabel!

    @IBOutlet weak var detailsIndicatorLb: UILabel!
  @IBOutlet weak var actionsStack: UIStackView!
  var orderData:Order?
  @IBOutlet weak var bg: UIView!
  var delegate:driverOrderDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func cellConfigration(_ type:orderType,orderData:Order){
    self.orderData = orderData
    handleUI()
    bg.dropShadow(roundCorner: 17)
    orderIdLb.text = "#\(orderData.order_id!)"
    orderCountLb.text = "\(orderData.order_products!.count)"
    orderDateLb.text = orderData.order_created_at!
    orderPriceLb.text = (orderData.order_total ?? "0") + " \(Resources.Common.sar)"
    orderPayMethodLb.text = orderData.getPaymentMethod()
    orderStoreLb.text = orderData.company_name!
    statusNameLb.text = orderData.order_status!
    orderStoreAddressLb.text = orderData.company_address!
    orderClientLb.text = orderData.user_name!
    orderClientMobileLb.text = orderData.user_phone ?? ""
    orderClientAddressLb.text = orderData.order_address!
    let delivPric  = Double(orderData.order_delivary_price!) ?? 0
    let appPric  = Double(orderData.order_app_delivary_price!) ?? 0
    orderDeliveryPriceLb.text = "\(delivPric+appPric)" + " \(Resources.Common.sar)"
    orderDriverCommissionLb.text = orderData.order_delivary_price! + " \(Resources.Common.sar)"

    switch type {
    case .Waiting:
        reportBtn.isHidden = false
        acceptBtn.isHidden = false
        deliveredBtn.isHidden = true
        rejectBtn.isHidden = false
        rateBtn.isHidden = true
    case .Process:
        reportBtn.isHidden = false
        acceptBtn.isHidden = true
        deliveredBtn.isHidden = false
        rejectBtn.isHidden = true
        rateBtn.isHidden = true
    case .Delivered:
        reportBtn.isHidden = true
        acceptBtn.isHidden = true
        deliveredBtn.isHidden = true
        rejectBtn.isHidden = true
        rateBtn.isHidden = orderData.order_rate != nil
    default:
        reportBtn.isHidden = false
        acceptBtn.isHidden = false
        deliveredBtn.isHidden = true
        rejectBtn.isHidden = false
        rateBtn.isHidden = true
    }
  }
  
  func handleUI(){
  
    if LanguageManager.isArabic
    {
      detailsIndicatorLb.text = "<"
    }else {
      detailsIndicatorLb.text = ">"
    }
    
  }
  
  @IBAction func showDetailsAction(_ sender: UIButton) {
    delegate?.showDetails(orderData: orderData!)
  }
  
  @IBAction func deliveringAction(_ sender: UIButton) {
    delegate?.delivering(orderData: orderData!)
  }
  
  @IBAction func deliveredAction(_ sender: UIButton) {
    delegate?.delivered(orderData: orderData!)
  }
  
  @IBAction func rejectAction(_ sender: UIButton) {
    delegate?.reject(orderData: orderData!)
  }
  
  @IBAction func complaintAction(_ sender: UIButton) {
    delegate?.complaint(orderData: orderData!)
  }

  @IBAction func rateAction(_ sender: UIButton) {
    delegate?.rate(orderData: orderData!)
  }
  
  
  

}
