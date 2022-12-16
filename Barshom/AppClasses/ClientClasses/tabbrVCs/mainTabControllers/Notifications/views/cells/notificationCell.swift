//
//  notificationCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/31/20.
//

import UIKit

protocol cellSelectionDelegate {
    func selected(index: Int)
}
class notificationCell: UITableViewCell {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    var notData : Notifications?
    var index = 0
    var delegate:cellSelectionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(dat:Notifications,ind:Int)
    {
        self.index = ind
        self.notData = dat
        self.titleLb.text = dat.notify_text!
        self.dateLb.text = dat.created_since!
    }

    @IBAction func deleteClicked()
    {
        self.delegate?.selected(index: index)
    }
    
    
}
