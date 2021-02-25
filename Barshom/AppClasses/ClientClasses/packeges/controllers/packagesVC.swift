//
//  packagesVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/28/20.
//

import UIKit

enum packagesTypes {
  case suscriped,unSuscriped
}


class packagesVC: UIViewController {

  @IBOutlet weak var topBarBg: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  @IBOutlet weak var suscripedBt: UIButton!
  @IBOutlet weak var unsuscripedBt: UIButton!
  
  var type:packagesTypes = .unSuscriped
  var uType:AppUserType = .user
  
  override func viewDidLoad() {
        super.viewDidLoad()
    topBarBg.dropShadow(roundCorner: 20)
    selectPackagesType(unsuscripedBt)
    handleUI()
    }
    
  func handleUI(){
    collectionView.register(UINib(nibName: packageCell.identifier, bundle: nil), forCellWithReuseIdentifier: packageCell.identifier)
    collectionView.register(UINib(nibName: traderPackageCell.identifier, bundle: nil), forCellWithReuseIdentifier: traderPackageCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    Utilities.delay(0.1) {
      self.collectionView.reloadData()
    }
  }
  
  func selectPackagesType(_ bt:UIButton) {
    suscripedBt.backgroundColor = Color.unSelectPackge
    unsuscripedBt.backgroundColor = Color.unSelectPackge
    bt.backgroundColor = Color.selectPackge
    collectionView.reloadData()
  }

  @IBAction func suscripedAction(_ sender: UIButton) {
    type = .suscriped
    selectPackagesType(suscripedBt)
  }
  
  @IBAction func unsuscripedAction(_ sender: UIButton) {
    type = .unSuscriped
    selectPackagesType(unsuscripedBt)
  }

}

extension packagesVC:packageCellDelegate{
  func select(_ type: packagesTypes) {
    if uType == .user {
      selectClientDetails(type)
    }else if uType == .trader {
      selectTraderDetails(type)
    }
  }
  
  
}

extension packagesVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  private var LineSpac : CGFloat {
    return 4
  }
  
   var cellWidth :CGFloat {
      return (collectionView.frame.width/2) - LineSpac - 10
  }
  
   var cellHeight :CGFloat {
    return cellWidth+(cellWidth/4)
    
  }
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    if uType == .user {
      return client(collectionView, cellForItemAt: indexPath)
    }else if uType == .trader {
      return trader(collectionView, cellForItemAt: indexPath)
    }
   return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
   
    return CGSize(width: cellWidth , height: cellHeight)
      
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return  LineSpac
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      
      return 0
  }
  
  
}
