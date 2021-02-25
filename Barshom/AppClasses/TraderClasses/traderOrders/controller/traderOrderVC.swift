//
//  traderOrderVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/11/21.
//

import UIKit

enum traderOrderType {
  case new,Process,done
}

class traderOrderVC: UIViewController {

  @IBOutlet weak var tableView:UITableView!
  @IBOutlet weak var sectionsCollection: UICollectionView!
  var sectionsCollectionDataSource = sectionsCollectionView()
  
  var type:traderOrderType = .new
  
    override func viewDidLoad() {
        super.viewDidLoad()
      handleUI()
      
    }
    
  func handleUI(){
    sectionsCollectionDataSource.delegate = self
    sectionsCollectionDataSource.fromOrders = true
    sectionsCollectionDataSource.collectionConfigration(self.sectionsCollection, dataSource: getSection())
    tableView.register(UINib(nibName: traderOrderCell.identifier, bundle: nil), forCellReuseIdentifier: traderOrderCell.identifier)
  }
  
  func getSection() -> [topSection]{
    var sections  = [topSection]()
    sections.append(topSection(NSLocalizedString("New Orders", comment: "")))
    sections.append(topSection(NSLocalizedString("Under Process", comment: "")))
    sections.append(topSection(NSLocalizedString("Orders Done", comment: "")))
    return sections
  }

  @IBAction func menuAction(_ sender: UIButton) {
    sideMenu().openMenu(self,type:.trader)
  }

}

extension traderOrderVC:traderOrderDelegate{
  func showDetails() {
    let vc = clientOrderDetailsTVC.instantiate(.userOrders)
    self.show(vc, sender: nil)
  }
  
  func Accept() {
    
  }
  
  func Done() {
    
  }
  
 
  func complaint() {
    sheetPresenter.opensheetVC(self, storeyBoard: .complaint, screenHeight: 3.5)
  }
  
  func reject() {
    sheetPresenter.opensheetVC(self, storeyBoard: .removeOrder, screenHeight: 3)
  }
  
  
}

extension traderOrderVC:sectionDelegate{
  
  func Select(_ index: IndexPath) {
    switch index.row {
    case 0:
      type = .new
    case 1:
      type = .Process
    case 2:
      type = .done
    default:
      break
    }
    self.tableView.reloadData()
  }
  
}

extension traderOrderVC:UITableViewDataSource,UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: traderOrderCell.identifier, for: indexPath) as! traderOrderCell
    cell.delegate = self
    cell.cellConfigration(type)
    return cell
  }
}
