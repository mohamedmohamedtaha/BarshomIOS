//
//  subscribePackageDetailsVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

var shiftsList = [Shifts]()
class subscribePackageDetailsVC: UIViewController{
  
  var sectionsCount = 0
  @IBOutlet weak var tableView: UITableView!
    var packageData: Package?

  override func viewDidLoad() {
        super.viewDidLoad()
    handleUI()
    }
  
  func handleUI(){
    sectionsCount = 3+packageData!.times!.count
    tableView.register(UINib(nibName: packageDetailsCell.identifier, bundle: nil), forCellReuseIdentifier: packageDetailsCell.identifier)
    tableView.register(UINib(nibName: appointmentsHeaderCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentsHeaderCell.identifier)
    tableView.register(UINib(nibName: appointmentCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentCell.identifier)
    tableView.register(UINib(nibName: mainPackagesCell.identifier, bundle: nil), forCellReuseIdentifier: mainPackagesCell.identifier)
//    tableView.register(UINib(nibName: pacakseAddressCell.identifier, bundle: nil), forCellReuseIdentifier: pacakseAddressCell.identifier)
    
    tableView.dataSource = self
    tableView.delegate = self
    UserService.shared.getShifts { (shifts) in
        shiftsList = shifts
        self.tableView.reloadData()
    }
    //handleTableView
    
    
    
  }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
 
extension subscribePackageDetailsVC:appointmentSubscripedCellDelegate {
  func addRate() {
    sheetPresenter.opensheetVC(self, storeyBoard: .rate, screenHeight: 1.8)
  }
}
extension subscribePackageDetailsVC:UITableViewDataSource,UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionsCount
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return (0)
    case 2..<sectionsCount-1:
        return (1+packageData!.times![section-2].times!.count)
    case sectionsCount-1:
        return 1
    default:
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier:
                                                packageDetailsCell.identifier, for: indexPath) as! packageDetailsCell
        cell.isSubscribed = true
        cell.cellConfigration(packageData: packageData!)
      return cell
      
//      else {
//        let cell = tableView.dequeueReusableCell(withIdentifier:
//                                                  pacakseAddressCell.identifier, for: indexPath) as! pacakseAddressCell
//        cell.cellConfigration()
//        return cell
//      }
    case 2..<sectionsCount-1:
      switch indexPath.row {
      case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                  appointmentsHeaderCell.identifier, for: indexPath) as! appointmentsHeaderCell
        cell.cellConfigration(packageData!.times![indexPath.section-2].day!)
        return cell
      default:
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                  appointmentCell.identifier, for: indexPath) as! appointmentCell
        cell.currentIndex = indexPath
        cell.showClicks = false
        cell.cellConfigration(dayModel: packageData!.times![indexPath.section-2].getWeeksList()[indexPath.row-1], packageData: packageData!.package_times![indexPath.row-1])
        return cell
      }
    case sectionsCount-1:
      let cell = tableView.dequeueReusableCell(withIdentifier: mainPackagesCell.identifier, for: indexPath) as! mainPackagesCell
      cell.cellVC = self
        cell.packProductList = packageData!.package_products!
      cell.cellConfigration(.packageProduct)
    return cell
      
    default :
      return UITableViewCell()
    }
      
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return (section == sectionsCount-1 || section == 1) ? 30:0
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 1 {
    let headercell = UIView()
    headercell.backgroundColor = .white
        let Lb = UILabel(frame: CGRect(x:LanguageManager.isArabic ? Constants.ScreenWidth-230 : 0, y: 0, width: 200, height: 30))
        Lb.text =  Resources.Common.determinedPeriods
    Lb.font = UIFont.boldSystemFont(ofSize: 15)
    headercell.addSubview(Lb)
    
    return headercell
    }
    if section == sectionsCount-1 {
      let headercell = UIView()
      headercell.backgroundColor = .white
      let Lb = UILabel(frame: CGRect(x:LanguageManager.isArabic ? Constants.ScreenWidth-240 : 0, y: 0, width: 205, height: 30))
      Lb.text =  Strings.ProductsInPackage.localized()
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
