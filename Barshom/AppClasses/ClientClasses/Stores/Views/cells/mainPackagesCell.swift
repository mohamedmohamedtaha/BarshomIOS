//
//  mainPackagesCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit

enum collectionType {
  case package,product,packageProduct,traderDepartments,traderDepartmentProducts
}

class mainPackagesCell: UITableViewCell {

  @IBOutlet weak var packgeCollection: UICollectionView!
  @IBOutlet weak var heightConstraint: NSLayoutConstraint!
  
  private var LineSpac : CGFloat {
    return 4
  }
  
  private var cellWidth :CGFloat {
      return (packgeCollection.frame.width/2) - LineSpac
  }
  
  private var cellHeight :CGFloat {
    switch type {
    case .package,.traderDepartments:
      return cellWidth+(cellWidth/6)
    case .packageProduct:
      return cellWidth
    default:
      return cellWidth+(cellWidth/2)
    }
    
  }
  
  var cellSection = 0
  var type : collectionType = .package
  var cellVC :UIViewController?
  var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func cellConfigration(_ Type:collectionType){
    type = Type
    handleUI()
  }
  
  func handleUI(){
    packgeCollection.register(UINib(nibName: packageCell.identifier, bundle: nil), forCellWithReuseIdentifier: packageCell.identifier)
    packgeCollection.register(UINib(nibName: productCell.identifier, bundle: nil), forCellWithReuseIdentifier: productCell.identifier)
    packgeCollection.register(UINib(nibName: packageProductCell.identifier, bundle: nil), forCellWithReuseIdentifier: packageProductCell.identifier)
    
    packgeCollection.register(UINib(nibName: traderDepartmentCell.identifier, bundle: nil), forCellWithReuseIdentifier: traderDepartmentCell.identifier)
    packgeCollection.register(UINib(nibName: traderDepartmentProductCell.identifier, bundle: nil), forCellWithReuseIdentifier: traderDepartmentProductCell.identifier)
    
    packgeCollection.dataSource = self
    packgeCollection.delegate = self
    let layout = UICollectionViewFlowLayout()
    
    switch type {
    case .package,.traderDepartments:
      layout.scrollDirection = .horizontal
      heightConstraint.constant = cellHeight
    default:
      layout.scrollDirection = .vertical
      heightConstraint.constant = cellHeight * ((10/2)+1)
    }

    packgeCollection.collectionViewLayout = layout
    Utilities.delay(0.1) {
      self.packgeCollection.reloadData()
    }
  }
    
}

extension mainPackagesCell:productDelegate{
  func reportProduct() {
    let vc = AppStoryboard.ProductDetails.instance.instantiateViewController(withIdentifier: AppNavController.identifier) as! AppNavController
 
    self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: cellVC!, presentingViewController: vc)
    halfModalTransitioningDelegate?.screenHeight = 3
    vc.modalPresentationStyle = .custom
    vc.transitioningDelegate = self.halfModalTransitioningDelegate
    cellVC!.present(vc, animated: true, completion: nil)
  }
  
  func addToCart() {
    let vc = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: mainTabBarVC.identifier) as? mainTabBarVC
    vc?.selectedIndex = 0
    Utilities.root(vc!)
  }
  
  
}
extension mainPackagesCell:packageCellDelegate{
  func select(_ type: packagesTypes) {
    let vc = packageDetailsVC.instantiate(.packages)
    cellVC?.show(vc, sender: nil)
  }
  
 
  
}

extension mainPackagesCell:traderDepartmentProductDelegate{
  func edit() {
    let vc = addTraderProductTVC.instantiate(.traderDepartment)
    vc.type = .edit
    cellVC?.show(vc, sender: nil)
  }
  
}

extension mainPackagesCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if type == .package {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: packageCell.identifier, for: indexPath) as! packageCell
      cell.delegate = self
      cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight),Type: .unSuscriped)
      return cell
    } else if type == .packageProduct {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: packageProductCell.identifier, for: indexPath) as! packageProductCell
      cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight))
      return cell
    }else if type == .traderDepartments {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: traderDepartmentCell.identifier, for: indexPath) as! traderDepartmentCell
      cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight))
      return cell
    }else if type == .traderDepartmentProducts {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: traderDepartmentProductCell.identifier, for: indexPath) as! traderDepartmentProductCell
      cell.delegate = self
      cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight))
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCell.identifier, for: indexPath) as! productCell
      cell.delegate = self
      cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight))
      return cell
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if type != .package {
      let vc = productDetailsTVC.instantiate(.ProductDetails)
    //let vc = Constants.storyBoard.ProductDetails.instantiateViewController(withIdentifier: productDetailsTVC.identifier) as! productDetailsTVC
      cellVC!.navigationController?.show(vc, sender: nil)
      
    }
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
