//
//  packageVCExtention.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import Foundation
import UIKit

extension packagesVC {
  
  func selectClientDetails(_ type: packagesTypes){
    if type == .unSuscriped {
      let vc = packageDetailsVC.instantiate(.packages)
      self.show(vc, sender: nil)
    }else {
      let vc = subscribePackageDetailsVC.instantiate(.packages)
      self.show(vc, sender: nil)
    }
  }
  
  func client(_ collectionView: UICollectionView, cellForItemAt  indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: packageCell.identifier, for: indexPath) as! packageCell
    cell.delegate = self
    cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight), Type: type)
    return cell
  }
  
}
