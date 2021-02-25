//
//  subscribePackageDetailsVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

class subscribePackageDetailsVC: UIViewController{
  
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    handleUI()
    }
  
  func handleUI(){
    
    //handleTableView
    
    tableView.register(UINib(nibName: packageDetailsCell.identifier, bundle: nil), forCellReuseIdentifier: packageDetailsCell.identifier)
    tableView.register(UINib(nibName: appointmentsHeaderCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentsHeaderCell.identifier)
    tableView.register(UINib(nibName: appointmentCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentCell.identifier)
    tableView.register(UINib(nibName: mainPackagesCell.identifier, bundle: nil), forCellReuseIdentifier: mainPackagesCell.identifier)
    tableView.register(UINib(nibName: pacakseAddressCell.identifier, bundle: nil), forCellReuseIdentifier: pacakseAddressCell.identifier)
    tableView.register(UINib(nibName: appointmentSubscripedCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentSubscripedCell.identifier)
    
    tableView.dataSource = self
    tableView.delegate = self
    Utilities.delay {
      self.tableView.reloadData()
    }
  }
  

}
 
extension subscribePackageDetailsVC:appointmentSubscripedCellDelegate {
  func addRate() {
    sheetPresenter.opensheetVC(self, storeyBoard: .rate, screenHeight: 1.8)
  }
}
extension subscribePackageDetailsVC:UITableViewDataSource,UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 2
    case 1:
      return (1+2)
    case 2:
      return (1+2)
    default:
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier:
                                                packageDetailsCell.identifier, for: indexPath) as! packageDetailsCell
      cell.cellConfigration()
      return cell
      }else {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                  pacakseAddressCell.identifier, for: indexPath) as! pacakseAddressCell
        cell.cellConfigration()
        return cell
      }
    case 1,2:
      switch indexPath.row {
      case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                  appointmentsHeaderCell.identifier, for: indexPath) as! appointmentsHeaderCell
        cell.cellConfigration("First Week")
        return cell
      default:
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                  appointmentSubscripedCell.identifier, for: indexPath) as! appointmentSubscripedCell
        cell.delegate = self
        return cell
      }
    case 3:
      let cell = tableView.dequeueReusableCell(withIdentifier: mainPackagesCell.identifier, for: indexPath) as! mainPackagesCell
      cell.cellVC = self
      cell.cellConfigration(.packageProduct)
    return cell
      
    default :
      return UITableViewCell()
    }
      
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return (section == 3 || section == 1) ? 40:0
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 1 {
    let headercell = UIView()
    headercell.backgroundColor = .white
    let Lb = UILabel(frame: CGRect(x: 20, y: 0, width: Constants.ScreenWidth, height: 40))
    Lb.text =  Strings.appointmentsAvailable.Localized
    Lb.font = UIFont.boldSystemFont(ofSize: 15)
    headercell.addSubview(Lb)
    let bt = UIButton(frame: CGRect(x: Constants.ScreenWidth-80, y: 0, width: 50, height: 40))
    bt.setTitle(Strings.Edit.Localized, for: .normal)
    bt.setTitleColor(Color.mainColor, for: .normal)
    bt.addTarget(self, action:  #selector(editAction), for: .touchUpInside)
    if section == 1 {
      headercell.addSubview(bt)
    }
    return headercell
    }else if section == 3 {
      let headercell = UIView()
      headercell.backgroundColor = .white
      let Lb = UILabel(frame: CGRect(x: 20, y: 0, width: Constants.ScreenWidth, height: 40))
      Lb.text =  Strings.ProductsInPackage.Localized
      Lb.font = UIFont.boldSystemFont(ofSize: 15)
      headercell.addSubview(Lb)
      return headercell
    }
    return UIView()
  }

  @objc func editAction() {
    sheetPresenter.opensheetVC(self, storeyBoard:.editPackage, screenHeight: 6)
  }
}
