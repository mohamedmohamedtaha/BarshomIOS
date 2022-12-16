//
//  appLangVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/11/21.
//

import UIKit

class appLangVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func arabicClicked()
    {
        self.dismissAnimated()
        LanguageManager.currentLanguage = .ar
        MakeHomeRoot()
    }
    @IBAction func englishClicked()
    {
        self.dismissAnimated()
        LanguageManager.currentLanguage = .en
        MakeHomeRoot()
    }
        

}
