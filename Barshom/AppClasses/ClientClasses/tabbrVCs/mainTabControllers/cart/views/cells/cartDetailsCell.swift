//
//  cartDetailsCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/31/20.
//

import UIKit
import JVFloatLabeledTextField
protocol cartDetailsDelegate {
    func payOrder()
    func couponSelected()
    func notesChanges(text :String)

    func removeCouponSelected()
    func addressSelected()
    
}
class cartDetailsCell: UITableViewCell, UITextViewDelegate {

  @IBOutlet weak var coponBg: UIView!
    @IBOutlet weak var addressBg: UIView!
    @IBOutlet weak var hasAddressBg: UIView!
    @IBOutlet weak var hasCoponBg: UIView!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var dis_codeLb: UILabel!
    @IBOutlet weak var dis_ratioLb: UILabel!
    @IBOutlet weak var dis_dateLb: UILabel!
    @IBOutlet weak var notesTV: JVFloatLabeledTextView!
    
    
    @IBOutlet weak var detailsBg: UIView!
    @IBOutlet weak var countLb: UILabel!
    @IBOutlet weak var discountLb: UILabel!
    @IBOutlet weak var totalLb: UILabel!
    @IBOutlet weak var totalPriceLb: UILabel!
    @IBOutlet weak var deliveryPriceLb: UILabel!

  var delegate:cartDetailsDelegate?
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func textViewDidChange(_ textView: UITextView) {
        print("tessstt \(textView.text!)  - \(notesTV.text!)")
        delegate?.notesChanges(text: notesTV.text!)
    }
    func cellConfigration(vc:UIViewController,address:AddressModel?,coupon:Coupon?){
    countLb.text = "\(cartList.count)"
        notesTV.delegate = self
        notesTV.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        var discount = 0.0

        var total = 0.0
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
        total += Double(i.q_price ?? 0)*Double(i.quantity!)!
    }
        totalLb.text = "\(total) \(Resources.Common.sar)"

    if coupon != nil {
        if coupon!.coupon_discount_type == "total"
        {
            print("Discount -- Total \(coupon!.coupon_discount!) -- \(total)")

            discount = (Double(coupon!.coupon_discount!)!/100) * total
            total -= discount
            deliveryPriceLb.text = "\(delivery) \(Resources.Common.sar)"

        }
        else
        {
            print("Discount -- Delivary \(coupon!.coupon_discount!) -- \(delivery)")
            discount = (Double(coupon!.coupon_discount!)!/100) * delivery
            deliveryPriceLb.text = "\(delivery) \(Resources.Common.sar)"

            delivery -= discount
        }
    }
        else{
            deliveryPriceLb.text = "\(delivery) \(Resources.Common.sar)"
        }
        
        total += delivery
        discountLb.text = "\(discount) \(Resources.Common.sar)"
        totalPriceLb.text = "\(abs(total)) \(Resources.Common.sar)"
        coponBg.dropShadow(roundCorner: 15)
        addressBg.dropShadow(roundCorner: 15)
        hasAddressBg.dropShadow(roundCorner: 15)
        hasCoponBg.dropShadow(roundCorner: 15)
        detailsBg.dropShadow(roundCorner: 15)
        
        if address != nil {
            self.addressLb.text = address!.address_text
            self.hasAddressBg.isHidden = false
            self.addressBg.isHidden = true
        }
        else
        {
            self.addressLb.text = ""
            self.hasAddressBg.isHidden = true
            self.addressBg.isHidden = false
        }
        if coupon != nil {
            dis_codeLb.text = "\(coupon!.coupon_code!) ( \((coupon!.coupon_discount_type == "total" ? (LanguageManager.isArabic ? "خصم علي الإجمالي" : "Discount on total price") : (LanguageManager.isArabic ? "خصم علي التوصيل" : "Discount on delivery price"))) )" 
            dis_ratioLb.text = coupon!.coupon_discount! + "%"
            dis_dateLb.text = coupon!.coupon_expire_at!
            
            hasCoponBg.isHidden = false
            coponBg.isHidden = true
        }
        else
        {
            hasCoponBg.isHidden = true
            coponBg.isHidden = false
        }
  }
  
  @IBAction func coponAction(_ sender: UIButton) {
    delegate?.couponSelected()
  }
    @IBAction func removeCoponAction(_ sender: UIButton) {
      delegate?.removeCouponSelected()
    }
    @IBAction func addressAction(_ sender: UIButton) {
        delegate?.addressSelected()
    }
  
  @IBAction func payAction(_ sender: UIButton) {
    delegate?.payOrder()
  }
}
