//
//  storesVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit

class storesVC: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  private var LineSpac : CGFloat {
    return 4
  }
  
  private var cellWidth :CGFloat {
      return (collectionView.frame.width/2) - LineSpac - 10
  }
  
  private var cellHeight :CGFloat {
    return cellWidth+(cellWidth/2)
    
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.hideHairline()
      Utilities.addLogoTitleView(self)
      handleUI()
  }
    
  func handleUI(){
    collectionView.register(UINib(nibName: storeCell.identifier, bundle: nil), forCellWithReuseIdentifier: storeCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    Utilities.delay(0.1) {
      self.collectionView.reloadData()
    }
  }
  


}

extension storesVC:storeDelegate{
  func selectStore() {
    performSegue(withIdentifier: "storeProduct", sender: nil)
  }
  
}


extension storesVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storeCell.identifier, for: indexPath) as! storeCell
    cell.delegate = self
    cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight))
    return cell
   
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
