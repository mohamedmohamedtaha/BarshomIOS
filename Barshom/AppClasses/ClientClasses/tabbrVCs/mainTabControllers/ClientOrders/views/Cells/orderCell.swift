//
//  orderCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/21/20.
//

import UIKit

protocol orderDelegate {
    func showDetails(orderData:Order)
  func rate(orderData:Order)
  func resend(orderData:Order)
  func complaint(orderData:Order)
  func reject(orderData:Order)
}

class orderCell: UITableViewCell {

  @IBOutlet weak var addRateConstraint: NSLayoutConstraint!
  @IBOutlet weak var resendConstraint: NSLayoutConstraint!
  @IBOutlet weak var complanConstraint: NSLayoutConstraint!
  @IBOutlet weak var rejectConstraint: NSLayoutConstraint!
    @IBOutlet weak var orderIdLb: UILabel!
    @IBOutlet weak var orderCountLb: UILabel!
    @IBOutlet weak var orderDateLb: UILabel!
    @IBOutlet weak var orderPriceLb: UILabel!
    @IBOutlet weak var orderPayMethodLb: UILabel!
    @IBOutlet weak var orderStoreLb: UILabel!

  @IBOutlet weak var statusNameLb: UILabel!
  @IBOutlet weak var detailsIndicatorLb: UILabel!
  @IBOutlet weak var actionsStack: UIStackView!
  
  @IBOutlet weak var bg: UIView!
  var delegate:orderDelegate?
  var orderData:Order?
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    func cellConfigration(_ type:orderType,orderData:Order){
        self.orderData = orderData
        orderIdLb.text = "#\(orderData.order_id!)"
        orderCountLb.text = "\(orderData.order_products!.count)"
        orderDateLb.text = orderData.order_created_at!
        orderPriceLb.text = (orderData.order_total ?? "0") + " \(Resources.Common.sar)"
        orderPayMethodLb.text = orderData.getPaymentMethod()
        orderStoreLb.text = orderData.company_name!
        statusNameLb.text = orderData.order_status!
        handleUI()
        selectType(type)
        bg.dropShadow(roundCorner: 17)
  }
  
  func handleUI(){
  
    if LanguageManager.isArabic
    {
      detailsIndicatorLb.text = "<"
    }else {
      detailsIndicatorLb.text = ">"
    }
  }
  func selectType(_ type:orderType){
    
    switch type {
      case .Waiting:
        handleSpacing(0)
        viewActions([complanConstraint,rejectConstraint])
      case .Process:
        clearSpacing()
        viewActions([complanConstraint])
      case .Delivered:
        handleSpacing(2)
        viewActions([resendConstraint,addRateConstraint])
      case .Canceld:
        clearSpacing()
        viewActions([resendConstraint])
    }
  }
  
  func handleSpacing(_ index:Int){
    clearSpacing()
    actionsStack.setCustomSpacing(5, after: actionsStack.subviews[index])
    
  }
  
  func clearSpacing(){
    actionsStack.setCustomSpacing(0, after: actionsStack.subviews[0])
    actionsStack.setCustomSpacing(0, after: actionsStack.subviews[2])
  }
  
  func viewActions(_ constraint:[NSLayoutConstraint]){
    resetActions()
    for i in constraint {
      i.constant = 80
    }
  }
  
  func resetActions(){
    addRateConstraint.constant = 0
    resendConstraint.constant = 0
    complanConstraint.constant = 0
    rejectConstraint.constant = 0
  }
  
  @IBAction func detailsAction(_ sender: UIButton) {
    delegate?.showDetails(orderData: orderData!)
  }
  
  @IBAction func rateAction(_ sender: UIButton) {
    delegate?.rate(orderData: orderData!)
  }

  @IBAction func resendAction(_ sender: UIButton) {
    delegate?.resend(orderData: orderData!)
  }
  
  @IBAction func complaintAction(_ sender: UIButton) {
    delegate?.complaint(orderData: orderData!)
  }
  
  @IBAction func rejectAction(_ sender: UIButton) {
    delegate?.reject(orderData: orderData!)
  }
  
  
}
