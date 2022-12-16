//
//  storeCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit
import Cosmos
protocol storeDelegate {
  func selectStore(storeData:Store)
}

class storeCell: UICollectionViewCell {
  
  @IBOutlet weak var bg: UIView!
  @IBOutlet weak var heightConstriant: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var distanceLb: UILabel!
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var storeImg: UIImageView!
    @IBOutlet weak var storeRate: CosmosView!

  var delegate:storeDelegate?
  var storeData:Store?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    func cellConfigration(_ size:CGSize,storeData:Store){
        self.storeData = storeData
//    heightConstriant.constant = size.height
//    widthConstraint.constant = size.width
    bg.dropShadow(roundCorner:20)
        nameLb.text = storeData.adv_name!
        distanceLb.text = "\(storeData.market_user_distance!.trimmed)  \(Resources.Common.km)"
        timeLb.text = "\(storeData.getTimeFormatted()) \(Resources.Common.minutes)"
        storeImg.sd_setImage(with: URL(string: storeData.imageUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "logoWhite").maskWithColor(color: UIColor.gray))
        storeRate.rating = Double("0")!

  }
  
  @IBAction func storeProductAction(_ sender: UIButton) {
    delegate?.selectStore(storeData:storeData!)
  }
  
}
