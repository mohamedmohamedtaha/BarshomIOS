//
//  traderPackagesVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 29/07/2021.
//

import UIKit
import DZNEmptyDataSet


class traderPackagesVC: UIViewController {

  @IBOutlet weak var topBarBg: UIView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  @IBOutlet weak var suscripedBt: UIButton!
  @IBOutlet weak var unsuscripedBt: UIButton!
  
  var type:packagesTypes = .unSuscriped
  var uType:AppUserType = .user
    var packagesList = [TraderPackage]()

  override func viewDidLoad() {
        super.viewDidLoad()
    self.title = Resources.Common.packages
    topBarBg.dropShadow(roundCorner: 20)
    selectPackagesType(unsuscripedBt)
    collectionView.register(UINib(nibName: traderPackageCell.identifier, bundle: nil), forCellWithReuseIdentifier: traderPackageCell.identifier)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.emptyDataSetDelegate = self
    collectionView.emptyDataSetSource = self
    collectionView.semanticContentAttribute = LanguageManager.isArabic ? .forceRightToLeft : .forceLeftToRight
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    
    collectionView.collectionViewLayout = layout

    getPackages()
    }
    func getPackages()
    {
        UserService.shared.getMarketPackages(userId: UserManager.isLoggedIn ? UserManager.getUserData!.id! : "",isSub: type == .suscriped, completion: { (data) in
            self.packagesList = data
            self.handlePackages()
        })
    }
   
    func handlePackages() {
        
        self.collectionView.reloadData()
    }
  func selectPackagesType(_ bt:UIButton) {
    suscripedBt.backgroundColor = Color.unSelectPackge
    unsuscripedBt.backgroundColor = Color.unSelectPackge
    bt.backgroundColor = Color.selectPackge
  }
    
  @IBAction func suscripedAction(_ sender: UIButton) {
    type = .suscriped
    selectPackagesType(suscripedBt)
    getPackages()
  }
  
  @IBAction func unsuscripedAction(_ sender: UIButton) {
    type = .unSuscriped
    selectPackagesType(unsuscripedBt)
    getPackages()
  }
    
}

extension traderPackagesVC:traderPackageCellDelegate{
    func select(_ type: TraderPackage) {
        selectClientDetails(type)
    }
    
    
    func selectClientDetails(_ types: TraderPackage){
        if type == .unSuscriped {

            var pars = [
                "packageId": types.package_id!,
            ]
            let vc = paymentTypeActionVC.instantiate(.Cart)
            vc.isPackage = true
            vc.pars = pars
            self.show(vc, sender: nil)
      }
    }
    
    func client(_ collectionView: UICollectionView, cellForItemAt  indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: traderPackageCell.identifier, for: indexPath) as! traderPackageCell
      cell.delegate = self
        cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight),packageData: packagesList[indexPath.row],doShowSubscribe: type != .unSuscriped )
      return cell
    }
}

extension traderPackagesVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  private var LineSpac : CGFloat {
    return 4
  }
  
   var cellWidth :CGFloat {
    return (collectionView.frame.width/2) - LineSpac
  }
  
   var cellHeight :CGFloat {
    return type == .suscriped ? 180 : 200
    
  }
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return packagesList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

      return client(collectionView, cellForItemAt: indexPath)
    
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
extension traderPackagesVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return packagesList.count == 0

    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "ic_gradient_24px").maskWithColor(color: Color.mainColor!)!
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
        let text = LanguageManager.isArabic ? "لا يوجد باقات" : "No packages yet !"
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}

