//
//  driverOrderVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit
import DZNEmptyDataSet

class driverOrderVC: UIViewController, reloadDelegate {

    var allOrders = GroupOrders(JSON: ["":""])
    var selectedOrder =  [Order]()
    @IBOutlet weak var receiveOrdersSC: UISegmentedControl!

  @IBOutlet weak var tableView:UITableView!
  @IBOutlet weak var sectionsCollection: UICollectionView!
  var sectionsCollectionDataSource = sectionsCollectionView()
    var currentIndex = 0

    var type:orderType = .Waiting
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Resources.Common.myOrders
      handleUI()
        updateUserToken()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserOrders()
    }
  func handleUI(){
    sectionsCollectionDataSource.delegate = self
    sectionsCollectionDataSource.fromOrders = true
    sectionsCollectionDataSource.collectionConfigration(self.sectionsCollection, dataSource: getSection())
    tableView.register(UINib(nibName: driverOrderCell.identifier, bundle: nil), forCellReuseIdentifier: driverOrderCell.identifier)
    tableView.emptyDataSetSource = self
    tableView.emptyDataSetDelegate = self
    receiveOrdersSC.selectedSegmentIndex = UserManager.getUserData!.adv_order ?? 1
    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    let titleTextAttributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.black]
    receiveOrdersSC.setTitleTextAttributes(titleTextAttributesNormal, for: .normal)
    receiveOrdersSC.setTitleTextAttributes(titleTextAttributes, for: .selected)
    receiveOrdersSC.setTitle(Resources.Common.receiveOn, forSegmentAt: 0)
    receiveOrdersSC.setTitle(Resources.Common.receiveOff, forSegmentAt: 1)

    let attributes = [NSAttributedString.Key.font: (LanguageManager.isArabic) ? UIFont(name: AppFontName.ArMedium, size: 13)!:UIFont(name: AppFontName.ArMedium, size: 13)!,NSAttributedString.Key.foregroundColor:UIColor.black]
    let attributesSelected = [NSAttributedString.Key.font: (LanguageManager.isArabic) ? UIFont(name: AppFontName.ArMedium, size: 13)!:UIFont(name: AppFontName.ArMedium, size: 13)!,NSAttributedString.Key.foregroundColor:UIColor.white]
    receiveOrdersSC.setTitleTextAttributes(attributes, for: .normal)
    receiveOrdersSC.setTitleTextAttributes(attributesSelected, for: .selected)
    

  }
  
  func getSection() -> [topSection]{
    var sections  = [topSection]()
    sections.append(topSection(Resources.Common.newOrders))
    sections.append(topSection(Resources.Common.inDelivery))
    sections.append(topSection(Resources.Common.delivered))
    return sections
  }
    func getUserOrders()
    {
        var status  = "wait";
        switch (currentIndex)
        {
        case 0:
            status  = "wait";
            break;
        case 1:
            status  = "active";
            break;
        case 2:
            status  = "done";
            break;
        default:
            status  = "wait";
            break;
        }
        UserService.shared.getUserOrders(status: status) { [self] (dat) in
            self.allOrders = dat
            handleOrderType()
        }
    }
    func handleOrderType()
    {
        switch currentIndex {
        case 0:
            selectedOrder = allOrders!.wait
        case 1:
            selectedOrder = allOrders!.active
        case 2:
            selectedOrder = allOrders!.done
    
        default:
            break
        }
        self.tableView.reloadData()
    }
    @IBAction func indexChanged(_ sender: Any) {
        UserService.shared.changeReceiveOrders(status: "\(receiveOrdersSC.selectedSegmentIndex == 0 ? "1" : "0")") { (data) in
            var user = UserManager.getUserData!
            user.adv_order = self.receiveOrdersSC.selectedSegmentIndex
            UserManager.saveUserInfo(user: user.toJSON())
            AppHelper.showSuccessAlert(message: (data as! [String: Any])["message"] as! String, confirmBtnTitle: Resources.Common.ok) {
            }
        }
    }
  @IBAction func menuAction(_ sender: UIButton) {
    sideMenu().openMenu(self,type:.driver)
  }

}

extension driverOrderVC:driverOrderDelegate{
  func delivering(orderData: Order) {
    UserService.shared.cancelOrder(url: Constants.APIProvider.driverInDeliveryOrder, orderId: orderData.order_id!, orderReason: "") { (data) in
        AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)
        self.getUserOrders()
    }
  }
  
  func delivered(orderData: Order) {
    UserService.shared.cancelOrder(url: Constants.APIProvider.driverDeliveredOrder, orderId: orderData.order_id!, orderReason: "") { (data) in
        AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)
        self.getUserOrders()
    }
  }
  
  func rate(orderData: Order) {
    
  }
  
  func showDetails(orderData: Order) {
    let vc = clientOrderDetailsTVC.instantiate(.userOrders)
    vc.type = type
      vc.orderData = orderData
    self.show(vc, sender: nil)
  }
 
  func complaint(orderData: Order) {
    sheetPresenter.opensheetReportOrderVC(self, storeyBoard: .complaint, order:orderData,delegate: nil)
  }
  
  func reject(orderData: Order) {
    sheetPresenter.opensheetCancelOrderVC(self, storeyBoard: .removeOrder, order:orderData,delegate: self)
  }
    func reload() {
        getUserOrders()
    }
  
}

extension driverOrderVC:sectionDelegate{
  
    func Select(_ index: IndexPath) {
        self.currentIndex = index.row
      switch index.row {
      case 0:
        type = .Waiting
      case 1:
        type = .Process
      case 2:
        type = .Delivered
      default:
        break
      }
        self.getUserOrders()
    }
  
}

extension driverOrderVC:UITableViewDataSource,UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selectedOrder.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: driverOrderCell.identifier, for: indexPath) as! driverOrderCell
    cell.delegate = self
    cell.cellConfigration(type,orderData: selectedOrder[indexPath.row])
    return cell
  }
}
extension driverOrderVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return selectedOrder.count == 0

    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "chat").maskWithColor(color: Color.mainColor!)!
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
        let text = LanguageManager.isArabic ? "لا يوجد طلبات" : "No orders yet !"
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}


