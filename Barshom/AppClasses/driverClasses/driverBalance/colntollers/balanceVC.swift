//
//  balanceVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit

class balanceVC: UIViewController {

  @IBOutlet weak var currentBalanceBG: RSView!
  @IBOutlet weak var tableView: UITableView!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    currentBalanceBG.dropShadow(roundCorner: 20)
    handleUI()
    }
  
  func handleUI(){
    tableView.register(UINib(nibName: balanceCell.identifier, bundle: nil), forCellReuseIdentifier: balanceCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
  }
}

extension balanceVC:UITableViewDataSource,UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: balanceCell.identifier, for: indexPath) as! balanceCell
    return cell
  }
}
