//
//  balanceVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit

class balanceVC: UIViewController {

    @IBOutlet weak var currentBalanceBg: RSView!
      @IBOutlet weak var balanceLb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var withdrawsList =  [WithdrawBalance]()
    override func viewDidLoad() {
          super.viewDidLoad()
      Utilities.addLogoTitleView(self)
      currentBalanceBg.dropShadow(roundCorner: 25)
      balanceLb.text = (UserManager.getUserData!.adv_balance ?? "0") + " \(Resources.Common.sar)"
        self.getRequests()
      handleUI()
      }
      func getRequests()
      {
        UserService.shared.getDriverWithdraws { (data) in
            self.withdrawsList = data
            self.tableView.reloadData()
        }
      }
    @IBAction func rechargeAction(_ sender: UIButton) {
        AppHelper.showAlertWithTextField(textplaceholder: Resources.Login.enterAmount, title: Resources.Login.withDrawRequest, btnTitle: Resources.Common.send) { [self] (code) in
            let parms = ["userId":UserManager.getUserData!.id!,"amount":code.isEmpty ? "0" : code]
            UserService.shared.addWithdrawRequest(pars: parms) { (datas) in
                    AppHelper.showSuccessAlertWithoutButtons(vc: self, message: datas["message"] as! String)
                    self.getRequests()
                            
            }
        }
//      AppHelper.showInfoAlert(message: Resources.Common.notavailable)
  //    let vc = paymentTypeActionVC.instantiate(.Cart)
  //    self.show(vc, sender: nil)
    }
    

  func handleUI(){
    tableView.register(UINib(nibName: balanceCell.identifier, bundle: nil), forCellReuseIdentifier: balanceCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
  }
}

extension balanceVC:UITableViewDataSource,UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return withdrawsList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: balanceCell.identifier, for: indexPath) as! balanceCell
    cell.configureCell(model: withdrawsList[indexPath.row])
    return cell
  }
}
