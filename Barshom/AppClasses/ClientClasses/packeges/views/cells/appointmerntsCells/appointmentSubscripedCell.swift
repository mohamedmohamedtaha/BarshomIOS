//
//  appointmentSubscripedCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

protocol appointmentSubscripedCellDelegate {
  func addRate()
}
class appointmentSubscripedCell: UITableViewCell {

  var delegate:appointmentSubscripedCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  @IBAction func addRateAction(_ sender: UIButton) {
    delegate?.addRate()
  }
  
}
