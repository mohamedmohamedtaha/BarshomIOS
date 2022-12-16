//
//  storesVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit
import MapKit

import DZNEmptyDataSet
class storesVC: UIViewController,MapVCDelegate,CLLocationManagerDelegate {
    let locationManager = CLLocationManager()

  @IBOutlet weak var collectionView: UICollectionView!
    var allStoresList = [Store]()
    var storesList = [Store]()
    var latLng : String?
    @IBOutlet weak var searchTF: UITextField!

  private var LineSpac : CGFloat {
    return 4
  }
  
  private var cellWidth :CGFloat {
//      return 50
      return (collectionView.frame.width/2) - LineSpac - 10
  }
  
  private var cellHeight :CGFloat {
    return cellWidth+(cellWidth/2)
    
  }
  func getStores()
    {
        
        
        var pars = ["":""]
     
        
        if latLng != nil
        {
            pars.updateValue(latLng!, forKey: "location")
        }
        else
        {
            pars.updateValue("24.8311,46.5683", forKey: "location")
            
        }
        if selectedCity != nil {
            pars.updateValue(selectedCity!.city_id!, forKey: "cityId")
        }

        if (UserManager.getUserData?.cat_name == "متاجر"){
            pars.updateValue("31", forKey: "adv_cat_id")
            print("adv_cat_id is add date")
        }
      print("paras paras = \(pars)")
    
      
    UserService.shared.getOtherMarkets(pars: pars) { [self] (data) in
        allStoresList = data
        handleStoresSearch()
    }
  }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        if let location = locations.last?.coordinate {
            
            latLng = "\(location.latitude),\(location.longitude)"
            self.locationManager.stopUpdatingLocation()
            getStores()
        }
    }
    func handleStoresSearch()
    {
        if searchTF.text!.isEmpty {
            storesList = allStoresList
        }
        else
        {
            storesList = allStoresList.filter({ (store) -> Bool in
                store.adv_name!.lowercased().contains(searchTF.text!.lowercased())
            })
        }
        collectionView.reloadData()
    }
  override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationItem.backBarButtonItem?.title = ""

      self.navigationController?.hideHairline()
      Utilities.addLogoTitleView(self)
      handleUI()
        getStores()
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
      
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(cartUpdated),
        name: Notification.Name(rawValue: "cart"),
        object: nil)
  }
    
    @IBAction func searchChanged(_ sender: Any) {
        handleStoresSearch()
    }
    @objc func cartUpdated(){
        addCartBarButton(count: cartList.count)
    }
    
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addCartBarButton(count: cartList.count)
    }
    
    
  func handleUI(){
    collectionView.register(UINib(nibName: storeCell.identifier, bundle: nil), forCellWithReuseIdentifier: storeCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.emptyDataSetDelegate = self
    collectionView.emptyDataSetSource = self
//    Utilities.delay(0.1) {
//      self.collectionView.reloadData()
//    }
  }
  
    @IBAction func selectLocationActionButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "SelectLocationViewController") as! SelectLocationViewController
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
    func getCoordinatesBack(lat: String, lng: String) {
        self.latLng = lat + "," + lng
        getStores()
    }

}

extension storesVC:storeDelegate{
    func selectStore(storeData: Store) {
        performSegue(withIdentifier: "storeProduct", sender: storeData)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "storeProduct"
        {
            let vc = segue.destination as! storeVC
            vc.selectedStore = sender as! Store
        }
    }
}


extension storesVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return storesList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storeCell.identifier, for: indexPath) as! storeCell
    cell.delegate = self
    cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight),storeData: storesList[indexPath.row])
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
extension storesVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return storesList.count == 0

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
        let text = (LanguageManager.isArabic ? "لا يوجد متاجر" : "No stores yet !")
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}


extension UICollectionView {
    
    
 
    
}
