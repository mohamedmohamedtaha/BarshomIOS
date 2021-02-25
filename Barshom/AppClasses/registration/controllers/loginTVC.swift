//
//  loginTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/6/21.
//

import UIKit

class loginTVC: UITableViewController {

  @IBOutlet weak var checkLb: UILabel!
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
    switch phoneTxt.text {
    case "user":
      let mainTab = mainTabBarVC.instantiate(.Main)
      Utilities.root(mainTab)
    case "trader":
      let nav = AppStoryboard.traderOrders.instance.instantiateViewController(withIdentifier: "traderNav")
      Utilities.root(nav)
    case "driver":
      let nav = AppStoryboard.driverOrders.instance.instantiateViewController(withIdentifier: "driverNav")
      Utilities.root(nav)
    default:
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func closeAction(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func skipAction(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  
}
