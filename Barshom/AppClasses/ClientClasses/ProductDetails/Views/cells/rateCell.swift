//
//  rateCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/27/20.
//

import UIKit
import Cosmos
class rateCell: UITableViewCell {

    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var namelb: UILabel!
    @IBOutlet weak var commentLb: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var userImg: UIImageView!
    var rate:Rates?
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func celllConfigration(rate:Rates){
        self.rate = rate
        namelb.text = rate.user_name!
        commentLb.text = rate.rate_body!
        ratingView.rating = Double(rate.rate_value!) ?? 0
        userImg.sd_setImage(with: URL(string: rate.user_image!), placeholderImage: #imageLiteral(resourceName: "logoWhite"))

    bg.dropShadow(roundCorner:20)
  }
    
}
