//
//  extentions.swift
//  derty
//
//  Created by Mohamed Elmakkawy on 5/31/20.
//  Copyright © 2020 Mohamed Elmakkawy. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults
import FirebaseMessaging
extension UINavigationController {
  func setBackgroundImage(_ image: UIImage) {
    navigationBar.isTranslucent = true
    navigationBar.barStyle = .blackTranslucent

    let logoImageView = UIImageView(image: image)
    logoImageView.contentMode = .scaleAspectFill
    logoImageView.clipsToBounds = true
    logoImageView.translatesAutoresizingMaskIntoConstraints = false

    view.insertSubview(logoImageView, belowSubview: navigationBar)
    NSLayoutConstraint.activate([
      logoImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
      logoImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
      logoImageView.topAnchor.constraint(equalTo: view.topAnchor),
      logoImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
    ])
  }
}

extension String {
    var Localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UIApplication {
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482458385
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag

                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}


extension UIView {
  func makeItCircle (){
      self.layer.cornerRadius = self.frame.width / 2
      self.layer.masksToBounds = true
      self.clipsToBounds = true
      self.layoutIfNeeded()
  }
  
  
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            self.clipsToBounds = true
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask

        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor = .lightGray,
                  opacity: Float = 0.5,
                  offSet: CGSize = CGSize(width: -1, height: 1),
                  radius: CGFloat = 3,
                  scale: Bool = true,
                  roundCorner :CGFloat = 20) {
    Utilities.delay(0.1) {
      self.layer.masksToBounds = false
      self.layer.shadowColor = color.cgColor
      self.layer.shadowOpacity = opacity
      self.layer.shadowOffset = offSet
      self.layer.shadowRadius = radius
     
      //layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: roundCorner).cgPath
      self.layer.shouldRasterize = true
      self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

  }
  
  func removeShadow() {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.clear.cgColor
    layer.shadowOpacity = 0
    layer.shouldRasterize = true
  }
  
  
  func round(_ RoundingCorners:UIRectCorner,corner:CGFloat){
    let bounds: CGRect = self.frame
    let maskPath = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: RoundingCorners,
                                cornerRadii: CGSize(width: corner, height: corner))
//    let maskLayer = CAShapeLayer()
//    maskLayer.bounds = bounds
//    maskLayer.path = maskPath.cgPath
//    self.layer.mask = maskLayer
    if #available(iOS 11.0, *){
        self.clipsToBounds = false
        self.layer.cornerRadius = corner
        var corn = CACornerMask()
            if RoundingCorners.contains(.allCorners) {
                corn = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner,.layerMinXMinYCorner,.layerMaxXMinYCorner]
            }
            if RoundingCorners.contains(.bottomLeft) {
                corn.insert(.layerMinXMaxYCorner)
            }
            if RoundingCorners.contains(.bottomRight) {
                corn.insert(.layerMaxXMaxYCorner)
            }
            if RoundingCorners.contains(.topLeft) {
                corn.insert(.layerMinXMinYCorner)
            }
            if RoundingCorners.contains(.topRight) {
                corn.insert(.layerMaxXMinYCorner)
            }
            self.layer.maskedCorners = corn
    }else{
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds,    byRoundingCorners: RoundingCorners, cornerRadii: CGSize(width: corner, height: corner)).cgPath
        self.layer.mask = rectShape
    }
  }
}


extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
    }
  func hideHairline() {
      if let hairline = findHairlineImageViewUnder(navigationBar) {
          hairline.isHidden = true
      }
  }
  func restoreHairline() {
      if let hairline = findHairlineImageViewUnder(navigationBar) {
          hairline.isHidden = false
      }
  }
  func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
      if view is UIImageView && view.bounds.size.height <= 1.0 {
          return view as? UIImageView
      }
      for subview in view.subviews {
          if let imageView = self.findHairlineImageViewUnder(subview) {
              return imageView
          }
      }
      return nil
  }
}
extension String {
  func strikeThrough(_ c:UIColor = UIColor.darkGray) -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughColor, value: c, range: NSMakeRange(0, attributeString.length))

        return attributeString
    }
}

extension UINavigationBar {

    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += 20
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        setBackgroundImage(gradientLayer.creatGradientImage(), for: UIBarMetrics.default)
    }
    
}

extension UIView {

    func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
         
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }

}

extension UITableViewCell {
    /// Returns a string representation of th   is class
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    
}
extension UICollectionViewCell {
    /// Returns a string representation of this class
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}

extension Date {
    public var timeAgoSince: String {
        
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])
        
        if let year = components.year, year >= 2 {
            return LanguageManager.isArabic ? "منذ \(year) سنوات" : "\(year) years ago"
        }
        
        if let year = components.year, year >= 1 {
            return LanguageManager.isArabic ? "منذ سنة" : "Last year"
        }
        
        if let month = components.month, month >= 2 {
            return LanguageManager.isArabic ? "منذ \(month) أشهر" :"\(month) months ago"
        }
        
        if let month = components.month, month >= 1 {
            return LanguageManager.isArabic ? "منذ شهر" :"Last month"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return LanguageManager.isArabic ? "منذ \(week) اسابيع" :"\(week) weeks ago"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return LanguageManager.isArabic ? "منذ إسبوع" :"Last week"
        }
        
        if let day = components.day, day >= 2 {
            return LanguageManager.isArabic ? "منذ \(day) أيام" :"\(day) days ago"
        }
        
        if let day = components.day, day >= 1 {
            return LanguageManager.isArabic ? "منذ أمس" :"Yesterday"
        }
        
        if let hour = components.hour, hour >= 2 {
            return LanguageManager.isArabic ? "منذ \(hour) ساعات" :"\(hour) hours ago"
        }
        
        if let hour = components.hour, hour >= 1 {
            return LanguageManager.isArabic ? "منذ ساعة" :"An hour ago"
        }
        
        if let minute = components.minute, minute >= 2 {
            return LanguageManager.isArabic ? "منذ \(minute) دقيقة" : "\(minute) minutes ago"
        }
        
        if let minute = components.minute, minute >= 1 {
            return LanguageManager.isArabic ? "منذ دقيقة" :"A minute ago"
        }
        
        if let second = components.second, second >= 3 {
            return LanguageManager.isArabic ? "منذ \(second) ثانية" : "\(second) seconds ago"
        }
        
        return LanguageManager.isArabic ? "الأن" :"Just now"
        
    }
    var trimTime: Date {
        
        
        
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        
        
        //        let components = cal.components([.Day, .Month, .Year], fromDate: self)
        return (cal as NSCalendar).date(bySettingHour: 2, minute: 0, second: 0, of: self, options: NSCalendar.Options())!
    }
    struct Formatter {
        static let customDate: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            //2017-12-20 16:21:51
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter
        }()
    }
}
public extension UIImage {

    func rotate(radians: CGFloat) -> UIImage {
            let rotatedSize = CGRect(origin: .zero, size: size)
                .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
                .integral.size
            UIGraphicsBeginImageContext(rotatedSize)
            if let context = UIGraphicsGetCurrentContext() {
                let origin = CGPoint(x: rotatedSize.width / 2.0,
                                     y: rotatedSize.height / 2.0)
                context.translateBy(x: origin.x, y: origin.y)
                context.rotate(by: radians)
                draw(in: CGRect(x: -origin.y, y: -origin.x,
                                width: size.width, height: size.height))
                let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()

                return rotatedImage ?? self
            }

            return self
        }
    func handleOrientation() -> UIImage
    {
        let src = self
            if src.imageOrientation == UIImage.Orientation.up {
                return src
            }
            var transform: CGAffineTransform = CGAffineTransform.identity
            switch src.imageOrientation {
            case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
                transform = transform.translatedBy(x: src.size.width, y: src.size.height)
                transform = transform.rotated(by: CGFloat(Double.pi))
                break
            case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
                transform = transform.translatedBy(x: src.size.width, y: 0)
                transform = transform.rotated(by: CGFloat(Double.pi/2))
                break
            case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
                transform = transform.translatedBy(x: 0, y: src.size.height)
                transform = transform.rotated(by: CGFloat(-(Double.pi/2)))
                break
            case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
                break
            }
            
            switch src.imageOrientation {
            case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
                transform.translatedBy(x: src.size.width, y: 0)
                transform.scaledBy(x: -1, y: 1)
                break
            case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
                transform.translatedBy(x: src.size.height, y: 0)
                transform.scaledBy(x: -1, y: 1)
            case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
                break
            }
            
            let ctx:CGContext = CGContext(data: nil, width: Int(src.size.width), height: Int(src.size.height), bitsPerComponent: (src.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (src.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
            
            ctx.concatenate(transform)
            
            switch src.imageOrientation {
            case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
                ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.height, height: src.size.width))
                break
            default:
                ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.width, height: src.size.height))
                break
            }
            
            let cgimg:CGImage = ctx.makeImage()!
            let img:UIImage = UIImage(cgImage: cgimg)
            
            return img
        }
    /**
    Returns the flat colorized version of the image, or self when something was wrong

    - Parameters:
        - color: The colors to user. By defaut, uses the ``UIColor.white`

    - Returns: the flat colorized version of the image, or the self if something was wrong
    */
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in PNG format
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the PNG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    var png: Data? { return self.pngData() }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
    func flipImage() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: self.size.width, y: self.size.height)
        context.scaleBy(x: -self.scale, y: -self.scale)
        
        context.draw(self.cgImage!, in: CGRect(origin:CGPoint.zero, size: self.size))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    func colorized(with color: UIColor = .white) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }


        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        color.setFill()
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: rect, mask: cgImage)
        context.fill(rect)

        guard let colored = UIGraphicsGetImageFromCurrentImageContext() else { return self }

        return colored
    }

    /**
    Returns the stroked version of the fransparent image with the given stroke color and the thickness.

    - Parameters:
        - color: The colors to user. By defaut, uses the ``UIColor.white`
        - thickness: the thickness of the border. Default to `2`
        - quality: The number of degrees (out of 360): the smaller the best, but the slower. Defaults to `10`.

    - Returns: the stroked version of the image, or self if something was wrong
    */

    func stroked(with color: UIColor = .white, thickness: CGFloat = 2, quality: CGFloat = 10) -> UIImage {

        guard let cgImage = cgImage else { return self }

        // Colorize the stroke image to reflect border color
        let strokeImage = colorized(with: color)

        guard let strokeCGImage = strokeImage.cgImage else { return self }

        /// Rendering quality of the stroke
        let step = quality == 0 ? 10 : abs(quality)

        let oldRect = CGRect(x: thickness, y: thickness, width: size.width, height: size.height).integral
        let newSize = CGSize(width: size.width + 2 * thickness, height: size.height + 2 * thickness)
        let translationVector = CGPoint(x: thickness, y: 0)


        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)

        guard let context = UIGraphicsGetCurrentContext() else { return self }

        defer {
            UIGraphicsEndImageContext()
        }
        context.translateBy(x: 0, y: newSize.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.interpolationQuality = .high

        for angle: CGFloat in stride(from: 0, to: 360, by: step) {
            let vector = translationVector.rotated(around: .zero, byDegrees: angle)
            let transform = CGAffineTransform(translationX: vector.x, y: vector.y)

            context.concatenate(transform)

            context.draw(strokeCGImage, in: oldRect)

            let resetTransform = CGAffineTransform(translationX: -vector.x, y: -vector.y)
            context.concatenate(resetTransform)
        }

        context.draw(cgImage, in: oldRect)

        guard let stroked = UIGraphicsGetImageFromCurrentImageContext() else { return self }

        return stroked
    }
}
extension UIViewController {
    
    func updateUserToken()
    {
        if UserManager.isLoggedIn {
            Messaging.messaging().token  { result, error in
                if let error = error {
                    print("Error fetching remote instange ID: \(error)")
                } else if let result = result {
                    print("Remote instance ID token: \(result)")
                    UserService.shared.updateUserToken(token: result)
                }
            }
        }
    }
    func addCartBarButton(count: Int)
    {
        let badgeBtn = BadgedButtonItem(with: #imageLiteral(resourceName: "cartWhit"))
        badgeBtn.setBadge(with: cartList.count)
        badgeBtn.tapAction = {
            if !UserManager.isLoggedIn
            {
                AppHelper.showLoginAlert(vc: self)
                return
            }
            
            
            if UserManager.getUserData!.cat_name == "متاجر"{
                let vc1 = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "cartVCC") as! cartVC
                vc1.isFromMtager = true
                self.navigationController?.pushViewController(vc1, animated: true)
                
            }else {
                
                let vc = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: mainTabBarVC.identifier) as? mainTabBarVC
                vc?.selectedIndex = 0
                Utilities.root(vc!)
                
            }
                       
        }
        navigationItem.rightBarButtonItem = badgeBtn

    }
    
    func MakeHomeRoot()
    {
        if UserManager.isLoggedIn {
            print("user type = " + UserManager.getUserData!.adv_type!)
            switch UserManager.getUserData!.adv_type {
            case "user":
              let mainTab = mainTabBarVC.instantiate(.Main)
              Utilities.root(mainTab)
            case "company":
              let nav = AppStoryboard.traderOrders.instance.instantiateViewController(withIdentifier: "traderNav")
              Utilities.root(nav)
            case "worker":
              let nav = AppStoryboard.driverOrders.instance.instantiateViewController(withIdentifier: "driverNav")
              Utilities.root(nav)
            default:
                let mainTab = mainTabBarVC.instantiate(.Main)
                Utilities.root(mainTab)
            }
        }
        else
        {
            let mainTab = mainTabBarVC.instantiate(.Main)
            Utilities.root(mainTab)
        }
        
    }
    /// Returns a string representation of this class
    class var identifier: String {
        return String(describing: self)
    }
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    func goToLogin() {
        
        let nav = AppStoryboard.registration.instance.instantiateViewController(withIdentifier: "loginNav")
        present(nav, animated: true, completion: nil)
    }
    func PushToControllerWithIdentifier(storyBoard:UIStoryboard, identifier : String)
    {
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func PresentControllerWithIdentifier(storyBoard:UIStoryboard, identifier : String)
    {
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.present(vc, animated: true)
    }
    
    
    func delay(time: Double, closure:@escaping ()->()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+time, execute: {
            closure()
        })
        
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension UITableView {
    private func reuseIndentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }

    public func register<T: UITableViewCell>(_ cell: T.Type) {
        register(T.self, forCellReuseIdentifier: reuseIndentifier(for: cell))
    }

    public func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: reuseIndentifier(for: headerFooterView))
    }

    public func dequeueCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: reuseIndentifier(for: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell.")
        }

        return cell
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for type: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: reuseIndentifier(for: type)) as? T else {
            fatalError("Failed to dequeue footer view.")
        }

        return view
    }
}

extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 0, y: 0)
    }
    
    func creatGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}

extension UIImageView{
  func changeTintColor(_ color:UIColor){
    self.image = self.image?.withRenderingMode(.alwaysTemplate)
    self.tintColor = color
  }
}
extension UIViewController {
    func setStatusBarStyle(_ style: UIStatusBarStyle) {
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusBar.backgroundColor = style == .lightContent ? UIColor.black : .white
            statusBar.setValue(style == .lightContent ? UIColor.white : .black, forKey: "foregroundColor")
        }
    }
}


public extension UIDevice {
    enum deviceType {
        case iPodTouch5
        case iPodTouch6
        case iPhone4
        case iPhone4s
        case iPhone5
        case iPhone5c
        case iPhone5s
        case iPhone6
        case iPhone6s
        case iPhone6Plus
        case iPhone6sPlus
        case iPhone7
        case iPhone7Plus
        case iPhoneSE
        case iPad2
        case iPad3
        case iPad4
        case iPadAir
        case iPadAir2
        case iPadMini
        case iPadMini2
        case iPadMini3
        case iPadMini4
        case iPadPro
        case appleTv
        case Simulator
        case identifier
    }
    
    func getPlatformNSString()->String {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            let DEVICE_IS_SIMULATOR = true
        #else
            let DEVICE_IS_SIMULATOR = false
        #endif
        
        var machineSwiftString : String = ""
        
        if DEVICE_IS_SIMULATOR == true
        {
            // this neat trick is found at http://kelan.io/2015/easier-getenv-in-swift/
            if let dir = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineSwiftString = dir
            }
        } else {
            var size : size_t = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            machineSwiftString = String(describing: machine)
        }
        
        //print("machine is \(machineSwiftString)")
        return machineSwiftString
    }
    
    
    
    var modelName: deviceType {
        
        let identifierSimulator = getPlatformNSString()
        
        
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifierIphone = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        var identifier :String = ""
        
        if identifierIphone == "i386" ||  identifierIphone == "x86_64" {
            identifier=identifierSimulator
        }else {
            identifier=identifierIphone
        
        }
        print("identifier=\(identifier)")
        
        switch identifier {
            
        case "iPod5,1":                                 return .iPodTouch5
        case "iPod7,1":                                 return .iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return .iPhone4
        case "iPhone4,1":                               return .iPhone4s
        case "iPhone5,1", "iPhone5,2":                  return .iPhone5
        case "iPhone5,3", "iPhone5,4":                  return .iPhone5c
        case "iPhone6,1", "iPhone6,2":                  return .iPhone5s
        case "iPhone7,2":                               return .iPhone6
        case "iPhone7,1":                               return .iPhone6Plus
        case "iPhone8,1":                               return .iPhone6s
        case "iPhone8,2":                               return .iPhone6sPlus
        case "iPhone9,1", "iPhone9,3":                  return .iPhone7
        case "iPhone9,2", "iPhone9,4":                  return .iPhone7Plus
        case "iPhone8,4":                               return .iPhoneSE
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           return .iPadAir
        case "iPad5,3", "iPad5,4":                      return .iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":           return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return .iPadMini3
        case "iPad5,1", "iPad5,2":                      return .iPadMini4
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return .iPadPro
        case "AppleTV5,3":                              return .appleTv
        case "i386", "x86_64":                          return .Simulator
        default:                                        return .identifier
        }
    }
    
}

extension DefaultsKeys {
    

    var phone : DefaultsKey<String?> { .init("phone")}
    var deviceToken : DefaultsKey<String?> { .init("deviceToken")}
    var UserType : DefaultsKey<String?> { .init("UserType")}
    var delevaryType : DefaultsKey<String?> { .init("delevaryType")}
    var selectedAddress : DefaultsKey<String?> { .init("selectedAddress")}
    var selectedAddressName : DefaultsKey<String?> { .init("selectedAddressName")}
    var selectedAddressDetails : DefaultsKey<String?> { .init("selectedAddressDetails")}
    var branchId : DefaultsKey<String?> { .init("branchId")}
    var branchName : DefaultsKey<String?> { .init("branchName")}
    var branchLat : DefaultsKey<String?> { .init("branchLat")}
    var branchLng : DefaultsKey<String?> { .init("branchLng")}
  
    var locationLat : DefaultsKey<String?> { .init("locationLat")}
    var locationLng : DefaultsKey<String?> { .init("locationLng")}
    ///
    var user_id : DefaultsKey<String?> { .init("user_id") }
    var userName : DefaultsKey<String?>{ .init("userName")}
    var passWord : DefaultsKey<String?>{ .init("passWord")}
    var image : DefaultsKey<String?>{.init("image")}
    var cartNumber : DefaultsKey<String?>{.init("cartNumber")}
    var initapp : DefaultsKey<String?>{.init("initapp")}
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}




extension String {
    var encode: String {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decode: String {
        return self.removingPercentEncoding!
    }
    func ENumbers() -> String {
        let Formatter: NumberFormatter = NumberFormatter()
        Formatter.locale = Locale(identifier: "EN")
        let final = Formatter.number(from: self)
        return String(describing: final!)
    }
    
    func en()-> String {
      
        let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "٤", "5" : "۵", "6" : "٦", "7" : "۷", "8" : "۸", "9" : "۹"]
        var str : String = self
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: value, with: key)
        }
        
        return str
    }
    
    
    func englishNumber() ->String {
        var temp = self
        temp = temp.replacingOccurrences(of: "٠", with: "0")
        temp = temp.replacingOccurrences(of: "١" , with:"1")
        temp = temp.replacingOccurrences(of: "٢" , with:"2")
        temp = temp.replacingOccurrences(of: "٣" , with:"3")
        temp = temp.replacingOccurrences(of: "٤" , with:"4")
        temp = temp.replacingOccurrences(of: "٥" , with:"5")
        temp = temp.replacingOccurrences(of: "٦" , with:"6")
        temp = temp.replacingOccurrences(of: "٧" , with:"7")
        temp = temp.replacingOccurrences(of: "٨" , with:"8")
        temp = temp.replacingOccurrences(of: "٩" , with:"9")
        return temp
    }
    
    
    func hideSpace() ->String {
        var temp = self
        temp = temp.replacingOccurrences(of: " ", with: "")
        return temp
    }
    
    
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var unescaped: String {
        let entities = ["\0": "\\0",
                        "\t": "\\t",
                        "\n": "\\n",
                        "\r": "\\r",
                        "\"": "\\\"",
                        "\'": "\\'",
                        ]
        
        return entities
            .reduce(self) { (string, entity) in
                string.replacingOccurrences(of: entity.value, with: entity.key)
            }
            .replacingOccurrences(of: "\\\\(?!\\\\)", with: "", options: .regularExpression)
            .replacingOccurrences(of: "\\\\", with: "\\")
            .replacingOccurrences(of: "\\", with: "")
            .replacingOccurrences(of: "'", with: "\"")
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
        func convertToDictionary() -> [String: Any]? {
            
            if let data = self.unescaped.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch {
                    print(error.localizedDescription)
                }
            }
            return nil
        
    }
    var hhMMToDate: Date? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = TimeZone.current
            
            let date = dateFormatter.date(from: self)
            return date
        }
    }
    
    var fromStringToHourOnly : String?
    {
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            formatter.locale = Locale(identifier: LanguageManager.isArabic ? "ar" : "en")

            let formatter2 = DateFormatter()
            formatter2.locale = Locale(identifier: LanguageManager.isArabic ? "ar" : "en")
            formatter2.dateFormat = "h a"
            
            let date1 = formatter.date(from: self)
            
            return formatter2.string(from: date1!)

        }
    }
    
    func fromString_MMMM_dd_yyyy_HH_mm() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy HH:mm"
        
        if dateFormatter.date(from: self) != nil {
            return dateFormatter.date(from: self)!
        }
        
        return nil
    }
    
    func fromString_MMMM_dd_yyyy() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        if dateFormatter.date(from: self) != nil {
            return dateFormatter.date(from: self)!
        }
        
        return nil
    }
    
    func chopPrefix(_ count: Int = 1) -> String {
        return self != "" ?
            String(self[index(startIndex, offsetBy: count)...]) :
            ""
    }
    
    func chopSuffix(_ count: Int = 1) -> String {
        return self != "" ?
            String(self[..<index(endIndex, offsetBy: -count)]) :
            ""
    }
    
    public func contains(_ string: String) -> Bool {
        return self.isEmpty ? false :
            self.lowercased().range(of: (string).lowercased()) != nil
    }
    

    public var ConvertToDate: Date
    {
        let dateString = self
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "US")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "MM-dd-yyyy"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        if dateString == ""
        {
            return Date()
        }
        return dateFormatter.date(from:dateString)!
    }
    
    public func toDate(format: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if dateFormatter.date(from: self) != nil {
            return dateFormatter.date(from: self)!
        }
        return nil
    }
    var toDate : Date?
    {
        let dateString = self
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss Z"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "MM-dd-yyyy"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if dateFormatter.date(from: dateString) != nil {
            return dateFormatter.date(from: dateString)!
        }
        if dateString == ""
        {
            return Date()
        }
        return dateFormatter.date(from:dateString)!
    }
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeACall() {
//        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
//    }
}





extension CGPoint {
    /**
    Rotates the point from the center `origin` by `byDegrees` degrees along the Z axis.

    - Parameters:
        - origin: The center of he rotation;
        - byDegrees: Amount of degrees to rotate around the Z axis.

    - Returns: The rotated point.
    */
    func rotated(around origin: CGPoint, byDegrees: CGFloat) -> CGPoint {
        let dx = x - origin.x
        let dy = y - origin.y
        let radius = sqrt(dx * dx + dy * dy)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + byDegrees * .pi / 180.0 // to radians
        let x = origin.x + radius * cos(newAzimuth)
        let y = origin.y + radius * sin(newAzimuth)
        return CGPoint(x: x, y: y)
    }
}
public extension UITextField {
    
    public func applyBottomBorderStyle() {
        self.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0,
                              y: self.frame.size.height - width,
                              width:  self.frame.size.width,
                              height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    public func addImageToLeft(
        imageName: String,
        width: CGFloat = 20,
        height: CGFloat = 20) {
        
        let padding: CGFloat = 8
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: width + padding, height: height + padding))
        let imageView = UIImageView(frame: CGRect(x: padding / 2, y: padding / 2, width: width, height: height))
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        outerView.addSubview(imageView)
        
        self.leftView = outerView
        self.leftViewMode = .always
    }
    
    public func addImageToRight(
        imageName: String,
        width: CGFloat = 20,
        height: CGFloat = 20) {
        
        let padding: CGFloat = 8
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: width + padding, height: height + padding))
        let imageView = UIImageView(frame: CGRect(x: padding / 2, y: padding / 2, width: width, height: height))
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        outerView.addSubview(imageView)
        
        self.rightView = outerView
        self.rightViewMode = .always
    }
    
//    public func useThemeFont(style: FontStyle = .regular) {
////        self.font = Font.getForSize(size: self.font?.pointSize ?? Font.defaultSize, style: style)
//        self.font = UIFont(name: ThemeHelper.fontName, size: self.font!.pointSize)
//
//    }
    
    public func validateRequired() {
        if self.text == nil || self.text!.isEmpty {
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
            self.layer.cornerRadius = 3
        } else {
            let defaultTextField = UITextField(frame: self.frame)
            self.layer.borderColor = defaultTextField.layer.borderColor
            self.layer.borderWidth =  defaultTextField.layer.borderWidth
            self.layer.cornerRadius =  defaultTextField.layer.cornerRadius
        }
    }
    public func addImage(
        imageName: String,
        width: CGFloat = 20,
        height: CGFloat = 20) {
        
        let padding: CGFloat = 8
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: width + padding, height: height + padding))
        let imageView = UIImageView(frame: CGRect(x: padding / 2, y: padding / 2, width: width, height: height))
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        outerView.addSubview(imageView)
        
        if LanguageManager.isArabic {
            self.leftView = outerView
            self.leftViewMode = .always
            self.rightView = nil
            self.rightViewMode = .never
        } else {
            self.rightView = outerView
            self.rightViewMode = .always
            self.leftView = nil
            self.leftViewMode = .never
        }
        
    }
    
    func addAccessoryView(target: Any?, doneAction: Selector?, cancelAction: Selector?) {
        
        let toolbar = UIToolbar()
        toolbar.backgroundColor = UIColor.lightGray
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(
            title: Resources.Common.done,
            style: .done,
            target: target,
            action: doneAction)
        doneBtn.tintColor = Color.mainColor
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelBtn = UIBarButtonItem(
            title: Resources.Common.cancel,
            style: .plain,
            target: target,
            action: cancelAction)
        cancelBtn.tintColor = Color.tintGray
        
        toolbar.setItems([doneBtn, flexibleSpace, cancelBtn], animated: true)
        self.inputAccessoryView = toolbar
    }
    func checkAligment()
    {
        self.textAlignment = LanguageManager.isArabic ? .right : .left
    }
    func setPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
        
    }
    func setPaddingPointsLocale(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        if LanguageManager.isArabic
        {
            self.rightView = paddingView
            self.rightViewMode = .always
            self.leftView = nil
            self.leftViewMode = .never
        }
        else
        {
            self.leftView = paddingView
            self.leftViewMode = .always
            self.rightView = nil
            self.rightViewMode = .never
        }
        self.setNeedsLayout()
        
        
    }
}
