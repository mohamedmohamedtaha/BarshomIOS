//
//  signUpTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

class signUpTVC: UITableViewController {

  @IBOutlet weak var userName: RVTxtFaild!
  @IBOutlet weak var phoneTxt: RVTxtFaild!
  @IBOutlet weak var userCodeTxt: RVTxtFaild!
  @IBOutlet weak var passwordTxt: RVTxtFaild!
  @IBOutlet weak var retypePasswordTxt: RVTxtFaild!
  @IBOutlet weak var chackBg: UIView!
    @IBOutlet weak var clickHereLb: UILabel!

  var isAgree = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
      selectAgreeTerms()
      handleTXTUI()
    }
  
  func handleTXTUI(){
    userName.AddImage(#imageLiteral(resourceName: "info"))
    phoneTxt.AddImage(#imageLiteral(resourceName: "contact"))
    userCodeTxt.AddImage(#imageLiteral(resourceName: "info"))
    passwordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
    retypePasswordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
    let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
    let underlineAttributedString = NSAttributedString(string: LanguageManager.isArabic ? "الشروط و الأحكام" : "Terms & Conditions", attributes: underlineAttribute)
    clickHereLb.attributedText = underlineAttributedString
  }

  func selectAgreeTerms(){
    if isAgree {
      chackBg.backgroundColor = Color.tintColor
    }else{
      chackBg.backgroundColor = .white
    }
  }
  
  @IBAction func agreeTermsAction(_ sender: UIButton) {
    isAgree = !isAgree
    selectAgreeTerms()
  }
  
    @IBAction func termsClickedAction(_ sender: UIButton) {
        let vc = AppStoryboard.terms.instance.instantiateViewController(withIdentifier: "aboutVC") as! aboutVC
        vc.type = .terms
        vc.userType = "user"
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func haveAccountClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
  @IBAction func loginAction(_ sender: UIButton) {
    var isValid = true
    var errorMessages: [String] = []
    if !ValidationHelper.isValidName(userName.text!) {
        isValid = false
        errorMessages.append(Resources.Login.nameRequired)
    }
    if !ValidationHelper.isValidName(phoneTxt.text!) {
        isValid = false
        errorMessages.append(Resources.Login.mobileRequired)
    }
//    if !ValidationHelper.isValidName(userCodeTxt.text!) {
//        isValid = false
//        errorMessages.append(Resources.Login.emailOnlyRequired)
//    }
//    if !ValidationHelper.isValidEmail(userCodeTxt.text!) {
//        isValid = false
//        errorMessages.append(Resources.Login.invalidEmail)
//    }
    
    if !ValidationHelper.isValidName(passwordTxt.text!) {
        isValid = false
        errorMessages.append(Resources.Login.passwordRequired)
    }
    if !ValidationHelper.isValidName(retypePasswordTxt.text!) {
        isValid = false
        errorMessages.append(Resources.Login.confirmpasswordRequired)
    }
    if passwordTxt.text != retypePasswordTxt.text {
        isValid = false
        errorMessages.append(Resources.Login.passwordMismatchRequired)
    }
    if !isAgree {
        isValid = false
        errorMessages.append(Resources.Login.accepttermsRequired)
    }
    if !isValid {
        AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
    } else {
        var pars = [
            "name":userName.text!,
            "mobile":phoneTxt.text!,
            "yourFriendCode":userCodeTxt.text!,
            "userType":"user",
            "password":passwordTxt.text!,
        ] as! [String : Any]
        
        UserService.shared.register(parameters: pars, images: []) { (data) in
            if let x = data as? [String : Any]
            {
                let user = x["return"] as! [String : Any]
                AppHelper.showAlertWithTextField(textplaceholder: Resources.Login.activationCode, title: Resources.Login.activate, btnTitle: Resources.Login.activate) { [self] (code) in
                    let parms = ["mobile":phoneTxt.text!,"code":code]
                    UserService.shared.activate(parameters: parms) { (datas,success) in
                        if success
                        {
                            UserManager.saveUserInfo(user: datas as! [String : Any])
                            AppHelper.showSuccessAlert(message: Resources.Login.activationSuccess, confirmBtnTitle: Resources.Common.ok) {
                                self.MakeHomeRoot()
                            }
                        }
                    
                    }
                    
                }
                
            }
        }
    }
  }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
