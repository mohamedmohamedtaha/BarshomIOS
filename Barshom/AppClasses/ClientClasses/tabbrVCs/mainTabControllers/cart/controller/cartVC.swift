//
//  cartVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/24/20.
//

import UIKit
import DZNEmptyDataSet
var selectedAddress : AddressModel?

class cartVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
    
    var selectedCoupon : Coupon?
    var isFromMtager = false
    var notes = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      Utilities.addLogoTitleView(self)
      tableView.register(UINib(nibName: cartCell.identifier, bundle: nil), forCellReuseIdentifier: cartCell.identifier)
      tableView.register(UINib(nibName: cartDetailsCell.identifier, bundle: nil), forCellReuseIdentifier: cartDetailsCell.identifier)
      tableView.delegate = self
      tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        rootVC = self
        
        if !isFromMtager{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openMenu))
        }


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    @objc func openMenu(){
        sideMenu().openMenu(rootVC!,type:.client)
    }
    
//  @IBAction func menuAction(_ sender: UIButton) {
//    sideMenu().openMenu(rootVC!,type:.client)
//  }

}

extension cartVC :cDelegate,cartDetailsDelegate,AddressDelegate,discountDelegate{
    
    func getAddress(address: AddressModel) {
        selectedAddress = address
        self.tableView.reloadData()
    }
    
    func discountApplied(discount: Coupon?) {
        selectedCoupon = discount
        self.tableView.reloadData()
    }
    
    
    func removeCouponSelected() {
        selectedCoupon = nil
        self.tableView.reloadData()
    }
    
    
    func notesChanges(text: String) {
        notes = text
    }
    
    func couponSelected() {
        sheetPresenter.opensheetDiscountVC(self, storeyBoard: .Cart,companyId:cartList[0].pro_adv_id!,delegate:self)
    }
    
    func addressSelected() {
        let vc = UIStoryboard(name: "address", bundle: nil).instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadData(index: Int, quantity: Double) {
        cartList[index].quantity = "\(quantity)"
        self.tableView.reloadData()
    }
    
  func payOrder() {
    if selectedAddress == nil {
        AppHelper.showInfoAlert(message: Resources.Common.chooseDeliveryAddress)
        return
    }
     
    var total = 0.0
    var discountPrice = 0.0
    var products = ""
    var delivery = 0.0
    let city = UserManager.getUserCity
    if city != nil
    {
        if cartList.count > 0 {
            if cartList[0].pro_adv_id! == "2" {
                if isFastOrder {
                    delivery = Double(city!.city_barshom_price ?? "0")!
                }
                else
                {
                    delivery = Double(city!.city_barshom_normal_price ?? "0")!
                }
            }
            else
            {
                if isFastOrder {
                    delivery = Double(city!.city_other_price ?? "0")!
                }
                else
                {
                    delivery = Double(city!.city_other_normal_price ?? "0")!
                }
            }
        }
    }
    for i in cartList
    {
        products += "\(i.pro_id!)_\(i.quantity!)_\(i.unit!)|"
        total += Double(i.q_price ?? 0)*Double(i.quantity!)!
    }
      if selectedCoupon != nil {
          if selectedCoupon!.coupon_discount_type == "total"
          {
              discountPrice = (Double(selectedCoupon!.coupon_discount!)!/100) * total
              
          }
          else
          {
              discountPrice = (Double(selectedCoupon!.coupon_discount!)!/100) * delivery
          }
      }
    total += delivery
   print("testTotal \(abs(total-discountPrice))")
    var pars = [
        "companyId":cartList[0].pro_adv_id!,
        "couponCode":selectedCoupon != nil ? selectedCoupon!.coupon_code! : "",
        "orderProductsTotal":"\(abs(total-discountPrice))",
        "orderDiscount":selectedCoupon != nil ? "\(discountPrice)" : "",
        "orderDiscountType": selectedCoupon != nil ? selectedCoupon!.coupon_discount_type! : "",
        "orderType": isFastOrder ? "fast" : "normal",
        "orderDetails": notes,
        "productQuantity":products] as [String : Any]
    
    if selectedAddress != nil {
        pars.updateValue(selectedAddress!.address_text!, forKey: "orderAddress")
        pars.updateValue(selectedAddress!.address_id!, forKey: "addressId")
        pars.updateValue(selectedAddress!.address_location!, forKey: "orderLocation")
    }
   
        performSegue(withIdentifier: "payment", sender: (pars,abs(total-discountPrice)))
  }
  
    func delete(index: Int) {
        AppHelper.showInfoAlert(message: "Do you want to remove this product ?".Localized, confirmBtnTitle: "Remove".Localized) {
            cartList.remove(at: index)
            self.tableView.reloadData()
        }
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "payment" {
            let vc = segue.destination as! paymentTypeActionVC
            vc.pars = (sender as! ([String:Any],Double)).0
            vc.totalPrice =  (sender as! ([String:Any],Double)).1
        }
    }
  
  
}
extension cartVC:UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if  cartList.count == 0
    {
        return 0
    }
    return 1+cartList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row > cartList.count-1{
      let cell = tableView.dequeueReusableCell(withIdentifier: cartDetailsCell.identifier, for: indexPath) as! cartDetailsCell
      cell.delegate = self
        cell.cellConfigration(vc: self, address: selectedAddress, coupon: selectedCoupon)
      return cell
    }else {
    let cell = tableView.dequeueReusableCell(withIdentifier: cartCell.identifier, for: indexPath) as! cartCell
    cell.delegate = self
    cell.index = indexPath.row
    cell.cellConfigration(productData: cartList[indexPath.row])
    return cell
    }
  }
}
extension cartVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return cartList.count == 0

    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "cartWhit").maskWithColor(color: Color.mainColor!)!
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
        let text = LanguageManager.isArabic ? "السلة فارغة" : "Your cart is empty"
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}


