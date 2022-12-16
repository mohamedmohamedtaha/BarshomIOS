//
//  PaymentMethodCollectionViewCell.swift
//  MFSDKDemo-Swift
//
//  Created by Elsayed Hussein on 8/29/19.
//  Copyright © 2019 Elsayed Hussein. All rights reserved.
//

import UIKit
import MFSDK

class PaymentMethodCollectionViewCell: UICollectionViewCell {
    //MARK: Variables
    
    //MARK: Outlets
    @IBOutlet weak var paymentMethodImageView: UIImageView!
    @IBOutlet weak var paymentMethodNameLabel: UILabel!
    
    //MARK Methods
    func configure(paymentMethod: MFPaymentMethod, selected: Bool) {
        paymentMethodImageView.image = nil
        paymentMethodImageView.layer.cornerRadius = 5
        if selected {
            paymentMethodImageView.layer.borderColor = Color.mainColor!.cgColor
            paymentMethodImageView.layer.borderWidth = 1
        } else {
            paymentMethodImageView.layer.borderColor = UIColor.darkGray.cgColor
            paymentMethodImageView.layer.borderWidth = 0
        }
        if let imageURL = paymentMethod.imageUrl {
            paymentMethodImageView.sd_setImage(with: URL(string: imageURL), completed: nil)
        }
        paymentMethodNameLabel.text = paymentMethod.paymentMethodEn ?? ""
    }
}
