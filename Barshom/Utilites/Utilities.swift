//
//  Utilities.swift
//  MySchool
//
//  Created by MacBook Pro on 24/12/2016.
//  Copyright © 2016 MacBook Pro. All rights reserved.
//

import Foundation
import UIKit
import CCMPopup
import DropDown
import Toaster
import SwiftyUserDefaults
import SideMenu

class Utilities: NSObject {
    
  class func setupSideMenu(_ v:UIViewController) {
    let presentationStyle: SideMenuPresentationStyle = .viewSlideOut
    presentationStyle.backgroundColor = .black
    let menu = AppStoryboard.sideMenu.instance.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
    menu?.menuWidth = 20
    menu?.presentationStyle = presentationStyle
    if Language.currentLanguage() == "ar" {
      menu?.leftSide = false
    }else {
      menu?.leftSide = true
    }
    
    SideMenuManager.default.leftMenuNavigationController = menu
    SideMenuManager.default.rightMenuNavigationController = menu
    
    SideMenuManager.default.addPanGestureToPresent(toView: v.navigationController!.navigationBar)
    SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: v.navigationController!.view)

  }
  
  class func root(_ vc:UIViewController) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = vc
  }
  
  class func addLogoTitleView( _ vc:UIViewController) {
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
      imageView.contentMode = .scaleAspectFit
      let image = #imageLiteral(resourceName: "logoWhite")
      imageView.image = image
      vc.navigationItem.titleView = imageView
  }
    class func getCurrentTimeStamp() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss".englishNumber()
        return formatter.string(from: date)
    }
    
    class func changeRToL(){
        UIFont.overrideInitialize()
        let widow = (UIApplication.shared.delegate as? AppDelegate)?.window
      
      let vc = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "homeNav")
            widow?.rootViewController = vc
       
    }
    
    class func makePhoneCall(_ vc:UIViewController ,mobile:String) {
        if   mobile == "" {
            Utilities.showAlert(vc, messageToDisplay: "لا يوجد رقم متاح الآن")
        }else{
            
            let urlPhone = "tel://\(mobile)"
            if let urlString = urlPhone.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                
                if let phoneURL = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(phoneURL) {
                        UIApplication.shared.openURL(phoneURL)
                    } else {
                        Utilities.showAlert(vc, messageToDisplay: "لا يوجد رقم متاح الآن")
                    }
                }
            }
        }
    }
    
    class func handelDropDowenUI(_ sender: UIView,dropDown:DropDown){
           dropDown.anchorView = sender
           dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
           dropDown.backgroundColor = UIColor.white
       }
       
    class func showDropDowenUI(_ sender:UIButton = UIButton(),dropDown:DropDown,dataAr:[String],placeHolder:String = "",callBack: @escaping (Int,String) -> ()) -> Void {
           var mdata :[String] = []
           mdata = dataAr
           if mdata.count == 0 {
               mdata.append(NSLocalizedString("No Data Found", comment: ""))
            }
            dropDown.dataSource = mdata
            dropDown.selectionAction = {(index: Int, item: String) in
                              
               if dataAr.count == 0 {
                   return
               }
            if placeHolder != "" {
                
                sender.setTitle(NSLocalizedString("\(placeHolder)", comment: "")+"(\(item))", for: .normal)
            }
           callBack(index,item)
               
           }
           dropDown.show()
       }
    
  
    class  func dowinloadImage(_ urlString:String?,block:@escaping (UIImage?,Data) -> ()) -> Void {
        if urlString != nil && urlString != ""{
            let imgURL: URL = URL(string: urlString ?? "www.google.com")!
            let request: URLRequest = URLRequest(url: imgURL)
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: {
                (data, response, error) -> Void in
                
                if (error == nil && data != nil) {
                    func display_image() {
                        let userImage = UIImage(data: data!)
                        block(userImage, data ?? Data())
                    }
                    DispatchQueue.main.async(execute: display_image)
                }else {
                    block(UIImage(named: "placeholder2")!,Data())
                }
            })
            task.resume()
        }
    }
    
  
    class func delay(_ t:Double = 0.1,callBack : @escaping () -> ()) -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + t){
            callBack()
        }
    }
    
    class func XibVC(_ vcIdentifire:String,owner:UIViewController)->UIViewController{
        return Bundle.main.loadNibNamed(vcIdentifire, owner: owner, options: nil)?[0] as! UIViewController
    }
    class func openXibPopup(source:UIViewController,
                         destination:UIViewController,
                         identifier:String,
                         width:CGFloat = (UIScreen.main.bounds.width - 30),
                         height:CGFloat = (UIScreen.main.bounds.height-100),
                         color:UIColor = UIColor.black){
       
        let popupSegue = CCMPopupSegue(identifier:identifier, source: source, destination: destination)
        PopupSettings(popupSegue, width: width, height: height, color: color)
        popupSegue.perform()
        
    }
    
    class func openPopup(_ segue:UIStoryboardSegue,width:CGFloat = (UIScreen.main.bounds.width - 30),height:CGFloat = (UIScreen.main.bounds.height-100),color:UIColor = UIColor.black){
        let popupSegue = segue as! CCMPopupSegue
        PopupSettings(popupSegue, width: width, height: height, color: color)
    }
    
    class func PopupSettings(_ popupSegue:CCMPopupSegue,width:CGFloat,height:CGFloat,color:UIColor){
        popupSegue.destinationBounds = CGRect(x: 0, y: 0 , width: width , height:height)
        popupSegue.backgroundBlurRadius = 0.7
        popupSegue.backgroundViewAlpha = 0.7
        popupSegue.backgroundViewColor = color
        popupSegue.dismissableByTouchingBackground = false
    }
    
    class func openLink(_ link:String?){
        if let url = URL(string: link ?? ""){
            UIApplication.shared.openURL(url)
        }else {
            Toast(text: NSLocalizedString("No Link Found!", comment: "")).show()
        }
    }
    
    
    var profileUser :Int?  //1 teacher //2 student
    
   
    
    struct Singleton {
        static let instance = Utilities()
    }
    
    class var sharedInstance: Utilities {
        return Singleton.instance
    }

    
    //MARK: - Email verification
    static func verifyEmail(_ email : String) -> Bool
    {
      if email != "" {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
      }else{
        return true
      }
    }
    

    
    //MARK: -Apply Shadow
    static func applyPlainShadow(_ view: UIView,color : UIColor ,shadowOpacity :Float, shadowRadius : CGFloat, shadowSize : CGSize) {
        let layer = view.layer
        
        layer.shadowColor = color.cgColor
        layer.shadowOffset = shadowSize
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    //MARK: -Alert Controller
    static func showAlert(_ viewController : UIViewController,messageToDisplay : String ) -> Void
    {
        

        
        let alertController = UIAlertController(title: "", message: messageToDisplay, preferredStyle: .alert)
        //NSLocalizedString("Choose Language", comment: "")
        let defaultAction = UIAlertAction(title: NSLocalizedString("Done", comment: ""), style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        alertController.dismiss(animated: true, completion: nil)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert(_ viewController : UIViewController,DoneBTSTR:String  = NSLocalizedString("Done", comment: ""),messageToDisplay : String,callBack:@escaping () -> ()) -> Void
    {
        

        
        let alertController = UIAlertController(title: "", message: messageToDisplay, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: DoneBTSTR, style: .default, handler: { (action) in
            callBack()
        }))
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        //alertController.dismiss(animated: true, completion: nil)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    static func showloginAlert(_ vc : UIViewController,messageToDisplay : String  = NSLocalizedString("Please Login To Continue!", comment: "")) -> Void
    {
        
        
        let alertController = UIAlertController(title: "", message: messageToDisplay, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Login", comment: ""), style: .default, handler: { (action) in
            vc.performSegue(withIdentifier: "login", sender: nil)
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        
        vc.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: -ROUND Image
    static func roundImageView (_ imageView : UIImageView)-> Void
    {
        imageView.layer.cornerRadius = imageView.bounds.size.height / 2
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
       // imageView.layer.borderColor = UIColor(red: 253, green: 253, blue: 253).cgColor
    }
    
    //MARK: -ROUND Image
    static func roundView (_ view : UIView)-> Void
    {
        view.layer.cornerRadius = view.bounds.size.height / 2
        view.layer.masksToBounds = false
        view.clipsToBounds = true
    }
    
    static func roundCornerView (_ view : UIView, radius : CGFloat)-> Void
    {
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
    }
    
    //MARK: -SCREEN WIDTH / HEIGHT
    static func getWidth() -> CGFloat
    {
        return UIScreen.main.bounds.size.width;
    }
    
    static func getHeight() -> CGFloat
    {
        return UIScreen.main.bounds.size.height;
    }
    
    //MARK: -Date
    static func getDateFromString(_ dateString : String, format : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    static func getDifferenceBetweenTwoDates( _ firstDate : Date , secondDate : Date) -> Int
    {
        let flags = NSCalendar.Unit.year
        let calendar: Calendar = Calendar.current
        let components = (calendar as NSCalendar).components(flags, from: firstDate , to: secondDate, options: [])
        return components.year!
    }
    
    //MARK: -Internet connexion
//    static func isReacheable() -> Bool {
//       // return Reachability.isConnectedToNetwork()
//    }
    
    static func heightWithConstrainedWidth(textLabel: String,width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = textLabel.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height + 10
    }
    
    //MARK: -Image resize
    
    static func imageWithSize(image: UIImage,size: CGSize)->UIImage{
        
        UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale);
        
        image.draw(in: CGRect(x:0, y:0, width: size.width, height: size.height));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage!;
    }
    
    static func resizeImageWithAspect(image: UIImage,scaledToMaxWidth width:CGFloat,maxHeight height :CGFloat)->UIImage
    {
        let oldWidth = image.size.width;
        let oldHeight = image.size.height;
        
        let scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
        
        let newHeight = oldHeight * scaleFactor;
        let newWidth = oldWidth * scaleFactor;
        let newSize = CGSize(width : newWidth,height :newHeight);
        
        return imageWithSize(image: image, size: newSize);
    }
    
    //MARK: -Get week day
    static func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let todayDate = formatter.date(from: today) {
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: todayDate)
            return weekDay
        } else {
            return nil
        }
    }
    
    //MARK : -set custom font to label
    // MARK: - Setting fonts
    static func setFonts(mutableDescription :NSMutableAttributedString ,rangeString : String,fontName : String, fontSize : CGFloat, color : UIColor) -> () {
        // set fonts
        let rangeMarkString = (mutableDescription.string as NSString).range(of:rangeString) as NSRange
        
        
        mutableDescription.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: rangeMarkString)
    }
    
    static func imageWithImage(_ image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
