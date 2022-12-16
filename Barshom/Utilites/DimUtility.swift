//
//  DimUtility.swift
//  Le Cadeau
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2016 AMIT-Software. All rights reserved.
//

import UIKit

public class DimUtility {
    
    fileprivate static var dimView: UIView! = UIView()
    
    public class func setDimViewStyles() {
        dimView.frame = CGRect(x: 0, y: 0, width: Constants.ScreenWidth, height: Constants.ScreenHeight)
        dimView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    }
    
    public class func addDimView() {
        AppHelper.rootViewController?.view.addSubview(dimView)
    }
    
    public class func removeDimView() {
        dimView.removeFromSuperview()
    }
    
}
