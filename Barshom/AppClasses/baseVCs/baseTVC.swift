//
//  baseTVC.swift
//  3aqary
//
//  Created by Mohamed Elmakkawy on 9/13/20.
//  Copyright © 2020 mohamed elatabany. All rights reserved.
//

import UIKit

class baseTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
    }

}

extension baseTVC {
   override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
    return UITableView.automaticDimension
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
    }
    
}
