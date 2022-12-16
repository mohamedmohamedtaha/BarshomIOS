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
    class func opensheetSubPackageVC(_ selfVC:UIViewController,storeyBoard:AppStoryboard,order:Package) {
      let vc = storeyBoard.instance.instantiateViewController(withIdentifier: AppNavController.identifier) as! AppNavController
        (vc.topViewController as! editPackageTimesVC).packageData = order
   
      self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: selfVC, presentingViewController: vc)
        halfModalTransitioningDelegate?.screenHeight = 6
      vc.modalPresentationStyle = .custom
      vc.transitioningDelegate = self.halfModalTransitioningDelegate
      selfVC.present(vc, animated: true, completion: nil)
    }
    class func opensheetRateVC(_ selfVC:UIViewController,storeyBoard:AppStoryboard,order:Order) {
      let vc = storeyBoard.instance.instantiateViewController(withIdentifier: AppNavController.identifier) as! AppNavController
        (vc.topViewController as! rateVC).orderData = order
        (vc.topViewController as! rateVC).isProduct = false
      self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: selfVC, presentingViewController: vc)
        halfModalTransitioningDelegate?.screenHeight = 2.5
      vc.modalPresentationStyle = .custom
      vc.transitioningDelegate = self.halfModalTransitioningDelegate
      selfVC.present(vc, animated: true, completion: nil)
    }
    class func opensheetRateProductVC(_ selfVC:UIViewController,storeyBoard:AppStoryboard,order:String) {
      let vc = storeyBoard.instance.instantiateViewController(withIdentifier: AppNavController.identifier) as! AppNavController
        (vc.topViewController as! rateVC).productId = order
        (vc.topViewController as! rateVC).isProduct = true

      self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: selfVC, presentingViewController: vc)
        halfModalTransitioningDelegate?.screenHeight = 2.5
      vc.modalPresentationStyle = .custom
      vc.transitioningDelegate = self.halfModalTransitioningDelegate
      selfVC.present(vc, animated: true, completion: nil)
    }
    class func openQuantityVC(_ selfVC:UIViewController,storeyBoard:AppStoryboard,order:Products,delegate: addedCartDelegate) {
      let vc = storeyBoard.instance.instantiateViewController(withIdentifier: AppNavController.identifier+"Cart") as! AppNavController
        (vc.topViewController as! quantityVC).productData = order
        (vc.topViewController as! quantityVC).delegate = delegate

      self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: selfVC, presentingViewController: vc)
        halfModalTransitioningDelegate?.screenHeight = 2
      vc.modalPresentationStyle = .custom
      vc.transitioningDelegate = self.halfModalTransitioningDelegate
      selfVC.present(vc, animated: true, completion: nil)
    }
    class func opensheetCancelOrderVC(_ selfVC:UIViewController,storeyBoard:AppStoryboard,order:Order,delegate: reloadDelegate) {
      let vc = storeyBoard.instance.instantiateViewController(withIdentifier: AppNavController.identifier) as! AppNavController
        (vc.topViewController as! cancelOrderVC).orderData = order
        (vc.topViewController as! cancelOrderVC).delegate = delegate
      self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: selfVC, presentingViewController: vc)
        halfModalTransitioningDelegate?.screenHeight = 2.5
      vc.modalPresentationStyle = .custom
      vc.transitioningDelegate = self.halfModalTransitioningDelegate
      selfVC.present(vc, animated: true, completion: nil)
    }
    class func opensheetReportProductVC(_ selfVC:UIViewController,storeyBoard:AppStoryboard,order:Products,delegate: reloadDelegate) {
      let vc = storeyBoard.instance.instantiateViewController(withIdentifier: AppNavController.identifier) as! AppNavController
        (vc.topViewController as! reportVC).orderData = order
        (vc.topViewController as! reportVC).delegate = delegate
      self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: selfVC, presentingViewController: vc)
        halfModalTransitioningDelegate?.screenHeight = 2.5
      vc.modalPresentationStyle = .custom
      vc.transitioningDelegate = self.halfModalTransitioningDelegate
      selfVC.present(vc, animated: true, completion: nil)
    }
    class func opensheetDiscountVC(_ selfVC:UIViewController,storeyBoard:AppStoryboard,companyId:String,delegate: discountDelegate) {
      let vc = storeyBoard.instance.instantiateViewController(withIdentifier: AppNavController.identifier) as! AppNavController
        (vc.topViewController as! discountVC).companyId = companyId
        (vc.topViewController as! discountVC).delegate = delegate
      self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: selfVC, presentingViewController: vc)
        halfModalTransitioningDelegate?.screenHeight = 2.5
      vc.modalPresentationStyle = .custom
      vc.transitioningDelegate = self.halfModalTransitioningDelegate
      selfVC.present(vc, animated: true, completion: nil)
    }
    class func opensheetReportOrderVC(_ selfVC:UIViewController,storeyBoard:AppStoryboard,order:Order?,delegate: reloadDelegate?) {
      let vc = storeyBoard.instance.instantiateViewController(withIdentifier: AppNavController.identifier) as! AppNavController
        (vc.topViewController as! complaintVC).orderData = order
   
        if delegate != nil {
            (vc.topViewController as! complaintVC).delegate = delegate
        }
      self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: selfVC, presentingViewController: vc)
        halfModalTransitioningDelegate?.screenHeight = 3
      vc.modalPresentationStyle = .custom
      vc.transitioningDelegate = self.halfModalTransitioningDelegate
      selfVC.present(vc, animated: true, completion: nil)
    }
}
