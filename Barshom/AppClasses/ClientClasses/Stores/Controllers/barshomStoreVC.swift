//
//  barshomStoreVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit

class barshomStoreVC: UIViewController {

  @IBOutlet weak var sectionsCollection: UICollectionView!
  @IBOutlet weak var tableView: UITableView!
  var sectionsCollectionDataSource = sectionsCollectionView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.hideHairline()
      Utilities.addLogoTitleView(self)
      handleUI()
    }

  func handleUI(){
    sectionsCollectionDataSource.delegate = self
    sectionsCollectionDataSource.collectionConfigration(self.sectionsCollection, dataSource: getSection())
    
    //handleTableView
    tableView.register(UINib(nibName: mainPackagesCell.identifier, bundle: nil), forCellReuseIdentifier: mainPackagesCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    Utilities.delay {
      self.tableView.reloadData()
    }
    
  }

  func getSection() -> [topSection]{
    var sections  = [topSection]()
    sections.append(topSection(NSLocalizedString("All", comment: "")))
    sections.append(topSection(NSLocalizedString("Vegetables", comment: "")))
    sections.append(topSection(NSLocalizedString("Fruits", comment: "")))
    sections.append(topSection(NSLocalizedString("Grocery", comment: "")))
    sections.append(topSection(NSLocalizedString("All", comment: "")))
    sections.append(topSection(NSLocalizedString("Vegetables", comment: "")))
    sections.append(topSection(NSLocalizedString("Fruits", comment: "")))
    sections.append(topSection(NSLocalizedString("Grocery", comment: "")))
    return sections
  }
  
}

extension barshomStoreVC:sectionDelegate{
  
  func Select(_ index: IndexPath) {
    
  }
  
}

extension barshomStoreVC:UITableViewDataSource,UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: mainPackagesCell.identifier, for: indexPath) as! mainPackagesCell
    cell.cellVC = self
    cell.cellConfigration((indexPath.section == 0) ? .package:.product)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headercell = UIView()
    headercell.backgroundColor = .white
    let Lb = UILabel(frame: CGRect(x: 20, y: 0, width: Constants.ScreenWidth, height: 40))
    Lb.text = (section == 0) ? Strings.SubscriptionsPackages.Localized:Strings.Products.Localized
    Lb.font = UIFont.boldSystemFont(ofSize: 15)
    headercell.addSubview(Lb)
    let bt = UIButton(frame: CGRect(x: Constants.ScreenWidth-70, y: 0, width: 50, height: 40))
    bt.setImage(Language.currentLanguage() == "ar" ? #imageLiteral(resourceName: "backAr"):#imageLiteral(resourceName: "backEn"), for: .normal)
    bt.addTarget(self, action:  #selector(allPackages), for: .touchUpInside)
    if section == 0 {
      headercell.addSubview(bt)
    }
    return headercell
  }
  
  @objc func allPackages() {
    let vc = packagesVC.instantiate(.packages)
    //let vc = Constants.storyBoard.packages.instantiateViewController(withIdentifier: packagesVC.identifier) as! packagesVC
    self.show(vc, sender: nil)
  }

}
