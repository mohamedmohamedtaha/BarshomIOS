//
//  ratesVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/27/20.
//

import UIKit

class ratesVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      hadleUI()
    }
  
  
  func hadleUI(){
    tableView.register(UINib(nibName: rateCell.identifier, bundle: nil), forCellReuseIdentifier: rateCell.identifier)
    tableView.dataSource = self
    Utilities.delay(0.1) {
      self.tableView.reloadData()
    }
  }
  
  @IBAction func addRateAction(_ sender: UIButton) {
    sheetPresenter.opensheetVC(self, storeyBoard: .rate, screenHeight: 1.8)
  }

}

extension ratesVC:UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: rateCell.identifier, for: indexPath) as! rateCell
    cell.celllConfigration()
    return cell
  }
}
