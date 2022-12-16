//
//  addressCell.swift
//  Barshom
//
//  Created by Ahmed Yehia on 02/05/2021.
//

import Foundation
import UIKit
class addressCell: UITableViewCell {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    var notData : AddressModel?
    var index = 0
    var delegate:cellSelectionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(dat:AddressModel,ind:Int)
    {
        self.index = ind
        self.notData = dat
        self.titleLb.text = dat.address_name!
        self.dateLb.text = dat.address_text!
    }

    @IBAction func deleteClicked()
    {
        self.delegate?.selected(index: index)
    }
    
    
}
