//
//  resetCodeVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 28/03/2021.
//


import UIKit

class resetCodeVC: UIViewController {

  @IBOutlet weak var codeTxt: RVTxtFaild!
    var mobile = ""
    override func viewDidLoad() {
        super.viewDidLoad()

      codeTxt.AddImage(#imageLiteral(resourceName: "conditions"))
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  @IBAction func resetAction(_ sender: UIButton) {
      var isValid = true
      var errorMessages: [String] = []
      if !ValidationHelper.isValidName(codeTxt.text!) {
          isValid = false
          errorMessages.append(Resources.Common.required(fieldName: Resources.Login.activationCode))
      }
      
      if !isValid {
          AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
      } else {
          let parms = ["code":codeTxt.text!]
          UserService.shared.checkForgotPassword(parameters: parms) { (datas,success) in
              if success
              {
                
                  self.performSegue(withIdentifier: "reset", sender: nil)
                
              }
          }
      }
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reset"
        {
            let vc = segue.destination as! resetPasswordVC
            vc.code = codeTxt.text!
        }
    }
    @IBAction func helpAction(_ sender: UIButton) {
        let packages = contactUsTVC.instantiate(.contactUs)
          self.navigationController?.isNavigationBarHidden = false
        self.show(packages, sender: nil)
    }
    @IBAction func resendAction(_ sender: UIButton) {
        let parms = ["mobile":mobile]
        UserService.shared.forgetPassword(parameters: parms) { (datas,success) in
            if success
            {
                AppHelper.showSuccessAlert(message: Resources.Login.codeSentSuccess, confirmBtnTitle: Resources.Common.ok) {
                    
                }
            }
        }
    }
  
}
