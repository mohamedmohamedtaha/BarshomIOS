//
//  productDetailsTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/27/20.
//

import UIKit
import Cosmos
class productDetailsTVC: UITableViewController,reloadDelegate ,addedCartDelegate{
   
  @IBOutlet weak var detailsBg: UIView!
  @IBOutlet weak var ratingBg: UIView!
  @IBOutlet weak var boxPriceBg: UIView!
  @IBOutlet weak var kiloPriceBg: UIView!
  @IBOutlet weak var ratingTitleBg: UIView!
  @IBOutlet weak var NextIcon: UIImageView!
    @IBOutlet weak var kiloBeforePriceLb: UILabel!
    @IBOutlet weak var boxBeforePriceLb: UILabel!
      @IBOutlet weak var kiloAfterPriceLb: UILabel!
      @IBOutlet weak var boxAfterPriceLb: UILabel!
      @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var unitBeforePriceLb: UILabel!
    @IBOutlet weak var unitAfterPriceLb: UILabel!

      @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var discountLb: UILabel!
    @IBOutlet weak var descLb: UILabel!
    @IBOutlet weak var categoryLb: UILabel!
    @IBOutlet weak var availableKgLb: UILabel!
    @IBOutlet weak var availableBoxLb: UILabel!
    @IBOutlet weak var kilosInBoxLb: UILabel!
    
      @IBOutlet weak var nameLb: UILabel!
      @IBOutlet weak var prodImg: UIImageView!
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var namelb: UILabel!
    @IBOutlet weak var commentLb: UILabel!
    @IBOutlet weak var rateratingView: CosmosView!
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var availableUnitLb: UILabel!

    
  var  productData  : Products?
  var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
  
  override func viewDidLoad() {
        super.viewDidLoad()
    Utilities.addLogoTitleView(self)
    detailsBg.dropShadow(roundCorner:15)
    ratingBg.dropShadow(roundCorner:15)
    self.navigationItem.backBarButtonItem?.title = ""
    handleData()
    
  }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProductDetails()
    }
    func getProductDetails()
    {
        let pars = ["proId":productData!.pro_id!]
        UserService.shared.getProducts(pars: pars) { [self] (data) in
            self.productData = data.filter({ (prod) -> Bool in
                return prod.pro_id! == productData!.pro_id!
            }).first
            self.handleData()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2
        {
            return 0
        }
        return UITableView.automaticDimension
    }
  func handleData()
  {
    if LanguageManager.isArabic {
      NextIcon.image = #imageLiteral(resourceName: "backAr")
    }else {
      NextIcon.image = #imageLiteral(resourceName: "backEn")
    }

    ratingTitleBg.round([.topLeft,.topRight], corner: 15)
    boxPriceBg.round((LanguageManager.isArabic) ? [.bottomLeft]:[.bottomRight], corner: 15)
    kiloPriceBg.round((LanguageManager.isArabic) ? [.bottomRight]:[.bottomLeft], corner: 15)
    let  kgOldPrice = Double(productData!.pro_kg_price!.isEmpty ? "0" : productData!.pro_kg_price!)!
    let  boxOldPrice = Double(productData!.pro_box_price!.isEmpty ? "0" : productData!.pro_box_price!)!
    let  unitOldPrice = Double(productData!.pro_unit_price!.isEmpty ? "0" : productData!.pro_unit_price!)!

    let  kgNewPrice = Double(productData!.pro_kg_discount_price!.isEmpty ? "0" : productData!.pro_kg_discount_price!)!
    let  boxNewPrice = Double(productData!.pro_box_discount_price!.isEmpty ? "0" : productData!.pro_box_discount_price!)!
    let  unitNewPrice = Double(productData!.pro_unit_discount_price!.isEmpty ? "0" : productData!.pro_box_discount_price!)!

    
    if kgNewPrice < kgOldPrice && kgNewPrice != 0 {
        kiloAfterPriceLb.text = ("\(productData!.pro_kg_discount_price!.isEmpty ? "0" : productData!.pro_kg_discount_price!) \(Resources.Common.sar)")
        kiloBeforePriceLb.attributedText = ("\(productData!.pro_kg_price!) \(Resources.Common.sar)").strikeThrough(.red)
        kiloBeforePriceLb.isHidden = false
    }
    else
    {
        kiloBeforePriceLb.isHidden = true
        kiloAfterPriceLb.text = ("\(productData!.pro_kg_price!.isEmpty ? "0" : productData!.pro_kg_price!) \(Resources.Common.sar)")

    }
      
      
    if boxNewPrice < boxOldPrice && boxNewPrice != 0 {
        boxBeforePriceLb.isHidden = false
        boxAfterPriceLb.text = ("\(productData!.pro_box_discount_price!.isEmpty ? "0" : productData!.pro_box_discount_price!) \(Resources.Common.sar)")
        boxBeforePriceLb.attributedText = ("\(productData!.pro_box_price!) \(Resources.Common.sar)").strikeThrough(.red)
        
    }
    else
    {
        boxBeforePriceLb.text = ""
        
        boxAfterPriceLb.text = ("\(productData!.pro_box_price!.isEmpty ? "0" : productData!.pro_box_price!) \(Resources.Common.sar)")
    }
      
      if unitNewPrice < unitOldPrice && unitNewPrice != 0 {
          unitBeforePriceLb.isHidden = false
          unitAfterPriceLb.text = ("\(productData!.pro_unit_discount_price!.isEmpty ? "0" : productData!.pro_unit_discount_price!) \(Resources.Common.sar)")
          unitBeforePriceLb.attributedText = ("\(productData!.pro_unit_price!) \(Resources.Common.sar)").strikeThrough(.red)
          
      }
      else
      {
          unitBeforePriceLb.text = ""
          
          unitAfterPriceLb.text = ("\(productData!.pro_unit_price!.isEmpty ? "0" : productData!.pro_unit_price!) \(Resources.Common.sar)")
      }
      
      

    if productData!.discount_per == "" || productData!.discount_per == "0" || productData!.discount_per == nil {
        
        discountView.isHidden = true
        
    }
    else
    {
        discountView.isHidden = false
        discountLb.text = "\(Int(Double(productData!.discount_per!.isEmpty ? "0" : productData!.discount_per!)!))%"

    }
   
    ratingView.rating =  Double(productData!.pro_rate ?? "0") ?? 0
    prodImg.sd_setImage(with: URL(string: productData!.imageUrl ?? ""),placeholderImage: #imageLiteral(resourceName: "logoWhite").maskWithColor(color: UIColor.gray))
    nameLb.text = productData!.pro_name!
    categoryLb.text = productData!.cat_name
    availableKgLb.text = productData!.pro_kg_quantity!
    availableBoxLb.text = productData!.pro_box_quantity!
    availableUnitLb.text = productData!.pro_unit_quantity!
      
      print("productData!.pro_unit_quantity! = \(productData!.pro_unit_quantity! )")
    kilosInBoxLb.text = "( \(productData!.pro_box_kilos_number!) \(Resources.Common.kg) )"
    descLb.text = (productData!.pro_details ?? "")
    if productData!.rates.count > 0 {
        let rate = productData!.rates[productData!.rates.count-1]
        namelb.text = rate.user_name!
        commentLb.text = rate.rate_body!
        ratingView.rating = Double(rate.rate_value!) ?? 0
        userImg.sd_setImage(with: URL(string: rate.user_image!), placeholderImage: #imageLiteral(resourceName: "logoWhite"))
        bg.isHidden = false
    }
    else
    {
        bg.isHidden = true
    }
  }
    @IBAction func shareClicked()
    {
        let textShare = [ "https://brshom.com/products/\(productData!.pro_id!)" ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "Retings" {
        let vc = segue.destination as! ratesVC
        vc.productData = productData!
    }
  }
  @IBAction func cartAction(_ sender: UIButton) {
    //addRate
    if !UserManager.isLoggedIn
    {
        AppHelper.showLoginAlert(vc: self)
        return
    }
    sheetPresenter.opensheetRateProductVC(self, storeyBoard:.rate, order:productData!.pro_id!)

  }
  
  @IBAction func addTocartAction(_ sender: UIButton) {
    if !UserManager.isLoggedIn
    {
        AppHelper.showLoginAlert(vc: self)
        return
    }
    sheetPresenter.openQuantityVC(self, storeyBoard: .ProductDetails,order:productData!,delegate:self)

//    let vc = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: mainTabBarVC.identifier) as? mainTabBarVC
//    vc?.selectedIndex = 0
//    self.dismiss(animated: true, completion: nil)
//    Utilities.root(vc!)
  }
  
  @IBAction func reportAction(_ sender: UIButton) {
    if !UserManager.isLoggedIn
    {
        AppHelper.showLoginAlert(vc: self)
        return
    }
    sheetPresenter.opensheetReportProductVC(self, storeyBoard: .ProductDetails,order:productData!,delegate:self)
  }
  @IBAction func ratingAction(_ sender: UIButton) {
    performSegue(withIdentifier: "Retings", sender: nil)
  }
  
    
    func reload() {
        
    }
    func reloadCart() {
        
    }
    

}
