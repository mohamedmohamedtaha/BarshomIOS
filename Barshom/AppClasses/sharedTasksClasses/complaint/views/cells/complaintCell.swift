//
//  complaintCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

protocol complaintDelegate {
  func reply(orderData:Ticket)
  func cancel(orderData:Ticket)
}

class complaintCell: UITableViewCell {

  @IBOutlet weak var bg: UIView!
    @IBOutlet weak var idLb: UILabel!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var detailsLb: UILabel!
    @IBOutlet weak var billLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var statusLb: UILabel!

    var delegate: complaintDelegate?
    var ticketData : Ticket?
  override func awakeFromNib() {
        super.awakeFromNib()
    }

  func cellConfigration(ticketData : Ticket){
    self.ticketData = ticketData
    idLb.text = "#\(ticketData.cons_id!)"
    titleLb.text = ticketData.cons_title!
    detailsLb.text = ticketData.cons_description!
    billLb.text = ticketData.cons_bell_number!
    dateLb.text = ticketData.cons_created_at!
    statusLb.text = ticketData.status_translated!
    bg.dropShadow(roundCorner: 17)
  }
    
    @IBAction func closedTicket()
    {
        delegate?.cancel(orderData: ticketData!)
    }
    @IBAction func replyTicket()
    {
        delegate?.reply(orderData: ticketData!)

    }
}
