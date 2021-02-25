//
//  CleintOrderVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/21/20.
//

import UIKit

enum orderType {
  case Waiting,Process,Delivered,Canceld
}

class CleintOrderVC: UIViewController {
  
  @IBOutlet weak var tableView:UITableView!
  @IBOutlet weak var sectionsCollection: UICollectionView!
  var sectionsCollectionDataSource = sectionsCollectionView()
  
  var type:orderType = .Waiting
  
    override func viewDidLoad() {
        super.viewDidLoad()
      handleUI()
      Utilities.addLogoTitleView(self)
    }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "details" {
      let vc = segue.destination as! clientOrderDetailsTVC
      vc.type = type
    }
  }
  func handleUI(){
    sectionsCollectionDataSource.delegate = self
    sectionsCollectionDataSource.fromOrders = true
    sectionsCollectionDataSource.collectionConfigration(self.sectionsCollection, dataSource: getSection())
    tableView.register(UINib(nibName: orderCell.identifier, bundle: nil), forCellReuseIdentifier: orderCell.identifier)
  }
  
  func getSection() -> [topSection]{
    var sections  = [topSection]()
    sections.append(topSection(NSLocalizedString("Waiting", comment: "")))
    sections.append(topSection(NSLocalizedString("being delivered", comment: "")))
    sections.append(topSection(NSLocalizedString("Delivered", comment: "")))
    sections.append(topSection(NSLocalizedString("Canceld", comment: "")))
    return sections
  }
  
  @IBAction func cartAction(_ sender: UIButton) {
    self.tabBarController?.selectedIndex = 0
  }
  
  @IBAction func menuAction(_ sender: UIButton) {
    sideMenu().openMenu(self,type:.client)
  }
  
}

extension CleintOrderVC:sectionDelegate{
  
  func Select(_ index: IndexPath) {
    switch index.row {
    case 0:
      type = .Waiting
    case 1:
      type = .Process
    case 2:
      type = .Delivered
    case 3:
      type = .Canceld
    default:
      break
    }
    self.tableView.reloadData()
  }
  
}

extension CleintOrderVC:orderDelegate{
  func rate() {
    sheetPresenter.opensheetVC(self, storeyBoard:.rate, screenHeight: 2)
  }
  
  func resend() {
    self.tabBarController?.selectedIndex = 0
  }
  
  func complaint() {
    sheetPresenter.opensheetVC(self, storeyBoard: .complaint, screenHeight: 3.5)
  }
  
  func reject() {
    sheetPresenter.opensheetVC(self, storeyBoard: .removeOrder, screenHeight: 3)
  }
  
  func showDetails() {
   performSegue(withIdentifier: "details", sender: nil)
  }
}

extension CleintOrderVC:UITableViewDataSource,UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: orderCell.identifier, for: indexPath) as! orderCell
    cell.delegate = self
    cell.cellConfigration(type)
    return cell
  }
}
