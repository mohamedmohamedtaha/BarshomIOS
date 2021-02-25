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
  
  init(_ title:String) {
    Title = title
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
      sectionsCollection.reloadData()
    
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
    
      let collectionView = sectionsCollection!
      if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2){
          let index = IndexPath(row: 0, section: indexPath.section)
          let cell = collectionView.cellForItem(at: index)
          var offset = CGPoint()
          if Language.currentLanguage() == "ar" {
              offset = CGPoint(x: ((cell?.center.x)!)-(collectionView.frame.width)+CGFloat(sectionWidth/2) , y: 0)
          }else {
               offset = CGPoint(x: -(cell?.center.x)!+CGFloat(sectionWidth/2)  , y: 0)
          }
          collectionView.setContentOffset(offset, animated: true)
      }else if (indexPath.row == Departmets.count-1 || indexPath.row == Departmets.count-2){
          let index = IndexPath(row: Departmets.count-1, section: indexPath.section)
          let cell = collectionView.cellForItem(at: index)
          var offset = CGPoint()
          if Language.currentLanguage() == "ar" {
              let x = (-(cell?.center.x ?? CGFloat(0)))
              offset = CGPoint(x: x+CGFloat(sectionWidth/2)  , y: 0)
          }else {
               offset = CGPoint(x: ((cell?.center.x ?? CGFloat(0)))-(collectionView.frame.width)+CGFloat(sectionWidth/2) , y: 0)
          }
          collectionView.setContentOffset(offset, animated: true)
      }else{
          let cell = collectionView.cellForItem(at: indexPath)
          let offset = CGPoint(x: (cell?.center.x)! - collectionView.frame.width/2   , y: 0)
          collectionView.setContentOffset(offset, animated: true)
      }
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
