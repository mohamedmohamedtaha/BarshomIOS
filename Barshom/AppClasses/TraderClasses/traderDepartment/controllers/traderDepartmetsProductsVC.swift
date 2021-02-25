//
//  traderDepartmetsProductsVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit

class traderDepartmetsProductsVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        handleUI()
    }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "add" {
      let vc = segue.destination as! addTraderProductTVC
      vc.type = .add
    }
  }
  func handleUI(){
   
    tableView.register(UINib(nibName: mainPackagesCell.identifier, bundle: nil), forCellReuseIdentifier: mainPackagesCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    Utilities.delay {
      self.tableView.reloadData()
    }
    
  }
  
  @IBAction func addNewProductAction(_ sender: UIButton) {
    performSegue(withIdentifier: "add", sender: nil)
  }
  
}


extension traderDepartmetsProductsVC:UITableViewDataSource,UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: mainPackagesCell.identifier, for: indexPath) as! mainPackagesCell
    cell.cellVC = self
    cell.cellConfigration((indexPath.section == 0) ? .traderDepartments:.traderDepartmentProducts)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headercell = UIView()
    headercell.backgroundColor = .white
    let Lb = UILabel(frame: CGRect(x: 20, y: 0, width: Constants.ScreenWidth, height: 40))
    Lb.text = (section == 0) ? Strings.Department.Localized:Strings.Products.Localized
    Lb.font = UIFont.boldSystemFont(ofSize: 15)
    headercell.addSubview(Lb)
    return headercell
  }
}
