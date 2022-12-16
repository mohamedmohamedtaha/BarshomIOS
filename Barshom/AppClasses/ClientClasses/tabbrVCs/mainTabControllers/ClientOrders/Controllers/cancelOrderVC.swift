//
//  cancelOrderVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/30/20.
//

import UIKit
import JVFloatLabeledTextField
protocol reloadDelegate {
    func reload()
  
}
class cancelOrderVC: UIViewController {
    @IBOutlet weak var text :JVFloatLabeledTextView!
    var orderData: Order?
    var delegate: reloadDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(orderData?.toJSON() ?? " - - ")
        text.placeholder = LanguageManager.isArabic ? "سبب الإلغاء" : "Cancel reason"
        // Do any additional setup after loading the view.
    }
    

  @IBAction func dissmissAction(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
    @IBAction func submitClicked(_ sender: UIButton) {
     
        var cancelUrl = ""
        switch UserManager.getUserData!.adv_type! {
        case "user":
          cancelUrl = Constants.APIProvider.userCancelOrder
        case "company":
            cancelUrl = Constants.APIProvider.traderCancelOrder

        case "worker":
            cancelUrl = Constants.APIProvider.driverCancelOrder
        default:
            cancelUrl = Constants.APIProvider.userCancelOrder

        }
        UserService.shared.cancelOrder(url: cancelUrl, orderId: orderData!.order_id!, orderReason: text.text!) { (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: Resources.Common.cancelOrderSuccessfuly)
            self.dismiss(animated: true, completion: nil)
            self.delegate?.reload()
        }
    }
}
