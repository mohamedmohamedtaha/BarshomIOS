//
//  complaintListVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

class complaintListVC: UIViewController {

  @IBOutlet weak var tableView:UITableView!
  @IBOutlet weak var addcomplaintBt: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()

      tableView.register(UINib(nibName: complaintCell.identifier, bundle: nil), forCellReuseIdentifier: complaintCell.identifier)
    addcomplaintBt.layer.cornerRadius = addcomplaintBt.frame.height/2
    }
    
  @IBAction func addTicekt(_ sender: UIButton) {
    sheetPresenter.opensheetVC(self, storeyBoard: .complaint, screenHeight: 2.5)
  }
  

}

extension complaintListVC:UITableViewDataSource,UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: complaintCell.identifier, for: indexPath) as! complaintCell
    cell.cellConfigration()
    return cell
  }
  
  
}
