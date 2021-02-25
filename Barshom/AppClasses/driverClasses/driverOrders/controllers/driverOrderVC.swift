//
//  driverOrderVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit

enum driverOrderType {
  case new,Delivering,Delivered
}

class driverOrderVC: UIViewController {

  @IBOutlet weak var tableView:UITableView!
  @IBOutlet weak var sectionsCollection: UICollectionView!
  var sectionsCollectionDataSource = sectionsCollectionView()
  
  var type:driverOrderType = .new
  
    override func viewDidLoad() {
        super.viewDidLoad()
      handleUI()
      
    }
    
  func handleUI(){
    sectionsCollectionDataSource.delegate = self
    sectionsCollectionDataSource.fromOrders = true
    sectionsCollectionDataSource.collectionConfigration(self.sectionsCollection, dataSource: getSection())
    tableView.register(UINib(nibName: driverOrderCell.identifier, bundle: nil), forCellReuseIdentifier: driverOrderCell.identifier)
  }
  
  func getSection() -> [topSection]{
    var sections  = [topSection]()
    sections.append(topSection(NSLocalizedString("New Orders", comment: "")))
    sections.append(topSection(NSLocalizedString("Delivering", comment: "")))
    sections.append(topSection(NSLocalizedString("Delivered", comment: "")))
    return sections
  }

  @IBAction func menuAction(_ sender: UIButton) {
    sideMenu().openMenu(self,type:.driver)
  }

}

extension driverOrderVC:driverOrderDelegate{
  func delivering() {
    
  }
  
  func delivered() {
    
  }
  
  func rate() {
    
  }
  
  func showDetails() {
    let vc = clientOrderDetailsTVC.instantiate(.userOrders)
    self.show(vc, sender: nil)
  }
 
  func complaint() {
    sheetPresenter.opensheetVC(self, storeyBoard: .complaint, screenHeight: 3.5)
  }
  
  func reject() {
    sheetPresenter.opensheetVC(self, storeyBoard: .removeOrder, screenHeight: 3)
  }
  
  
}

extension driverOrderVC:sectionDelegate{
  
  func Select(_ index: IndexPath) {
    switch index.row {
    case 0:
      type = .new
    case 1:
      type = .Delivering
    case 2:
      type = .Delivered
    default:
      break
    }
    self.tableView.reloadData()
  }
  
}

extension driverOrderVC:UITableViewDataSource,UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: driverOrderCell.identifier, for: indexPath) as! driverOrderCell
    cell.delegate = self
    cell.cellConfigration(type)
    return cell
  }
}
