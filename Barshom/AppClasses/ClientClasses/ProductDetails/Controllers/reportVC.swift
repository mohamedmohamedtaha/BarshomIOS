//
//  reportVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/27/20.
//

import UIKit
import JVFloatLabeledTextField

class reportVC: UIViewController {

    @IBOutlet weak var text :JVFloatLabeledTextView!
    var orderData: Products?
    var delegate: reloadDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(orderData?.toJSON() ?? " - - ")

        // Do any additional setup after loading the view.
    }
    

  @IBAction func dissmissAction(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
    @IBAction func submitClicked(_ sender: UIButton) {
     
        UserService.shared.reportProduct(pars: ["userId":UserManager.getUserData!.id!,"proId":orderData!.pro_id!,"reportComment":text.text!]){ (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: Resources.Common.msgSentSuccessfuly)
            self.dismiss(animated: true, completion: nil)
            self.delegate?.reload()
        }
    }
}
