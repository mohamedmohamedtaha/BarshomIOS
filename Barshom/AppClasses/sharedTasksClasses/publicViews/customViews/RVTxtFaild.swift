//
//  roundTextFaild.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/3/21.
//

import Foundation
import UIKit
import JVFloatLabeledTextField

enum validateTextFaildEnum:String {
    case valid = "valid"
    case empty = " text faild is Empty"
    case emailError = " email is invalid"
    case mobileError = " mobile is invalid"
    
}



class RVTxtFaild : JVFloatLabeledTextField,UITextFieldDelegate {
    
    //var padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    var withImg = false
    var imageView = UIImageView()
    var errorStarLb = UILabel()
    
    var imgH:CGFloat {
        return self.frame.height/2
    }
    
    var TxtX:CGFloat = 15.0
    var isValid = false
    var errorType:validateTextFaildEnum = .valid
    
    var padding : UIEdgeInsets {
        return withImg ? UIEdgeInsets(top: 0, left: TxtX+imgH+TxtX, bottom: 0, right: TxtX+imgH+TxtX):UIEdgeInsets(top: 0, left: TxtX, bottom: 0, right: TxtX)
    }
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        if LanguageManager.isArabic {
            self.textAlignment = .right
        }else {
            self.textAlignment = .left
        }
        self.delegate = self
        selected()
        self.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func selected(){
        errorStarLb.text = ""
        if (self.text == "") {
            roundBorder(Color.tintGray!)
        }else {
            roundBorder(Color.mainColor!)
        }
    }
    
    
    
    
    func validate(_ txt:RVTxtFaild ) -> validateTextFaildEnum{
        
        errorType = .valid
        if (txt.text == ""){
            errorType = .empty
            setNotActive()
            return errorType
        }
        
        switch self.keyboardType {
        case .emailAddress:
            if !Utilities.verifyEmail(txt.text ?? "") {
                errorType = .emailError
                setNotActive()
            }
            return self.errorType
        default:
            return self.errorType
        }
        
    }
    
    func setActive(){
        isValid = true
        selected()
    }
    
    func setNotActive(){
        isValid = false
        roundBorder(UIColor.red)
        AddErrorStar()
    }
    
    func roundBorder(_ color:UIColor){
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
        self.placeholderColor = color
        self.floatingLabelTextColor = color
        self.floatingLabelActiveTextColor = color
        self.imageView.changeTintColor(color)
        self.floatingLabelYPadding = 2
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorStarLb.text = ""
        roundBorder(Color.mainColor!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setActive()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        setActive()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


extension RVTxtFaild {
    
    
    func AddImage(_ img:UIImage)
    {
        withImg = true
        let Frame = CGRect(x: 0, y: -(imgH-(imgH/2)-5) , width: 20, height: 20)
        let View = UIView(frame: Frame)
        imageView.frame = Frame
        imageView.image = LanguageManager.isArabic ? img : img.withHorizontallyFlippedOrientation()
        imageView.contentMode = .scaleAspectFit
        View.addSubview(imageView)
        self.addSubview(View)
        
        View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            View.leadingAnchor.constraint(equalTo: View.superview!.leadingAnchor, constant: LanguageManager.isArabic ? 30 : 10),
            View.centerYAnchor.constraint(equalTo: View.superview!.centerYAnchor,constant: -3)

        ])
    }
    
    
    func AddErrorStar()
    {
        
        let Frame = CGRect(x: 0, y: 0 , width: 20, height: 20)
        let View = UIView(frame: Frame)
        
        errorStarLb.frame = Frame
        errorStarLb.textAlignment = .center
        errorStarLb.textColor = .red
        if isValid {
            errorStarLb.text = ""
        }else{
            errorStarLb.text = "*"
        }
        errorStarLb.contentMode = .scaleToFill
        View.addSubview(errorStarLb)
        
        if LanguageManager.isArabic
        {
            self.leftViewMode = .always
            self.leftView = View
        }
        else
        {
            self.rightViewMode = .always
            self.rightView = View
        }
    }
    
}

extension RVTxtFaild {
    
    
    static func validationTxts(_ failds:[RVTxtFaild])->validateMessage{
        let isAllValid = validateMessage()
        var masage = ""
        
        for i in failds {
            if (i.validate(i) != .valid) {
                isAllValid.status=false
                break
            }else {
                isAllValid.status=true
            }
        }
        
        for i in failds {
            if i.validate(i) != .valid {
                masage = masage + i.placeholder! + i.validate(i).rawValue + ",\n"
            }
        }
        
        isAllValid.msg = masage
        return isAllValid
    }
}

class validateMessage {
    var msg = ""
    var status = false
}



