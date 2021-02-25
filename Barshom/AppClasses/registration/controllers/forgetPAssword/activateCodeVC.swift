//
//  activateCodeVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

class activateCodeVC: UIViewController {

  @IBOutlet weak var codeTxt: RVTxtFaild!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      codeTxt.AddImage(#imageLiteral(resourceName: "conditions"))
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  @IBAction func resetAction(_ sender: UIButton) {
    performSegue(withIdentifier: "reset", sender: nil)
  }
  
  
}
