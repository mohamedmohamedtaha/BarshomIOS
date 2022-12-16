//
//  traderPackageVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import Foundation
import UIKit

extension packagesVC{
  
  func selectTraderDetails(_ type: Package){
    if !type.isSubscribed() {
      let vc = paymentTypeActionVC.instantiate(.Cart)
      self.show(vc, sender: nil)
    }
  }
  
  func trader(_ collectionView: UICollectionView, cellForItemAt  indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: traderPackageCell.identifier, for: indexPath) as! traderPackageCell
//    cell.delegate = self
//    cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight), packageData: packagesList[indexPath.row])
    return cell
  }
  
  
}
