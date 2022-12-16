//
//  loginTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/6/21.
//

import UIKit
import FirebaseMessaging
class loginTVC: UITableViewController {

    @IBOutlet weak var checkLb: UILabel!
    @IBOutlet weak var clickHereLb: UILabel!
  @IBOutlet weak var phoneTxt: RVTxtFaild!
  @IBOutlet weak var passwordTxt: RVTxtFaild!
  
  var isRemeber = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
      selectRemember()
      handleTXTUI()
    }
  
  func handleTXTUI(){
    phoneTxt.AddImage(#imageLiteral(resourceName: "contact"))
    passwordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
    let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
    let underlineAttributedString = NSAttributedString(string: LanguageManager.isArabic ? "اضغط هنا" : "Click here", attributes: underlineAttribute)
    clickHereLb.attributedText = underlineAttributedString
  }
  
  func selectRemember(){
    if isRemeber {
      checkLb.text = "✔︎"
    }else{
      checkLb.text = ""
    }
  }
  
  @IBAction func rememberAction(_ sender: UIButton) {
    isRemeber = !isRemeber
    selectRemember()
  }
  
  @IBAction func forgetPAsswordAction(_ sender: UIButton) {
    sheetPresenter.opensheetVC(self, storeyBoard: .forgertPassword, screenHeight: 2)
  }
  
  @IBAction func loginAction(_ sender: UIButton) {
    var isValid = true
    var errorMessages: [String] = []
    if !ValidationHelper.isValidName(phoneTxt.text!) {
        isValid = false
        errorMessages.append(Resources.Login.mobileRequired)
    }
    if !ValidationHelper.isValidName(passwordTxt.text!) {
        isValid = false
        errorMessages.append(Resources.Login.passwordRequired)
    }
    
    if !isValid {
        AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
    } else {
        DispatchQueue.main.asyncAfter(deadline: (.now() + 0.1)) {
            Messaging.messaging().token  { [self] (result, error) in
                        // Get called
                        print((result ?? "") + " -  -- ")
                        let parameters = [
                            "mobile": phoneTxt.text!,
                            "playerId": result ?? "",
                            "password": passwordTxt.text!]
                        UserService.shared.login(parameter: parameters) { (data,success) in
                            if success
                            {
                            LanguageManager.currentLanguage = LanguageManager.isArabic ? .ar : .en
                            self.MakeHomeRoot()
                            }
                            else
                            {
                                AppHelper.showAlertWithTextField(textplaceholder: Resources.Login.activationCode, title: Resources.Login.activate, btnTitle: Resources.Login.activate) { [self] (code) in
                                    let parms = ["mobile":phoneTxt.text!,"code":code ]
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
        
    }
  }
  
  @IBAction func closeAction(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func skipAction(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  
}
