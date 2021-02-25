//
//  notificationVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/31/20.
//

import UIKit

class notificationVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    tableView.register(UINib(nibName: notificationCell.identifier, bundle: nil), forCellReuseIdentifier: notificationCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    }
    
  @IBAction func menuAction(_ sender: UIButton) {
    sideMenu().openMenu(self,type:.client)
  }

}

extension notificationVC :UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueCell(notificationCell.self, for: indexPath)
    return cell
  }
}
