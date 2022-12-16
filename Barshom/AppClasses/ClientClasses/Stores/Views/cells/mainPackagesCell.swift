//
//  mainPackagesCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit
import DZNEmptyDataSet
enum collectionType {
  case package,product,packageProduct,traderDepartments,traderDepartmentProducts
}

class mainPackagesCell: UITableViewCell {

  @IBOutlet weak var packgeCollection: UICollectionView!
  @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var productList = [Products]()
    var traderCatList = [Category]()
    var packProductList = [Package_products]()
    var packagesList = [Package]()
    var catDelegate : traderDepartmentDelegate?
    var prodDelegate : traderDepartmentProductDelegate?
    var showSubscribe = false
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
    case .traderDepartmentProducts:
        return 390
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
    packgeCollection.emptyDataSetSource = self
    packgeCollection.emptyDataSetDelegate = self
    packgeCollection.dataSource = self
    packgeCollection.delegate = self
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
//    packgeCollection.collectionViewLayout = layout
    self.packgeCollection.reloadData()

    switch type {
    case .package,.traderDepartments:
      layout.scrollDirection = .horizontal
      heightConstraint.constant = cellHeight
        packgeCollection.collectionViewLayout = layout

//        if packagesList.count > 0
//        {
//            packgeCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
//        }

    case .product,.traderDepartmentProducts:
        layout.scrollDirection = .vertical
        heightConstraint.constant = cellHeight * CGFloat(((productList.count/2)+1))
        packgeCollection.collectionViewLayout = layout
    case .packageProduct:
        layout.scrollDirection = .vertical
        heightConstraint.constant = cellHeight * CGFloat(((packProductList.count/2)+1))
        packgeCollection.collectionViewLayout = layout

    default:
      layout.scrollDirection = .vertical
      heightConstraint.constant = cellHeight * ((10/2)+1)
    }

    Utilities.delay(0.1) {
      self.packgeCollection.reloadData()
    }
  }
    
}

extension mainPackagesCell:productDelegate,reloadDelegate,addedCartDelegate{
    func reload() {
        
    }
    func reloadCart() {
        
    }
  func reportProduct(product:Products) {
    if !UserManager.isLoggedIn
    {
        AppHelper.showLoginAlert(vc: cellVC!)
        return
    }
    sheetPresenter.opensheetReportProductVC(cellVC!, storeyBoard: .ProductDetails,order:product,delegate:self)
  }
  
  func addToCart(product:Products) {
    if !UserManager.isLoggedIn
    {
        AppHelper.showLoginAlert(vc: cellVC!)
        return
    }
    sheetPresenter.openQuantityVC(cellVC!, storeyBoard: .ProductDetails,order:product,delegate:self)
//
//    let vc = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: mainTabBarVC.identifier) as? mainTabBarVC
//    vc?.selectedIndex = 0
//    Utilities.root(vc!)
  }
    
    func shareProduct(product:Products) {
        let textShare = [ "https://brshom.com/products/\(product.pro_id!)" ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.cellVC!.view
        self.cellVC!.present(activityViewController, animated: true, completion: nil)
    }
      
    
  
}
extension mainPackagesCell:packageCellDelegate{
    func select(_ type: Package) {
        if !UserManager.isLoggedIn {
            AppHelper.showLoginAlert(vc: cellVC!)
            return
        }
        if !type.isSubscribed() {
        let vc = packageDetailsVC.instantiate(.packages)
            vc.packageData = type
        cellVC!.show(vc, sender: nil)
      }else {
        let vc = subscribePackageDetailsVC.instantiate(.packages)
        vc.packageData = type
        cellVC!.show(vc, sender: nil)
      }
    }
    
}

extension mainPackagesCell:traderDepartmentProductDelegate,traderDepartmentDelegate{
    func delete(product: Products) {
        self.prodDelegate?.delete(product:product)
    }
    
    func edit(product: Products) {
        let vc = addTraderProductTVC.instantiate(.traderDepartment)
        vc.type = .edit
        vc.selectedProduct = product
        cellVC?.show(vc, sender: nil)
    }
    
    func details(cat: Category) {
        self.catDelegate?.details(cat: cat)
    }
    func delete(cat: Category) {
        self.catDelegate?.delete(cat: cat)
    }
    func share(product: Products) {
        let textShare = [ "https://brshom.com/products/\(product.pro_id!)" ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.cellVC?.view
        self.cellVC?.present(activityViewController, animated: true, completion: nil)
    }
  
}

extension mainPackagesCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if type == .product {
        return productList.count
    }
    else if type == .package
    {
        return packagesList.count
    }
    else if type == .packageProduct
    {
        return packProductList.count
    }
    else if type == .traderDepartments
    {
        return traderCatList.count
    }
    else if type == .traderDepartmentProducts {
        return productList.count
    }
    else
    {
        return 3
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if type == .package {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: packageCell.identifier, for: indexPath) as! packageCell
      cell.delegate = self
        cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight),packageData: packagesList[indexPath.row],doShowSubscribe: true)
      return cell
    } else if type == .packageProduct {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: packageProductCell.identifier, for: indexPath) as! packageProductCell
      cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight),productData:packProductList[indexPath.row])
      return cell
    }else if type == .traderDepartments {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: traderDepartmentCell.identifier, for: indexPath) as! traderDepartmentCell
        cell.delegate = self
        cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight),cat: traderCatList[indexPath.row])
      return cell
    }else if type == .traderDepartmentProducts {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: traderDepartmentProductCell.identifier, for: indexPath) as! traderDepartmentProductCell
      cell.delegate = self
        cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight),product: productList[indexPath.row])
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCell.identifier, for: indexPath) as! productCell
      cell.delegate = self
        cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight), productData: productList[indexPath.row])
      return cell
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if type == .product {
      let vc = productDetailsTVC.instantiate(.ProductDetails)
        vc.productData = productList[indexPath.row]
    //let vc = Constants.storyBoard.ProductDetails.instantiateViewController(withIdentifier: productDetailsTVC.identifier) as! productDetailsTVC
      cellVC!.navigationController?.show(vc, sender: nil)
      
    }
//    if type == .traderDepartmentProducts {
//      let vc = productDetailsTVC.instantiate(.ProductDetails)
//        vc.productData = productList[indexPath.row]
//    //let vc = Constants.storyBoard.ProductDetails.instantiateViewController(withIdentifier: productDetailsTVC.identifier) as! productDetailsTVC
//      cellVC!.navigationController?.show(vc, sender: nil)
//
//    }
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
extension mainPackagesCell: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        switch type {
        case .product,.traderDepartmentProducts:
            return productList.count == 0
        case .package:
            return packagesList.count == 0
        case .packageProduct:
            return packProductList.count == 0
        default:
            return true
        }
    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage()//#imageLiteral(resourceName: "personwhite").maskWithColor(color: Color.mainColor!)!
    }

    func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        let animation = CABasicAnimation(keyPath: "transform")

        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 0.0, 1.0))

        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT

        return animation
    }

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var text = ""
        switch type {
        case .product,.traderDepartmentProducts:
            text = LanguageManager.isArabic ? "لا يوجد منتجات" : "No products yet !"
        case .package:
            text = LanguageManager.isArabic ?  "لا يوجد باقات" : "No packages yet !"
        case .packageProduct:
            text = LanguageManager.isArabic ? "لا يوجد منتجات" : "No products yet !"
        default:
            text = LanguageManager.isArabic ? "لا يوجد بيانات" : "No data yet !"
        }
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}


