//
//  complaintVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/30/20.
//

import UIKit
import JVFloatLabeledTextField

class complaintVC: UIViewController {
    @IBOutlet weak var titleLb :UITextField!
    @IBOutlet weak var numberLb :UITextField!
    @IBOutlet weak var text :JVFloatLabeledTextView!
    var orderData: Order?
    var delegate: reloadDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if orderData != nil
        {
            numberLb.isUserInteractionEnabled = false
            numberLb.text = orderData!.order_id!
        }
    }
    

  @IBAction func dissmissAction(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
    @IBAction func submitAction(_ sender: UIButton) {
        UserService.shared.sendComplaint(pars: ["userId":UserManager.getUserData!.id,"bellNumber":numberLb.text!,"consaltationTitle":titleLb.text!,"consaltationBody":text.text!]) { (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: Resources.Common.msgSentSuccessfuly)
            self.delegate?.reload()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
  
}
