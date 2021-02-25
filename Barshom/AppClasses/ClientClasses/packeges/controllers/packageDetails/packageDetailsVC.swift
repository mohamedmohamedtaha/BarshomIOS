//
//  packageDetailsVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

class packageDetailsVC: UIViewController {

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
    
    tableView.dataSource = self
    tableView.delegate = self
    Utilities.delay {
      self.tableView.reloadData()
    }
  }
  
  
  @IBAction func subscribeAction(_ sender: UIButton) {
    sheetPresenter.opensheetVC(self, storeyBoard:.editPackage, screenHeight: 6)
  }
  

}

extension packageDetailsVC:UITableViewDataSource,UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (section == 1) ? (1+2):1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier:
                                                packageDetailsCell.identifier, for: indexPath) as! packageDetailsCell
      cell.cellConfigration()
      return cell
    case 1:
      switch indexPath.row {
      case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                  appointmentsHeaderCell.identifier, for: indexPath) as! appointmentsHeaderCell
        cell.cellConfigration(Strings.appointmentsAvailable.Localized)
        return cell
      default:
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                  appointmentCell.identifier, for: indexPath) as! appointmentCell
        return cell
      }
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: mainPackagesCell.identifier, for: indexPath) as! mainPackagesCell
      cell.cellVC = self
      cell.cellConfigration(.packageProduct)
    return cell
      
    default :
      return UITableViewCell()
    }
      
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return (section == 2) ? 40:0
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headercell = UIView()
    headercell.backgroundColor = .white
    let Lb = UILabel(frame: CGRect(x: 20, y: 0, width: Constants.ScreenWidth, height: 40))
    Lb.text = Strings.ProductsInPackage.Localized
    Lb.font = UIFont.boldSystemFont(ofSize: 15)
    headercell.addSubview(Lb)
    return headercell
  }

}
