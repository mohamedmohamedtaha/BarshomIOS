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
        var isValid = true
        var errorMessages: [String] = []
        if !ValidationHelper.isValidName(phoneTxt.text!) {
            isValid = false
            errorMessages.append(Resources.Login.mobileRequired)
        }
        
        if !isValid {
            AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
        } else {
            let parms = ["mobile":phoneTxt.text!]
            UserService.shared.forgetPassword(parameters: parms) { (datas,success) in
                if success
                {
                    self.performSegue(withIdentifier: "reset", sender: nil)
                    self.maximizeToFullScreen()
                }
            }
            
        }
    }
    
    
    
    @IBAction func dismissAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reset"
        {
            let vc = segue.destination as! resetCodeVC
            vc.mobile = phoneTxt.text!
        }
    }
}
