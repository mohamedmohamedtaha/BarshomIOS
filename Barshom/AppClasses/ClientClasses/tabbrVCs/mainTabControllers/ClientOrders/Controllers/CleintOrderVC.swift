//
//  CleintOrderVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/21/20.
//

import UIKit
import DZNEmptyDataSet
enum orderType {
    case Waiting,Process,Delivered,Canceld
}

class CleintOrderVC: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var sectionsCollection: UICollectionView!
    var sectionsCollectionDataSource = sectionsCollectionView()
    var allOrders = GroupOrders(JSON: ["":""])
    var selectedOrder =  [Order]()
    var type:orderType = .Waiting
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleUI()
        Utilities.addLogoTitleView(self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserOrders()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            let vc = segue.destination as! clientOrderDetailsTVC
            vc.type = type
            vc.orderData = sender as! Order
        }
    }
    func handleUI(){
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate =  self
        sectionsCollectionDataSource.delegate = self
        sectionsCollectionDataSource.fromOrders = true
        sectionsCollectionDataSource.collectionConfigration(self.sectionsCollection, dataSource: getSection())
        tableView.register(UINib(nibName: orderCell.identifier, bundle: nil), forCellReuseIdentifier: orderCell.identifier)
    }
    
    func getSection() -> [topSection]{
        var sections  = [topSection]()
        sections.append(topSection(Resources.Common.pending))
        sections.append(topSection(Resources.Common.inDelivery))
        sections.append(topSection(Resources.Common.delivered))
        sections.append(topSection(Resources.Common.cancelled))
        return sections
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
        sideMenu().openMenu(rootVC!,type:.client)
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
        case 3:
            status  = "canceled";
            break;
        default:
            status  = "wait";
            break;
        }
        UserService.shared.getUserOrders(status : status) { [self] (dat) in
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
        case 3:
            selectedOrder = allOrders!.canceled
        default:
            break
        }
        self.tableView.reloadData()

    }
    
}

extension CleintOrderVC:reloadDelegate{
    func reload()
    {
        self.getUserOrders()
    }
}
extension CleintOrderVC:sectionDelegate{
    
    func Select(_ index: IndexPath) {
        currentIndex = index.row
        switch index.row {
        case 0:
            type = .Waiting
        case 1:
            type = .Process
        case 2:
            type = .Delivered
        case 3:
            type = .Canceld
        default:
            break
        }
        self.getUserOrders()
    }
    
    
    
}

extension CleintOrderVC:orderDelegate{
    
    
    func rate(orderData:Order) {
        sheetPresenter.opensheetRateVC(self, storeyBoard:.rate, order:orderData)
    }
    
    func resend(orderData:Order) {
        cartList.removeAll()
        for i in orderData.order_products!
        {
            var prod = OrderProducts(JSON: ["":""])!
            prod.quantity = i.quantity
            prod.unit = i.unit
            prod.unitkey = i.unit
            prod.pro_name = i.pro_name ?? ""
            prod.pro_id = i.pro_id!
            prod.pro_adv_id = i.pro_adv_id!
            prod.pro_kg_quantity = i.pro_kg_quantity!
            prod.pro_box_quantity = i.pro_box_quantity!
            prod.pro_kg_quantity = i.pro_kg_quantity!
            prod.pro_box_kilos_number = i.pro_box_kilos_number
            prod.imageUrl = i.imageUrl!
            prod.single_price = "\(i.q_price ?? 0)"
            prod.q_price = i.q_price
            cartList.append(prod)
        }
        //    selectedAddress = AddressModel(JSON: ["" : ""])!
        //    selectedAddress!.address_text = orderData.order_address!
        //    selectedAddress!.lat = "\(orderData.order_location!.split(separator: ",")[0])"
        //    selectedAddress!.lng = "\(orderData.order_location!.split(separator: ",")[1])"
        isFastOrder = orderData.order_type! == "fast"
        self.tabBarController?.selectedIndex = 0
    }
    
    func complaint(orderData:Order) {
        sheetPresenter.opensheetReportOrderVC(self, storeyBoard: .complaint, order:orderData,delegate: nil)
    }
    
    func reject(orderData:Order) {
        sheetPresenter.opensheetCancelOrderVC(self, storeyBoard: .removeOrder, order:orderData,delegate: self)
    }
    
    func showDetails(orderData:Order) {
        performSegue(withIdentifier: "details", sender: orderData)
    }
    
}

extension CleintOrderVC:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: orderCell.identifier, for: indexPath) as! orderCell
        cell.delegate = self
        cell.cellConfigration(type, orderData: selectedOrder[indexPath.row])
        return cell
    }
}
extension CleintOrderVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
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


