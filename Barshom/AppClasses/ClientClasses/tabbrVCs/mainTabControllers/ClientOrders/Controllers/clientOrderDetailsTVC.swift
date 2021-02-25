//
//  clientOrderDetailsTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/30/20.
//

import UIKit

class clientOrderDetailsTVC: UITableViewController {

  @IBOutlet weak var productConstraint: NSLayoutConstraint!
  @IBOutlet weak var orderStatusLb: UILabel!
  @IBOutlet weak var productTableView: UITableView!
  var OPTable = orderProductsDataSource()
  
  var type:orderType = .Waiting
  
  override func viewDidLoad() {
        super.viewDidLoad()
      Utilities.addLogoTitleView(self)
      self.hidesBottomBarWhenPushed = true
      self.OPTable.register(self.productTableView)
      self.productTableView.dataSource = self.OPTable
      self.productTableView.delegate = self.OPTable
      self.productConstraint.constant = 2*115
      self.tableView.reloadData()
    
    switch type {
    case .Waiting:
      orderStatusLb.text = Strings.Weiting.Localized
    case .Process:
      orderStatusLb.text = Strings.beingDeliverd.Localized
    case .Delivered:
      orderStatusLb.text = Strings.Deliverd.Localized
    case .Canceld:
      orderStatusLb.textColor = .red
      orderStatusLb.text = Strings.Canceld.Localized
 
    }
    }

}

extension clientOrderDetailsTVC {
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    switch type {
    case .Process,.Canceld:
      if indexPath.row == 12 || indexPath.row == 13{
        return 0
      }
    case .Waiting:
      if indexPath.row == 13{
        return 0
      }
    case .Delivered:
      if indexPath.row == 12{
        return 0
      }
    }
    
    return UITableView.automaticDimension
  }
  
}
