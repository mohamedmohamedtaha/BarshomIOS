//
//  driverProfileTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit

class driverProfileTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  @IBAction func editPasswordAction(_ sender: UIButton) {
    let vc = editPasswordTVC.instantiate(.Profile)
    self.show(vc, sender: nil)
  }

}
