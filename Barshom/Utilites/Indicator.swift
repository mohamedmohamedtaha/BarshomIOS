//
//  indicator.swift
//  Nepros
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

public class Indicator {

//    var waveView: LCWaveView?
//    var backView: UIView! = UIView()
//    private let waveViewHeight: CGFloat = 130
//
    public struct Singleton {
        static let instance = Indicator()
    }

    public class var sharedInstance: Indicator {
        return Singleton.instance
    }

    init() {
//
//        backView.frame = CGRect(x: 0, y: 0, width: Constants.ScreenWidth, height: Constants.ScreenHeight)
//        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
//        waveView = LCWaveView(frame: CGRect(x: Constants.ScreenWidth / 2 - waveViewHeight / 2, y: Constants.ScreenHeight / 2 - waveViewHeight / 2, width: waveViewHeight, height: waveViewHeight), color: UIColor.black.withAlphaComponent(0.4))
//        waveView!.waveRate = 2
//        waveView!.waveSpeed = 0.3
//        waveView!.waveHeight = 80
//        waveView!.borderColor = ThemeHelper.Color.orange
//        waveView!.cornerRadius = waveView!.bounds.width / 2
//        waveView!.borderWidth = 3
//        waveView!.realWaveColor = ThemeHelper.Color.orange
//        waveView!.maskWaveColor = ThemeHelper.Color.orange
//        waveView!.centerImg = #imageLiteral(resourceName: "logo-en")
//        waveView!.centerImgSize = 100
//        waveView!.layer.masksToBounds = true
//        backView.addSubview(waveView!)

        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setDefaultMaskType(.clear)
//        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: (Constants.ScreenHeight/3)))
        SVProgressHUD.setBackgroundColor(Color.mainColor!)
        SVProgressHUD.setForegroundColor(UIColor.white)

        //        Progress = JGProgressHUD(style: JGProgressHUDStyle.dark)
        //        Progress?.textLabel.text = "Loading.."
    }
    public func show() {
        //        Progress?.show(in :vc.view)
        DimUtility.addDimView()
        DispatchQueue.main.async {
            SVProgressHUD.show()
//            self.waveView!.startWave()
//            AppHelper.rootViewController?.view.addSubview(self.backView)
        }
    }

    public func dismiss() {
        DimUtility.removeDimView()

        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
//            self.waveView!.stopWave()
//            self.waveView!.removeFromSuperview()
//             self.backView!.removeFromSuperview()
        }
    }

}
