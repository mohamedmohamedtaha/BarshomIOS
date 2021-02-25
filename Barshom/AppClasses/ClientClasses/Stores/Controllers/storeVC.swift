//
//  storeVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit

class storeVC: UIViewController {

  @IBOutlet weak var sectionsCollection: UICollectionView!
  @IBOutlet weak var productCollection: UICollectionView!
  var sectionsCollectionDataSource = sectionsCollectionView()
  
  private var LineSpac : CGFloat {
    return 4
  }
  
  private var cellWidth :CGFloat {
      return (productCollection.frame.width/2) - LineSpac - 10
  }
  
  private var cellHeight :CGFloat {
    return cellWidth+(cellWidth/2)
    
  }
  //var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.hideHairline()
      Utilities.addLogoTitleView(self)
      handleUI()
    }

  func handleUI(){
    sectionsCollectionDataSource.delegate = self
    sectionsCollectionDataSource.collectionConfigration(self.sectionsCollection, dataSource: getSection())
    
    //handleTableView
    productCollection.register(UINib(nibName: productCell.identifier, bundle: nil), forCellWithReuseIdentifier: productCell.identifier)
    productCollection.dataSource = self
    productCollection.delegate = self
    Utilities.delay {
      self.productCollection.reloadData()
    }
    
  }

  func getSection() -> [topSection]{
    var sections  = [topSection]()
    sections.append(topSection(NSLocalizedString("All", comment: "")))
    sections.append(topSection(NSLocalizedString("Vegetables", comment: "")))
    sections.append(topSection(NSLocalizedString("Fruits", comment: "")))
    sections.append(topSection(NSLocalizedString("Grocery", comment: "")))
    sections.append(topSection(NSLocalizedString("All", comment: "")))
    sections.append(topSection(NSLocalizedString("Vegetables", comment: "")))
    sections.append(topSection(NSLocalizedString("Fruits", comment: "")))
    sections.append(topSection(NSLocalizedString("Grocery", comment: "")))
    return sections
  }

}

extension storeVC:sectionDelegate{
  
  func Select(_ index: IndexPath) {
    
  }
  
}

extension storeVC:productDelegate{
  func reportProduct() {
    sheetPresenter.opensheetVC(self, storeyBoard: .ProductDetails, screenHeight: 3)
//    let vc = Constants.storyBoard.ProductDetails.instantiateViewController(withIdentifier: AppNavController.identifier) as! AppNavController
//
//    self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: vc)
//    halfModalTransitioningDelegate?.screenHeight = 3
//    vc.modalPresentationStyle = .custom
//    vc.transitioningDelegate = self.halfModalTransitioningDelegate
//    self.present(vc, animated: true, completion: nil)
  }
  
  func addToCart() {
    let vc = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: mainTabBarVC.identifier) as? mainTabBarVC
    vc?.selectedIndex = 0
    Utilities.root(vc!)
  }
  
  
}
extension storeVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCell.identifier, for: indexPath) as! productCell
    cell.delegate = self
    cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight))
    return cell
   
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let x = self.storyboard!.value(forKey: "name")!
    let vc = productDetailsTVC.instantiate(.ProductDetails)
    //let vc = Constants.storyBoard.ProductDetails.instantiateViewController(withIdentifier: productDetailsTVC.identifier) as! productDetailsTVC
    self.navigationController?.show(vc, sender: nil)
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
