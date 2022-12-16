//
//  discountVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 31/03/2021.
//


import UIKit
import JVFloatLabeledTextField
protocol discountDelegate {
    func discountApplied(discount:Coupon?)
  
}
class discountVC: UIViewController {

    @IBOutlet weak var text :RVTxtFaild!
    var companyId: String?
    var delegate: discountDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        text.AddImage(#imageLiteral(resourceName: "conditions"))

        // Do any additional setup after loading the view.
    }
    

  @IBAction func dissmissAction(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
    @IBAction func submitClicked(_ sender: UIButton) {
     
        UserService.shared.applyDiscountCoupon(pars: ["companyId":companyId!,"couponCode":text.text!]){ (data) in
            self.dismiss(animated: true, completion: nil)
            self.delegate?.discountApplied(discount: data)
        }
    }
}
