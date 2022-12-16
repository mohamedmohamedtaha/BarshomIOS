//
//  packageCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit

protocol packageCellDelegate {
  func select(_ type:Package)
}
class packageCell: UICollectionViewCell {

  @IBOutlet weak var bg: UIView!
  
  @IBOutlet weak var hightConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bt: UIButton!
    @IBOutlet weak var imgIV: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var productsLb: UILabel!
    @IBOutlet weak var durationLb: UILabel!
  var delegate:packageCellDelegate?
  var packageData:Package?
    var showSubscribe = false
  override func awakeFromNib() {
        super.awakeFromNib()
    
    }
  
    func cellConfigration(_ size:CGSize,packageData:Package,doShowSubscribe: Bool){
        self.showSubscribe = doShowSubscribe
    self.packageData = packageData
    hightConstraint.constant = size.height
    widthConstraint.constant = size.width
    bg.dropShadow(roundCorner:20)
    nameLb.text = packageData.package_name!
    priceLb.text = packageData.package_price! + " \(Resources.Common.sar)"
    durationLb.text = packageData.package_period! + " \(Resources.Common.days)"
    productsLb.text = packageData.package_products_count!
        imgIV.sd_setImage(with: URL(string: packageData.imageUrl ), placeholderImage: UIImage(named: "logoWhite")!.maskWithColor(color: UIColor.lightGray.withAlphaComponent(0.5)))

        if self.showSubscribe && packageData.isSubscribed(){
        bt.setTitle(Resources.Common.details, for: .normal)
    }else{
        bt.setTitle(Resources.Common.subscribeToPckg, for: .normal)
    }
  }
  
  @IBAction func subscribePackageAction(_ sender: UIButton) {
    delegate?.select(packageData!)
  }
  

}
