//
//  MessageFromCell.swift
//  Al Qarra Medical Complex
//
//  Created by Yo7ia on 1/2/19.
//  Copyright © 2019 Yo7ia. All rights reserved.
//


import UIKit
import SDWebImage


class MessageFromCell: UITableViewCell {
    
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var msgLBL: UILabel!
    @IBOutlet weak var dateLBL: UILabel!
    @IBOutlet weak var msgBack: UIView!
    
    @IBOutlet weak var msgConstraints: NSLayoutConstraint!

    var data :Message?
    func handleCells(data: Message)
    {
        self.data = data
        
        msgLBL.text = data.msg_text!
        dateLBL.text = data.msg_created_at!.toDate!.timeAgoSince
        if data.msg_user_id! == UserManager.getUserData!.id
        {
            nameLBL.text = LanguageManager.isArabic ? "انت" : "You"
            msgBack.backgroundColor = Color.msgBackFrom!
            nameLBL.textColor = Color.mainColor!
            msgLBL.textColor = UIColor.black
            dateLBL.textColor = UIColor.lightGray
            
            
        }
        else
        {
            nameLBL.text = data.other_user_name!
            msgBack.backgroundColor = Color.msgBackTo!
            nameLBL.textColor = UIColor.green
            msgLBL.textColor = .black
            dateLBL.textColor = UIColor.lightGray
        }
        msgConstraints.constant = data.msg_text!.count < 50 ? 100 : 10
        
    }
    
    
}
