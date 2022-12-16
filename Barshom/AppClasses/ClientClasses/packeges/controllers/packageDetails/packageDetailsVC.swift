//
//  packageDetailsVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

class packageDetailsVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
    var packageData: Package?
  override func viewDidLoad() {
        super.viewDidLoad()
    UserService.shared.getShifts { (shifts) in
        shiftsList = shifts
        var times = [Package_times]()
        for tim in self.packageData!.package_times!
        {
            var time = tim
            time.morning_from = shifts[2].shift_from
            time.morning_to = shifts[2].shift_to
            
            time.mid_from = shifts[1].shift_from
            time.mid_to = shifts[1].shift_to
            
            time.night_from = shifts[0].shift_from
            time.night_to = shifts[0].shift_to
            
            times.append(time)
        }
        self.packageData!.package_times = times
        self.handleUI()
        self.tableView.reloadData()
    }
    
    }
  
  func handleUI(){
    
    //handleTableView
    
    tableView.register(UINib(nibName: packageDetailsCell.identifier, bundle: nil), forCellReuseIdentifier: packageDetailsCell.identifier)
    tableView.register(UINib(nibName: appointmentsHeaderCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentsHeaderCell.identifier)
    tableView.register(UINib(nibName: appointmentCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentCell.identifier)
    tableView.register(UINib(nibName: mainPackagesCell.identifier, bundle: nil), forCellReuseIdentifier: mainPackagesCell.identifier)
    
    tableView.dataSource = self
    tableView.delegate = self
    
  }
  
  
  @IBAction func subscribeAction(_ sender: UIButton) {
    sheetPresenter.opensheetSubPackageVC(self, storeyBoard:.editPackage,order: packageData!)
  }
  

}

extension packageDetailsVC:UITableViewDataSource,UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (section == 1) ? (1+packageData!.package_times!.count):1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier:
                                                packageDetailsCell.identifier, for: indexPath) as! packageDetailsCell
      cell.cellConfigration(packageData:packageData!)
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
        cell.showClicks = false
        cell.cellConfigration(packageData: packageData!.package_times![indexPath.row-1])
        return cell
      }
    case 2:
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
    return (section == 2) ? 30:0
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headercell = UIView()
    headercell.backgroundColor = .white
    let Lb = UILabel(frame: CGRect(x:LanguageManager.isArabic ? Constants.ScreenWidth-240 : 0, y: 0, width: 205, height: 30))
    Lb.text = Strings.ProductsInPackage.Localized
    Lb.font = UIFont.boldSystemFont(ofSize: 15)
    headercell.addSubview(Lb)
    return headercell
  }

}
