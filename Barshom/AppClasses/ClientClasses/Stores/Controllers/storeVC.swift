//
//  storeVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit
import MapKit

import DZNEmptyDataSet
class storeVC: UIViewController ,MapVCDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var sectionsCollection: UICollectionView!
    @IBOutlet weak var searchTF: UITextField!
    let locationManager = CLLocationManager()

  @IBOutlet weak var productCollection: UICollectionView!
    var productList = [Products]()
    var allProductsList = [Products]()
    var categoriesList = [Category]()
    var latLng : String?
    var selectedStore : Store?
    var currentIndex : IndexPath?
    var sectionsCollectionDataSource = sectionsCollectionView()

  private var LineSpac : CGFloat {
    return 4
  }
  
  private var cellWidth :CGFloat {
      return (productCollection.frame.width/2) - LineSpac - 10
  }
  
  private var cellHeight :CGFloat {
    return 304
    
  }
  //var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.hideHairline()
        self.title = selectedStore!.adv_name!
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
      handleUI()
        getCategories()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cartUpdated),
            name: Notification.Name(rawValue: "cart"),
            object: nil)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        if let location = locations.last?.coordinate {
            
            latLng = "\(location.latitude),\(location.longitude)"
            self.locationManager.stopUpdatingLocation()
            if(self.currentIndex != nil)
            {
                Select(self.currentIndex!)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addCartBarButton(count: cartList.count)
    }
    @objc func cartUpdated(){
        addCartBarButton(count: cartList.count)
    }
  func handleUI(){
   
    //handleTableView
    productCollection.register(UINib(nibName: productCell.identifier, bundle: nil), forCellWithReuseIdentifier: productCell.identifier)
    productCollection.dataSource = self
    productCollection.delegate = self
    productCollection.emptyDataSetDelegate = self
    productCollection.emptyDataSetSource = self
    productCollection.semanticContentAttribute = LanguageManager.isArabic ? .forceRightToLeft : .forceLeftToRight
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    
    productCollection.collectionViewLayout = layout
    Utilities.delay {
      self.productCollection.reloadData()
    }
    
  }

    func getCategories()
    {
        UserService.shared.getMarketCategory(userId: selectedStore!.adv_id!) { [self] (data) in
            self.categoriesList = data
            sectionsCollectionDataSource.delegate = self
            var sections = [topSection]()
            sections.append(topSection(Resources.Common.all,id: ""))
            sections.append(contentsOf: self.categoriesList.map({ (cat) -> topSection in
                return topSection(cat.cat_name!,id: cat.cat_id!)
            }))
            sectionsCollectionDataSource.collectionConfigration(self.sectionsCollection, dataSource: sections)
            //handleTableView
            Select(IndexPath(row: 0, section: 0))

        }
    }

    @IBAction func selectLocationActionButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "SelectLocationViewController") as! SelectLocationViewController
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
    func getCoordinatesBack(lat: String, lng: String) {
        self.latLng = lat + "," + lng
        Select(currentIndex!)
        
    }
    @IBAction func searchChanged(_ sender: Any) {
        handleStoresSearch()
    }
    func handleStoresSearch()
    {
        if searchTF.text!.isEmpty {
            productList = allProductsList
        }
        else
        {
            productList = allProductsList.filter({ (store) -> Bool in
                store.pro_name!.lowercased().contains(searchTF.text!.lowercased())
            })
        }
        self.productCollection.reloadData()
    }
    
}

extension storeVC:sectionDelegate{
    func Select(_ index: IndexPath) {
        currentIndex = index
        var pars = ["userId":selectedStore!.adv_id!]
        if index.row != 0
        {
            pars.updateValue(self.categoriesList[index.row-1].cat_id!, forKey: "catId")
        }
        if latLng != nil
        {
            pars.updateValue(latLng!, forKey: "location")
        }
        else
        {
            pars.updateValue("37.421998333333335,-122.084", forKey: "location")

        }
        if selectedCity != nil {
            pars.updateValue(selectedCity!.city_id!, forKey: "cityId")
        }
        UserService.shared.getProducts(pars: pars) { [self] (data) in
            self.allProductsList = data.filter({ (prod) -> Bool in
                return prod.pro_adv_id! == selectedStore!.adv_id!
            })
            handleStoresSearch()
        }
    }
  
}
extension storeVC:productDelegate,reloadDelegate,addedCartDelegate{
    func reloadCart() {
        
    }
    func reload() {
        
    }
  func reportProduct(product:Products) {
    if !UserManager.isLoggedIn
    {
        AppHelper.showLoginAlert(vc: self)
        return
    }
    sheetPresenter.opensheetReportProductVC(self, storeyBoard: .ProductDetails,order:product,delegate:self)
  }
  
  func addToCart(product:Products) {
    if !UserManager.isLoggedIn
    {
        AppHelper.showLoginAlert(vc: self)
        return
    }
    sheetPresenter.openQuantityVC(self, storeyBoard: .ProductDetails,order:product,delegate:self)
//    let vc = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: mainTabBarVC.identifier) as? mainTabBarVC
//    vc?.selectedIndex = 0
//    Utilities.root(vc!)
  }
    func shareProduct(product:Products) {
        let textShare = [ "https://brshom.com/products/\(product.pro_id!)" ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
  
}
extension storeVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return productList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCell.identifier, for: indexPath) as! productCell
    cell.delegate = self
    cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight),productData: productList[indexPath.row])
    return cell
   
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = productDetailsTVC.instantiate(.ProductDetails)
      vc.productData = productList[indexPath.row]
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
extension storeVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return productList.count == 0

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
        let text = (LanguageManager.isArabic ? "لا يوجد منتجات" : "No products yet !")
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}
