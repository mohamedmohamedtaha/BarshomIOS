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
    let bounds: CGRect = self.bounds
    let maskPath = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: RoundingCorners,
                                cornerRadii: CGSize(width: corner, height: corner))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = bounds
    maskLayer.path = maskPath.cgPath
    self.layer.mask = maskLayer
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
extension UIViewController {
    /// Returns a string representation of this class
    class var identifier: String {
        return String(describing: self)
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
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}


extension String {
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
    
    
    var toDate: Date {
        return Date.Formatter.customDate.date(from: self)!
    }
}

extension Date {
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

    /**
    Returns the flat colorized version of the image, or self when something was wrong

    - Parameters:
        - color: The colors to user. By defaut, uses the ``UIColor.white`

    - Returns: the flat colorized version of the image, or the self if something was wrong
    */
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
