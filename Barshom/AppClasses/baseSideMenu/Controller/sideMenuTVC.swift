//
//  sideMenuTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/25/20.
//

import UIKit

class sideMenuTVC: baseTVC {

   var sideMenuView = sideMenu()
   var type :MenuType = .trader
  
    override func viewDidLoad() {
        super.viewDidLoad()
      handleTableUI()
      tableView.contentInset.top = -UIApplication.shared.statusBarFrame.height
      Notify.listen(self, name: .menuType, selector: #selector(changeMenuType(notification:)))
    }
  
  @objc func changeMenuType(notification:Notification)  {
      self.type = (notification.object as! MenuType)
      self.tableView.reloadData()
    
  }
  
  func handleTableUI(){
    tableView.register(UINib(nibName: menuCell.identifier, bundle: nil), forCellReuseIdentifier: menuCell.identifier)
    tableView.register(UINib(nibName: menuHeaderCell.identifier, bundle: nil), forCellReuseIdentifier: menuHeaderCell.identifier)
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sideMenuView.getMenu(type).count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: menuCell.identifier, for: indexPath) as! menuCell
    cell.cellConfigration(sideMenuView.getMenu(type)[indexPath.row])
    return cell
  }

  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    sideMenuView.select(self, index: indexPath)
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let cell = tableView.dequeueReusableCell(withIdentifier: menuHeaderCell.identifier) as! menuHeaderCell
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 110+UIApplication.shared.statusBarFrame.height
  }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if type == .trader{
            
            if indexPath.row == 2{
                if UserManager.getUserData?.cat_name == "متاجر"{
                    return UITableView.automaticDimension
                }else {
                    return 0
                }
            }
            
//            if sideMenuView.getMenu(type)[indexPath.row].title == "Holesale market" ||  sideMenuView.getMenu(type)[indexPath.row].title == "سوق الجملة"{
//                if UserManager.getUserData?.cat_name == "متاجر"{
//                    return UITableView.automaticDimension
//                }else {
//                    return 0
//                }
//            }
        }
        
        return UITableView.automaticDimension

    }
}
