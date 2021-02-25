//
//  editPackageTimesVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

class editPackageTimesVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
      handleUI()
    }
  func handleUI(){
    tableView.register(UINib(nibName: appointmentsHeaderCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentsHeaderCell.identifier)
    tableView.register(UINib(nibName: appointmentCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    
    Utilities.delay(0.1) {
      self.tableView.reloadData()
    }
  }
  @IBAction func dismissAction(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  

}

extension editPackageTimesVC:UITableViewDataSource,UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: appointmentsHeaderCell.identifier, for: indexPath) as! appointmentsHeaderCell
      cell.titleLb.textColor = Color.mainColor
      cell.cellConfigration("first Week")
      return cell
    }else {
      let cell = tableView.dequeueReusableCell(withIdentifier: appointmentCell.identifier, for: indexPath) as! appointmentCell
      return cell
    }
  }
}
