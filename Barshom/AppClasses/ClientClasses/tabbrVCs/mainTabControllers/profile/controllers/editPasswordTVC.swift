//
//  editPasswordTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/6/21.
//

import UIKit

class editPasswordTVC: UITableViewController {

  @IBOutlet weak var oldPassword: RVTxtFaild!
  @IBOutlet weak var newPassword: RVTxtFaild!
  @IBOutlet weak var retypePassword: RVTxtFaild!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      oldPassword.AddImage(#imageLiteral(resourceName: "car-key"))
      newPassword.AddImage(#imageLiteral(resourceName: "car-key"))
      retypePassword.AddImage(#imageLiteral(resourceName: "car-key"))
    }
    @IBAction func loginAction(_ sender: UIButton) {
        var isValid = true
        var errorMessages: [String] = []
        if !ValidationHelper.isValidName(oldPassword.text!) {
            isValid = false
            errorMessages.append(Resources.Login.passwordRequired)
        }
        if !ValidationHelper.isValidName(newPassword.text!) {
            isValid = false
            errorMessages.append(Resources.Login.newpasswordRequired)
        }
        if !ValidationHelper.isValidName(retypePassword.text!) {
            isValid = false
            errorMessages.append(Resources.Login.newconfpasswordRequired)
        }
        if newPassword.text != retypePassword.text {
            isValid = false
            errorMessages.append(Resources.Login.passwordMismatchRequired)
        }
        if !isValid {
            AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
        } else {
            let pars = [
                "oldPassword":oldPassword.text!,
                "newPassword":newPassword.text!,
                "userType": UserManager.getUserData!.adv_type!,
                "userId":  UserManager.getUserData!.id!
            ] as! [String : Any]
            
            UserService.shared.updateUserPassword(parameters: pars) { (data) in
                AppHelper.showSuccessAlert(message: Resources.Common.profileUpdatedSuccessfuly, confirmBtnTitle: Resources.Common.ok) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
}
