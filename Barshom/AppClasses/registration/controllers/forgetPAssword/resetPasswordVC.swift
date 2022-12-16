//
//  resetPasswordVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

class resetPasswordVC: UIViewController {

    var code = ""
  @IBOutlet weak var passwordTxt: RVTxtFaild!
  @IBOutlet weak var rePasswordTxt: RVTxtFaild!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      passwordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
      rePasswordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
    }
    

    @IBAction func resetAction(_ sender: UIButton) {
        var isValid = true
        var errorMessages: [String] = []
        if !ValidationHelper.isValidName(passwordTxt.text!) {
            isValid = false
            errorMessages.append(Resources.Login.passwordRequired)
        }
        if !ValidationHelper.isValidName(rePasswordTxt.text!) {
            isValid = false
            errorMessages.append(Resources.Login.confirmpasswordRequired)
        }
        if passwordTxt.text != rePasswordTxt.text {
            isValid = false
            errorMessages.append(Resources.Login.passwordMismatchRequired)
        }
    
        if !isValid {
            AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
        } else {
            let parms = ["code":code , "password":passwordTxt.text!]
            UserService.shared.resetPassword(parameters: parms) { (datas,success) in
                if success
                {
                    AppHelper.showSuccessAlert(message: Resources.Login.passwordChangedSuccessfuly, confirmBtnTitle: Resources.Common.ok) {
                        self.navigationController?.dismiss(animated: true)
                    }
                   
                }
            }
        }
    }

}
