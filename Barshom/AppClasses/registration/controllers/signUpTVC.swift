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
  
  @IBAction func loginAction(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}
