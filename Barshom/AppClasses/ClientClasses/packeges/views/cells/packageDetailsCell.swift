//
//  packageDetailsCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

class packageDetailsCell: UITableViewCell {

  @IBOutlet weak var packageBg: UIView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var productsLb: UILabel!
    @IBOutlet weak var durationLb: UILabel!
    @IBOutlet weak var deliveryPriceLb: UILabel!
    @IBOutlet weak var deliveryTimesLb: UILabel!
    @IBOutlet weak var deliveryTimesRemainingLb: UILabel!
    @IBOutlet weak var remainingView: UIView!
    @IBOutlet weak var imgIV: UIImageView!

    var isSubscribed = false
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func cellConfigration(packageData:Package){
    packageBg.dropShadow(roundCorner: 20)
        nameLb.text = packageData.package_name!
        priceLb.text = packageData.package_price! + " \(Resources.Common.sar)"
        durationLb.text = packageData.package_period! + " \(Resources.Common.days)"
        productsLb.text = packageData.package_products_count!
        deliveryPriceLb.text = packageData.package_delivery_price!
        deliveryTimesLb.text = packageData.package_delivery_times!
        deliveryTimesRemainingLb.text = packageData.package_delivery_times_left ?? "0"
        remainingView.isHidden = !isSubscribed
        imgIV.sd_setImage(with: URL(string: packageData.imageUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "logoWhite").maskWithColor(color: UIColor.lightGray.withAlphaComponent(0.5)))

  }
    
}
