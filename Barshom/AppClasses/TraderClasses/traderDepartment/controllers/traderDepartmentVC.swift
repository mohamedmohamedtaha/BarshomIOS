//
//  traderDepartmentVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit

class traderDepartmentVC: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    handleUI()
    }
    
  func handleUI(){
    collectionView.register(UINib(nibName: traderDepartmentCell.identifier, bundle: nil), forCellWithReuseIdentifier: traderDepartmentCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self

  }


}

extension traderDepartmentVC :traderDepartmentDelegate{
  func details() {
    performSegue(withIdentifier: "details", sender: nil)
  }
  
}

extension traderDepartmentVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  private var LineSpac : CGFloat {
    return 4
  }
  
  private var cellWidth :CGFloat {
      return (collectionView.frame.width/2) - LineSpac - 10
  }
  
  private var cellHeight :CGFloat {
    return cellWidth+(cellWidth/4)
    
  }
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: traderDepartmentCell.identifier, for: indexPath) as! traderDepartmentCell
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
