
//
//  Theme.swift
//  Pet Finder
//
//  Created by Essan Parto on 5/16/15.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import NitroUIColorCategories

struct Color {
    static let mainColor = UIColor(fromARGBHexString:"68B93C")
    static let tintGray = UIColor(fromARGBHexString:"AFAFAF")
    static let tintColor = UIColor(fromARGBHexString:"FB9600")
  
    static let selectPackge = UIColor(fromARGBHexString:"90CB70")
    static let unSelectPackge = UIColor(fromARGBHexString:"7FC359")
    static let borderViewColor = UIColor(fromARGBHexString:"E8E8E8")
}

enum Theme: Int {
  case Default, Dark

  var mainColor: UIColor {
    switch self {
    case .Default:
        return Color.mainColor!
    case .Dark:
      return Color.mainColor!
   
    }
  }

  var barStyle: UIBarStyle {
    switch self {
    case .Default:
      return .default
    case .Dark:
      return .black
    }
  }

  
  var backgroundColor: UIColor {
    switch self {
    case .Default:
      return UIColor(white: 0.9, alpha: 1.0)
    case .Dark:
      return UIColor(white: 0.8, alpha: 1.0)
    }
  }

  var secondaryColor: UIColor {
    switch self {
    case .Default:
      return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    case .Dark:
      return UIColor(red: 34.0/255.0, green: 128.0/255.0, blue: 66.0/255.0, alpha: 1.0)
    
    }
  }
}

let SelectedThemeKey = "SelectedTheme"

struct ThemeManager {

  static func currentTheme() -> Theme {
    if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
      return Theme(rawValue: storedTheme)!
    } else {
      return .Default
    }
  }

  static func applyTheme(theme: Theme) {
    UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
    UserDefaults.standard.synchronize()

    let sharedApplication = UIApplication.shared
    sharedApplication.delegate?.window??.tintColor = theme.mainColor

    UINavigationBar.appearance().barStyle = theme.barStyle
   
    UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")

    UITabBar.appearance().barStyle = theme.barStyle


    let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
    let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
    UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator

    let controlBackground = UIImage(named: "controlBackground")?
      .withRenderingMode(.alwaysTemplate)
      .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
    let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?
      .withRenderingMode(.alwaysTemplate)
      .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))

    UISegmentedControl.appearance().setBackgroundImage(controlBackground, for: .normal, barMetrics: .default)
    UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, for: .selected, barMetrics: .default)

    UIStepper.appearance().setBackgroundImage(controlBackground, for: .normal)
    UIStepper.appearance().setBackgroundImage(controlBackground, for: .disabled)
    UIStepper.appearance().setBackgroundImage(controlBackground, for: .highlighted)
    UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), for: .normal)
    UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), for: .normal)

    UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
    UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
      .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)), for: .normal)
    UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
      .withRenderingMode(.alwaysTemplate)
      .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)), for: .normal)

    UISwitch.appearance().onTintColor = theme.mainColor.withAlphaComponent(0.3)
    UISwitch.appearance().thumbTintColor = theme.mainColor

  }
}
