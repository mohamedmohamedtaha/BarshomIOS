//
//  forgetPasswordVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

class forgetPasswordVC: UIViewController ,HalfModalPresentable{

  @IBOutlet weak var phoneTxt: RVTxtFaild!
  
  override func viewDidLoad() {
        super.viewDidLoad()
      phoneTxt.AddImage(#imageLiteral(resourceName: "contact"))
   
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  
    minimizeToSize()
  }
  

  @IBAction func sendAction(_ sender: UIButton) {
    performSegue(withIdentifier: "reset", sender: nil)
    maximizeToFullScreen()
  }
  

  @IBAction func dismissAction(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}
