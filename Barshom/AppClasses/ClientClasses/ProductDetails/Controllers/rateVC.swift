//
//  rateVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/27/20.
//

import UIKit
import Cosmos
import JVFloatLabeledTextField
class rateVC: UIViewController {

    @IBOutlet weak var rateView :CosmosView!
    @IBOutlet weak var rateText :JVFloatLabeledTextView!
    var isProduct = true
    var productId = "0"
    var orderData: Order?
    override func viewDidLoad() {
        super.viewDidLoad()

        print(orderData?.toJSON() ?? " - - ")
        rateText.placeholder = LanguageManager.isArabic ? "أضف ملاحظتك" : "Your review"

        // Do any additional setup after loading the view.
    }
    

  @IBAction func closeAction(_ sender: UIButton) {
   
    dismiss(animated: true, completion: nil)
  }
  
    @IBAction func submitClicked(_ sender: UIButton) {
        if isProduct {
            UserService.shared.rateProduct(pars: ["userId":UserManager.getUserData!.id!,"rateComment":rateText.text!,"rateValue":"\(rateView.rating)","proId":productId]) { (data) in
                AppHelper.showSuccessAlertWithoutButtons(vc: self, message: Resources.Common.rateSentSuccessfuly)
                self.dismiss(animated: true, completion: nil)
            }
        }
        else
        {
            UserService.shared.rateOrder(pars: ["userId":UserManager.getUserData!.id!,"rateComment":rateText.text!,"rateValue":"\(rateView.rating)","orderId":orderData!.order_id!]) { (data) in
                AppHelper.showSuccessAlertWithoutButtons(vc: self, message: Resources.Common.rateSentSuccessfuly)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
