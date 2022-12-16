//
//  barshomStoreVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit
import MapKit
class barshomStoreVC: UIViewController,MapVCDelegate,CLLocationManagerDelegate{

  @IBOutlet weak var sectionsCollection: UICollectionView!
  @IBOutlet weak var tableView: UITableView!
  var sectionsCollectionDataSource = sectionsCollectionView()
    var categoriesList = [Category]()
    var allProductsList = [Products]()
    var productsList = [Products]()
    var packagesList = [Package]()
    var latLng : String?
    var currentIndex : IndexPath?
    @IBOutlet weak var searchTF: UITextField!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.hideHairline()
        self.navigationItem.backBarButtonItem?.title = ""

      Utilities.addLogoTitleView(self)
        tableView.register(UINib(nibName: mainPackagesCell.identifier, bundle: nil), forCellReuseIdentifier: mainPackagesCell.identifier)
      getPackages()
      getCategories()
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
    func getPackages()
    {
        UserService.shared.getUserPackages(userId: "", completion: { (data) in
            self.packagesList = data
            
            self.tableView.reloadData()
        })
    }
    func getCategories()
    {
        UserService.shared.getMarketCategory(userId: "2") { [self] (data) in
            self.categoriesList = data
            sectionsCollectionDataSource.delegate = self
            var sections = [topSection]()
            sections.append(topSection(Resources.Common.all,id: ""))
            sections.append(contentsOf: self.categoriesList.map({ (cat) -> topSection in
                return topSection(LanguageManager.isArabic ? cat.cat_name! : cat.cat_nameEn!,id: cat.cat_id!)
            }))
            sectionsCollectionDataSource.collectionConfigration(self.sectionsCollection, dataSource: sections)
            //handleTableView
            tableView.dataSource = self
            tableView.delegate = self
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
            productsList = allProductsList
        }
        else
        {
            productsList = allProductsList.filter({ (store) -> Bool in
                store.pro_name!.lowercased().contains(searchTF.text!.lowercased())
            })
        }
        self.tableView.reloadData()
    }
}

extension barshomStoreVC:sectionDelegate{
    func Select(_ index: IndexPath) {
        currentIndex = index
        var pars = ["userId":"2"]
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
            self.allProductsList = data
            handleStoresSearch()
        }
    }
  
}

extension barshomStoreVC:UITableViewDataSource,UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: mainPackagesCell.identifier, for: indexPath) as! mainPackagesCell
    cell.cellVC = self
      cell.showSubscribe = true
    cell.packagesList = self.packagesList
    cell.productList = self.productsList
    cell.cellConfigration((indexPath.section == 0) ? .package:.product)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headercell = UIView()
    
    headercell.backgroundColor = .white
    let Lb = UILabel(frame: CGRect(x: LanguageManager.isArabic ? Constants.ScreenWidth-220 : 20, y: 0, width: 200, height: 40))
    Lb.text = (section == 0) ? Strings.SubscriptionsPackages.localized():Strings.Products.localized()
    Lb.font = UIFont.boldSystemFont(ofSize: 15)
    headercell.addSubview(Lb)
    let bt = UIButton(frame: CGRect(x: LanguageManager.isArabic ? 10 : Constants.ScreenWidth-100, y: 0, width: 90, height: 40))
    bt.setTitleColor(UIColor.black, for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

    bt.setTitle(Strings.NewSubscribtion.localized(), for: .normal)
    bt.addTarget(self, action:  #selector(allPackages), for: .touchUpInside)
    if section == 0 {
      headercell.addSubview(bt)
    }
    return headercell
  }
  
  @objc func allPackages() {
    if !UserManager.isLoggedIn
    {
        AppHelper.showLoginAlert(vc: self)
        return
    }
    let vc = packagesVC.instantiate(.packages)
    //let vc = Constants.storyBoard.packages.instantiateViewController(withIdentifier: packagesVC.identifier) as! packagesVC
    self.show(vc, sender: nil)
  }

}
