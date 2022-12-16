//
//  sectionsCollectionView.swift
//  Tabuk
//
//  Created by Mohamed Elmakkawy on 12/9/20.
//

import Foundation
import UIKit

class topSection {
  var Title:String?
  var id:String?

    init(_ title:String,id:String? = "") {
        Title = title
        self.id = id
  }
}
class sectionsCollectionView:NSObject{
  
  var selectedIndex = 0
  var sectionWidth:CGFloat = 80.0
  var sectionHeight:CGFloat = 50.0
  var fromOrders = false
  var delegate:sectionDelegate?
  public var sectionsCollection: UICollectionView!

  var Departmets = [topSection]()
  
  func collectionConfigration(_ collection:UICollectionView,dataSource:[topSection]){
    collection.semanticContentAttribute = LanguageManager.isArabic ? .forceRightToLeft : .forceLeftToRight
    collection.collectionViewLayout = ArabicCollectionFlow()
      Departmets = dataSource
      sectionsCollection = collection
      sectionsCollection.frame = collection.frame
      sectionsCollection.dataSource = self
      sectionsCollection.delegate = self
      if !fromOrders {
        sectionsCollection.backgroundColor = #colorLiteral(red: 0.5430927708, green: 0.814706938, blue: 0.401734535, alpha: 1)
      }
      sectionsCollection.register(UINib(nibName: topSectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: topSectionCell.identifier)
      sectionsCollection.dropShadow(color: .darkGray, opacity: 0.2, offSet: CGSize(width: -1, height: 2))
    if fromOrders {
      sectionWidth = (Constants.ScreenWidth / CGFloat(Departmets.count))
    }
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .horizontal
      sectionsCollection.collectionViewLayout = layout
      sectionsCollection.reloadData()
      sectionsCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)

    
  }
  

}

extension sectionsCollectionView:sectionDelegate{
  func Select(_ index: IndexPath) {
      selectedIndex = index.row
    if fromOrders {
      sectionsCollection.reloadData()
    }else {
      centerSelectedItem(index)
    }
      self.delegate!.Select(index)
  }
}

extension sectionsCollectionView:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return self.Departmets.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topSectionCell", for: indexPath) as! topSectionCell
      cell.index = indexPath
      cell.delegate = self
      cell.fromOrders = fromOrders
      cell.cellConfigration(self.Departmets[indexPath.row], index: indexPath.row,selected:selectedIndex, width: sectionWidth)
      return cell
      
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  }
  
  func centerSelectedItem(_ indexPath: IndexPath) {
    
    sectionsCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    sectionsCollection.reloadData()
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: sectionWidth, height: sectionHeight)
      
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return fromOrders ? 5:0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      
      return 0
  }
  

}
