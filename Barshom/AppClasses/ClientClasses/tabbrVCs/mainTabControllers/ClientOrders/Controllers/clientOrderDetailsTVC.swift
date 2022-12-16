//
//  clientOrderDetailsTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/30/20.
//

import UIKit

class clientOrderDetailsTVC: UITableViewController {

  @IBOutlet weak var productConstraint: NSLayoutConstraint!
    @IBOutlet weak var orderStatusLb: UILabel!
    @IBOutlet weak var orderIdLb: UILabel!
    @IBOutlet weak var orderDateLb: UILabel!
    @IBOutlet weak var orderTimeLb: UILabel!
    @IBOutlet weak var orderCountLb: UILabel!
    @IBOutlet weak var orderPaymentLb: UILabel!
    @IBOutlet weak var orderAddressLb: UILabel!
    @IBOutlet weak var orderTotalLb: UILabel!
    @IBOutlet weak var orderDeliveryPriceLb: UILabel!
    @IBOutlet weak var orderVATPriceLb: UILabel!
    @IBOutlet weak var orderTypeLb: UILabel!
    @IBOutlet weak var orderCodeLb: UILabel!
  @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var inDeliveryBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var deliveredBtn: UIButton!
    @IBOutlet weak var reOrderBtn: UIButton!
    @IBOutlet weak var rateBtn: UIButton!

    @IBOutlet weak var traderAcceptBtn: UIButton!
    @IBOutlet weak var traderRejectBtn: UIButton!
    @IBOutlet weak var traderFinishBtn: UIButton!
    
    @IBOutlet weak var driverLocationBtn: UIButton!

    
    
  var OPTable = orderProductsDataSource()
    var orderData: Order?
  var type:orderType = .Waiting
  
  override func viewDidLoad() {
        super.viewDidLoad()
      Utilities.addLogoTitleView(self)
      self.hidesBottomBarWhenPushed = true
    self.handleData()
    UserService.shared.getOrderDetails(orderId: orderData!.order_id!) { order in
        self.orderData = order
        self.handleData()
    }
    
    }

    func handleData()
    {
        self.OPTable.productsList = orderData!.order_products!
        self.OPTable.register(self.productTableView)
        self.productTableView.dataSource = self.OPTable
        self.productTableView.delegate = self.OPTable
      self.productConstraint.constant = CGFloat(orderData!.order_products!.count*115)
        self.tableView.reloadData()
      
      switch type {
      case .Waiting:
          inDeliveryBtn.isHidden = false
          rejectBtn.isHidden = false
          deliveredBtn.isHidden = true
          orderStatusLb.text = Resources.Common.pending
          rateBtn.isHidden = true
          reOrderBtn.isHidden = true
          traderAcceptBtn.isHidden = false
          traderRejectBtn.isHidden = false
          traderFinishBtn.isHidden = true

      case .Process:
          inDeliveryBtn.isHidden = true
          rejectBtn.isHidden = true
          deliveredBtn.isHidden = false
          orderStatusLb.text = Resources.Common.inDelivery
          rateBtn.isHidden = true
          reOrderBtn.isHidden = true
          traderAcceptBtn.isHidden = true
          traderRejectBtn.isHidden = true
          traderFinishBtn.isHidden = false
      case .Delivered:
          inDeliveryBtn.isHidden = true
          rejectBtn.isHidden = true
          deliveredBtn.isHidden = true
          traderAcceptBtn.isHidden = true
          traderRejectBtn.isHidden = true
          traderFinishBtn.isHidden = true
          rateBtn.isHidden = false
          reOrderBtn.isHidden = false
          orderStatusLb.text = Resources.Common.delivered
      case .Canceld:
        orderStatusLb.textColor = .red
        orderStatusLb.text = Resources.Common.cancelled
          rateBtn.isHidden = true
          reOrderBtn.isHidden = false
   
      }
      orderIdLb.text = "#\(orderData!.order_id!)"
      orderDateLb.text = orderData!.order_created_at!
      orderTimeLb.text = orderData!.order_delivery_time!
      orderCountLb.text = "\(orderData!.order_products!.count)"
      orderPaymentLb.text = orderData!.getPaymentMethod()
      orderAddressLb.text = orderData!.order_address!
      orderTotalLb.text = (orderData!.order_total ?? "0")  + " \(Resources.Common.sar)"
      orderVATPriceLb.text = (orderData!.order_vat_amount ?? "0")  + " \(Resources.Common.sar)"
        
      orderDeliveryPriceLb.text = "\(orderData!.getTotalDeliveryPrice()) \(Resources.Common.sar)"
      orderTypeLb.text = orderData!.getOrderType()
      orderCodeLb.text = orderData!.order_code!
      driverLocationBtn.setTitle(Resources.Common.mapLocation, for: .normal)

    }
    @IBAction func driverRejectClicked(_ sender: UIButton) {
        sheetPresenter.opensheetCancelOrderVC(self, storeyBoard: .removeOrder, order:orderData!,delegate: self)

    }
    @IBAction func driverInDeliveryClicked(_ sender: UIButton) {
        UserService.shared.cancelOrder(url: Constants.APIProvider.driverInDeliveryOrder, orderId: orderData!.order_id!, orderReason: "") { (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)
            self.delay(time: 2) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    @IBAction func driverDeliveredClicked(_ sender: UIButton) {
        UserService.shared.cancelOrder(url: Constants.APIProvider.driverDeliveredOrder, orderId: orderData!.order_id!, orderReason: "") { (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)
            self.delay(time: 2) {
                self.navigationController?.popViewController(animated: true)
            }        }
    }
    @IBAction func cancelClicked(_ sender: UIButton) {
        sheetPresenter.opensheetCancelOrderVC(self, storeyBoard: .removeOrder, order:orderData!, delegate: self)

    }
    @IBAction func reorderClicked(_ sender: UIButton) {
        cartList.removeAll()
        for i in orderData!.order_products!
        {
            var prod = OrderProducts(JSON: ["":""])!
            prod.quantity = i.quantity
            prod.unit = i.unit
            prod.unitkey = i.unit
            prod.pro_name = i.pro_name!
            prod.pro_id = i.pro_id!
            prod.pro_adv_id = i.pro_adv_id!
            prod.pro_kg_quantity = i.pro_kg_quantity!
            prod.pro_box_quantity = i.pro_box_quantity!
            prod.pro_kg_quantity = i.pro_kg_quantity!
            prod.pro_box_kilos_number = i.pro_box_kilos_number
            prod.imageUrl = i.imageUrl!
            prod.single_price = i.single_price ?? "0"
            prod.q_price = i.q_price
            cartList.append(prod)
        }
//        if orderData!.order_location != "" {
//            selectedAddress = Address(JSON: ["" : ""])!
//            selectedAddress!.address = orderData!.order_address!
//            selectedAddress!.lat = "\(orderData!.order_location!.split(separator: ",")[0])"
//            selectedAddress!.lng = "\(orderData!.order_location!.split(separator: ",")[1])"
//        }
       
        isFastOrder = orderData!.order_type! == "fast"
        Notify.post(.selectIndex,object:0)
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func userLocationClicked(_ sender: UIButton) {
        let lat = "\(orderData!.order_location?.split(separator: ",")[0] ?? "0.0")"
        let lng = "\(orderData!.order_location?.split(separator: ",")[1] ?? "0.0")"
        let url = "http://maps.google.com/maps?saddr=&daddr=\(lat),\(lng)"
        UIApplication.shared.open(URL(string:url.replacingOccurrences(of: " ", with: ""))!)
    }
    @IBAction func rateClicked(_ sender: UIButton) {
        sheetPresenter.opensheetRateVC(self, storeyBoard:.rate, order:orderData!)

    }
    @IBAction func orderBillClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:orderData!.invoice_order!.replacingOccurrences(of: " ", with: ""))!)

    }
    @IBAction func traderAcceptClicked(_ sender: UIButton) {
        UserService.shared.cancelOrder(url: Constants.APIProvider.traderAcceptOrder, orderId: orderData!.order_id!, orderReason: "") { (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)
            self.delay(time: 2) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    @IBAction func traderRejectClicked(_ sender: UIButton) {
        UserService.shared.cancelOrder(url: Constants.APIProvider.traderCancelOrder, orderId: orderData!.order_id!, orderReason: "") { (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)
            self.delay(time: 2) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    @IBAction func traderFinishClicked(_ sender: UIButton) {
        UserService.shared.cancelOrder(url: Constants.APIProvider.traderFinishOrder, orderId: orderData!.order_id!, orderReason: "") { (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)
            self.delay(time: 2) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension clientOrderDetailsTVC : reloadDelegate {
  
    func reload() {
        self.navigationController?.popViewController(animated: true)
    }
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    
    if indexPath.row == 8
    {
        return orderData?.order_vat_amount == "" || orderData?.order_vat_amount == "0" ? 0 : UITableView.automaticDimension
    }
    if indexPath.row == 14
    {
        if UserManager.getUserData!.adv_type == "user"
        {
            return 0
        }
    }
    switch type {
    case .Process,.Canceld:
        if UserManager.getUserData!.adv_type == "user"
        {
          if indexPath.row == 16  || indexPath.row == 18 || indexPath.row == 19{
            return 0
          }
        }
        else if UserManager.getUserData!.adv_type == "worker"
        {
            if indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 19{
              return 0
            }
        }
        else if UserManager.getUserData!.adv_type == "company"
        {
            if indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 18{
              return 0
            }
        }
    case .Waiting:
        if UserManager.getUserData!.adv_type == "user"
        {
          if indexPath.row == 17 || indexPath.row == 18 || indexPath.row == 19{
            return 0
          }
        }
        else if UserManager.getUserData!.adv_type == "worker"
        {
            if indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 19{
              return 0
            }
        }
        else if UserManager.getUserData!.adv_type == "company"
        {
            if indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 18{
              return 0
            }
        }
    case .Delivered:
        if UserManager.getUserData!.adv_type == "user"
        {
            if indexPath.row == 16 || indexPath.row == 18 || indexPath.row == 19{
              return 0
            }
        }
        else if UserManager.getUserData!.adv_type == "worker"
        {
            if indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 18 || indexPath.row == 19{
              return 0
            }
        }
        else if UserManager.getUserData!.adv_type == "company"
        {
            if indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 18 || indexPath.row == 19{
              return 0
            }
        }
      
    }
    
    return UITableView.automaticDimension
  }
  
}
