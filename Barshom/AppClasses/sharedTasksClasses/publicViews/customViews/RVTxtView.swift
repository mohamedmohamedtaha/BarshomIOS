//
//  RVTxtView.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import Foundation
import UIKit
import JVFloatLabeledTextField

class RVTxtView :JVFloatLabeledTextView,UITextViewDelegate{
  

  var errorStarLb = UILabel()
  var TxtX:CGFloat = 15.0
  var isValid = false
  var errorType:validateTextFaildEnum = .valid
  
  
  
  
  override func draw(_ rect: CGRect) {
      // Drawing code
      if LanguageManager.isArabic {
          self.textAlignment = .right
      }else {
          self.textAlignment = .left
      }
      self.delegate = self
      self.contentInset = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
      selected()

  }
  
  
  func selected(){
    errorStarLb.text = ""
    if (self.text == "") {
      roundBorder(Color.tintGray!)
    }else {
      roundBorder(Color.mainColor!)
    }
  }
  
 

  
  func validate(_ txt:RVTxtView ) -> validateTextFaildEnum{

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
    self.layer.cornerRadius = 20//self.bounds.height/2
    self.layer.borderWidth = 1.0
    self.layer.borderColor = color.cgColor
    self.placeholderTextColor = color
    self.floatingLabelTextColor = color
    self.floatingLabelActiveTextColor = color

    self.floatingLabelYPadding = -13
  }

  func textViewDidBeginEditing(_ textView: UITextView) {
    errorStarLb.text = ""
    roundBorder(Color.mainColor!)
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    setActive()
  }
 
}

extension RVTxtView {
  
  
  func AddErrorStar()
  {
      
      let Frame = CGRect(x: -5, y: 0 , width: 20, height: 20)
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

  }
    func addPadding(amount: CGFloat? = 8) {
        self.textContainerInset = UIEdgeInsets(top: 0, left: amount!, bottom: 0, right: amount!)
        }
}

extension RVTxtFaild {
  
  
  static func validationTxts(_ failds:[RVTxtView])->validateMessage{
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



