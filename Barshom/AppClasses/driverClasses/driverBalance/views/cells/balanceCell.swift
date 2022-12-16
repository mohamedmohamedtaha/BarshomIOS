//
//  balanceCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit

class balanceCell: UITableViewCell {
    @IBOutlet weak var amountLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configureCell(model:WithdrawBalance)
    {
        amountLb.text = "\(model.request_amount ?? "0") \(Resources.Common.sar)"
        dateLb.text = model.request_created_at!
    }
    
}
