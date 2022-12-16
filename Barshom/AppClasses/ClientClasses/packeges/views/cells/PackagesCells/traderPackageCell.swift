//
//  traderPackageCell.swift
//  Barshom
//
//  Created by Ahmed Yehia on 29/07/2021.
//


import UIKit

protocol traderPackageCellDelegate {
  func select(_ type:TraderPackage)
}
class traderPackageCell: UICollectionViewCell {

  @IBOutlet weak var bg: UIView!
  
  @IBOutlet weak var hightConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bt: UIButton!
    @IBOutlet weak var imgIV: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var expireView: UIView!
    @IBOutlet weak var expireLb: UILabel!
    @IBOutlet weak var durationLb: UILabel!
    @IBOutlet weak var btnConstraint: NSLayoutConstraint!

  var delegate:traderPackageCellDelegate?
  var packageData:TraderPackage?
    var showSubscribe = false
  override func awakeFromNib() {
        super.awakeFromNib()
    
    }
  
    func cellConfigration(_ size:CGSize,packageData:TraderPackage,doShowSubscribe: Bool){
    self.showSubscribe = doShowSubscribe
    self.packageData = packageData
    hightConstraint.constant = size.height
    widthConstraint.constant = size.width
    bg.dropShadow(roundCorner:20)
    nameLb.text = packageData.package_name!
    priceLb.text = packageData.package_price! + " \(Resources.Common.sar)"
    durationLb.text = packageData.package_period! + " \(Resources.Common.days)"
        
        imgIV.sd_setImage(with: URL(string: packageData.imageUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "logoWhite").maskWithColor(color: UIColor.lightGray.withAlphaComponent(0.5)))

    if self.showSubscribe && packageData.isSubscribed(){
        bt.isHidden = true
        btnConstraint.constant = 0
        expireLb.text = packageData.user_package_expire_at?.replacingOccurrences(of: "00:00:00", with: "").trimmed
        expireView.isHidden = false
        bt.setTitle(Resources.Common.details, for: .normal)
    }else{
        bt.isHidden = false
        btnConstraint.constant = 35
        expireView.isHidden = true
        bt.setTitle(Resources.Common.subscribeToPckg, for: .normal)
    }
  }
  
  @IBAction func subscribePackageAction(_ sender: UIButton) {
    delegate?.select(packageData!)
  }
  

}
