//
//  notificationCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/31/20.
//

import UIKit


class faqCell: UITableViewCell {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var contentLb: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var bg: UIView!
    var notData : FAQ?
    var index = 0
    var delegate:cellSelectionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(dat:FAQ,ind:Int)
    {
        
        self.index = ind
        self.notData = dat
        self.titleLb.text = "\(dat.question_id!) - \(dat.question_title!)"
        self.contentLb.text = dat.isSelected ? dat.question_body! : ""
        self.arrowImg.transform = CGAffineTransform(rotationAngle: dat.isSelected ? CGFloat.pi : 0)
    }

    @IBAction func deleteClicked()
    {
        self.delegate?.selected(index: index)
    }
    
    
}
