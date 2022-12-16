//
//  traderOrderCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/11/21.
//

import UIKit
import Cosmos
protocol traderOrderDelegate {
  func showDetails(orderData:Order)
  func Accept(orderData:Order)
  func reject(orderData:Order)
  func complaint(orderData:Order)
  func Done(orderData:Order)
  
}

class traderOrderCell: UITableViewCell {

  @IBOutlet weak var detailsIndicatorLb: UILabel!
  @IBOutlet weak var actionsStack: UIStackView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var deliveredBtn: UIButton!
    @IBOutlet weak var reportBtn: UIButton!

    @IBOutlet weak var statusNameLb: UILabel!

    @IBOutlet weak var orderIdLb: UILabel!
    @IBOutlet weak var orderCountLb: UILabel!
    @IBOutlet weak var orderDateLb: UILabel!
    @IBOutlet weak var orderPriceLb: UILabel!
    @IBOutlet weak var orderPayMethodLb: UILabel!
    @IBOutlet weak var orderStoreLb: UILabel!
    @IBOutlet weak var orderClientPhoneLb: UILabel!
    
  @IBOutlet weak var bg: UIView!
  var delegate:traderOrderDelegate?
  var orderData:Order?
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
    orderStoreLb.text = orderData.user_name!
    orderClientPhoneLb.text = orderData.user_phone ?? ""
    statusNameLb.text = orderData.order_status!
    if type == .Delivered && orderData.order_rate != nil
    {
        rateView.rating = Double(orderData.order_rate!.rate_number ?? "0")!
        rateView.isHidden = false
    }
    else
    {
        rateView.isHidden = true
    }
    switch type {
    case .Waiting:
        reportBtn.isHidden = false
        acceptBtn.isHidden = false
        deliveredBtn.isHidden = true
        rejectBtn.isHidden = false
    case .Process:
        reportBtn.isHidden = false
        acceptBtn.isHidden = true
        deliveredBtn.isHidden = false
        rejectBtn.isHidden = true
    case .Delivered:
        reportBtn.isHidden = true
        acceptBtn.isHidden = true
        deliveredBtn.isHidden = true
        rejectBtn.isHidden = true
        
    default:
        reportBtn.isHidden = false
        acceptBtn.isHidden = false
        deliveredBtn.isHidden = true
        rejectBtn.isHidden = false
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
  
  @IBAction func detailsAction(_ sender: UIButton) {
    delegate?.showDetails(orderData: orderData!)
  }
  
  @IBAction func acceptAction(_ sender: UIButton) {
    delegate?.Accept(orderData: orderData!)
  }
  
  @IBAction func rejectAction(_ sender: UIButton) {
    delegate?.reject(orderData: orderData!)
  }
  
  @IBAction func complaintAction(_ sender: UIButton) {
    delegate?.complaint(orderData: orderData!)
  }

  @IBAction func doneAction(_ sender: UIButton) {
    delegate?.Done(orderData: orderData!)
  }
  
  
  
  

    
}
