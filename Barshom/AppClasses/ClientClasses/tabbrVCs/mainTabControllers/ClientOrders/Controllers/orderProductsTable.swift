//
//  orderProductsTable.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/30/20.
//

import Foundation
import UIKit

class orderProductsDataSource: NSObject , UITableViewDataSource, UITableViewDelegate {
    var productsList = [OrderProducts]()
  func register(_ tableView: UITableView) {
    tableView.register(UINib(nibName: productInOrderDetailsCell.identifier, bundle: nil), forCellReuseIdentifier: productInOrderDetailsCell.identifier)
  }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: productInOrderDetailsCell.identifier, for: indexPath) as! productInOrderDetailsCell
        cell.cellConfigration(productData: productsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
