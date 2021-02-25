//
//  productDetailsTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/27/20.
//

import UIKit

class productDetailsTVC: UITableViewController {

  @IBOutlet weak var detailsBg: UIView!
  @IBOutlet weak var ratingBg: UIView!
  @IBOutlet weak var boxPriceBg: UIView!
  @IBOutlet weak var kiloPriceBg: UIView!
  @IBOutlet weak var ratingTitleBg: UIView!
  @IBOutlet weak var NextIcon: UIImageView!
  
  @IBOutlet weak var kiloOldPriceLb: UILabel!
  @IBOutlet weak var boxOldPriceLb: UILabel!
  
  var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
  
  override func viewDidLoad() {
        super.viewDidLoad()
    Utilities.addLogoTitleView(self)
    detailsBg.dropShadow(roundCorner:15)
    ratingBg.dropShadow(roundCorner:15)
    self.navigationItem.backBarButtonItem?.title = ""

    if Language.currentLanguage() == "ar" {
      NextIcon.image = #imageLiteral(resourceName: "backAr")
    }else {
      NextIcon.image = #imageLiteral(resourceName: "backEn")
    }

    ratingTitleBg.round([.topLeft,.topRight], corner: 15)
    boxPriceBg.round((Language.currentLanguage() == "ar") ? [.bottomLeft]:[.bottomRight], corner: 15)
    kiloPriceBg.round((Language.currentLanguage() == "ar") ? [.bottomRight]:[.bottomLeft], corner: 15)
    
    kiloOldPriceLb.attributedText = "30 SAR".strikeThrough(.red)
    boxOldPriceLb.attributedText = "30 SAR".strikeThrough(.red)
  
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "report" {
      super.prepare(for: segue, sender: sender)
      self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
      halfModalTransitioningDelegate?.screenHeight = 3
      segue.destination.modalPresentationStyle = .custom
      segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
    }
  }
  @IBAction func cartAction(_ sender: UIButton) {
    let vc = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: mainTabBarVC.identifier) as? mainTabBarVC
    vc?.selectedIndex = 0
    Utilities.root(vc!)
  }
  
  @IBAction func addTocartAction(_ sender: UIButton) {
    let vc = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: mainTabBarVC.identifier) as? mainTabBarVC
    vc?.selectedIndex = 0
    Utilities.root(vc!)
  }
  
  @IBAction func reportAction(_ sender: UIButton) {
    performSegue(withIdentifier: "report", sender: nil)
  }
  @IBAction func ratingAction(_ sender: UIButton) {
    performSegue(withIdentifier: "Retings", sender: nil)
  }
  

}
