//
//  cartVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/24/20.
//

import UIKit

class cartVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      Utilities.addLogoTitleView(self)
      tableView.register(UINib(nibName: cartCell.identifier, bundle: nil), forCellReuseIdentifier: cartCell.identifier)
      tableView.register(UINib(nibName: cartDetailsCell.identifier, bundle: nil), forCellReuseIdentifier: cartDetailsCell.identifier)
      tableView.delegate = self
      tableView.dataSource = self
    }
    
  @IBAction func menuAction(_ sender: UIButton) {
    sideMenu().openMenu(self,type:.client)
  }

}

extension cartVC :cDelegate,cartDetailsDelegate{
  func payOrder() {
    performSegue(withIdentifier: "payment", sender: nil)
  }
  
  func delete() {
    
  }
  
  func reloadData() {
    self.tableView.reloadData()
  }
  
  
}
extension cartVC:UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1+2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 2{
      let cell = tableView.dequeueReusableCell(withIdentifier: cartDetailsCell.identifier, for: indexPath) as! cartDetailsCell
      cell.delegate = self
      cell.cellConfigration()
      return cell
    }else {
    let cell = tableView.dequeueReusableCell(withIdentifier: cartCell.identifier, for: indexPath) as! cartCell
    cell.delegate = self
    cell.cellConfigration()
    return cell
    }
  }
}
