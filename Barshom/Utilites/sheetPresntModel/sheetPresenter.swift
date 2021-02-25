//
//  sheetPresenter.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import Foundation
import UIKit

class sheetPresenter :NSObject {
  
  private static var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
  
  class func opensheetVC(_ selfVC:UIViewController,storeyBoard:AppStoryboard,screenHeight:CGFloat = 3) {
    let vc = storeyBoard.instance.instantiateViewController(withIdentifier: AppNavController.identifier) as! AppNavController
 
    self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: selfVC, presentingViewController: vc)
    halfModalTransitioningDelegate?.screenHeight = screenHeight
    vc.modalPresentationStyle = .custom
    vc.transitioningDelegate = self.halfModalTransitioningDelegate
    selfVC.present(vc, animated: true, completion: nil)
  }
}
