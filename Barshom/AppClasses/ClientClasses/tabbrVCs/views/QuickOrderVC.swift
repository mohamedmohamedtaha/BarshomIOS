//
//  QuickOrderVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/28/20.
//

import UIKit

enum quickOrderType {
  case barshoomStore,otherStores
}
class QuickOrderVC: UIViewController ,HalfModalPresentable{

  @IBOutlet weak var barshoomBg: UIView!
  @IBOutlet weak var otherStoreBg: UIView!
  
  @IBOutlet weak var barshoomImg: UIImageView!
  @IBOutlet weak var otherStoreImg: UIImageView!
  
  @IBOutlet weak var barshoomBt: UIButton!
  @IBOutlet weak var otherStoreBt: UIButton!
  
  var type:quickOrderType?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      type = .barshoomStore
      selectStore(bg: barshoomBg, img: barshoomImg, bt: barshoomBt)
    }
  
  func selectStore(bg:UIView,img:UIImageView,bt:UIButton){
    barshoomBg.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
    otherStoreBg.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
    barshoomBg.dropShadow(roundCorner:20)
    otherStoreBg.dropShadow(roundCorner:20)
    barshoomImg.changeTintColor(Color.mainColor!)
    otherStoreImg.changeTintColor(Color.mainColor!)
    barshoomBt.backgroundColor = Color.mainColor!
    otherStoreBt.backgroundColor = Color.mainColor!
    bg.removeShadow()
    bg.layer.borderColor = Color.tintColor?.cgColor
    img.changeTintColor(Color.tintColor!)
    bt.backgroundColor = Color.tintColor!
    
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    minimizeToSize()
  }
    
  @IBAction func otherStoreAction(_ sender: UIButton) {
    type = .otherStores
    selectStore(bg: otherStoreBg, img: otherStoreImg, bt: otherStoreBt)
  }
  
  @IBAction func barshoomAction(_ sender: UIButton) {
    type = .barshoomStore
    selectStore(bg: barshoomBg, img: barshoomImg, bt: barshoomBt)
  }
  
  @IBAction func closeAction(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction func complateOrderAction(_ sender: UIButton) {
    switch type {
    case .barshoomStore:
      let vc = barshomStoreVC.instantiate(.Stores)
      self.navigationController?.show(vc, sender: nil)
      maximizeToFullScreen()
      
    case .otherStores:
      let vc = storesVC.instantiate(.Stores)
      self.navigationController?.show(vc, sender: nil)
      maximizeToFullScreen()
    default:
      break
    }
  }
  
}
