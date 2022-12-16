//
//  contactUsTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

class contactUsTVC: baseTVC {

    @IBOutlet weak var userNameTxt: RVTxtFaild!
    @IBOutlet weak var emailTxt: RVTxtFaild!
    @IBOutlet weak var titleTxt: RVTxtView!
    @IBOutlet weak var whatsappBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Resources.Common.contactUs
        userNameTxt.AddImage(#imageLiteral(resourceName: "info"))
        emailTxt.AddImage(#imageLiteral(resourceName: "email"))
        titleTxt.addPadding(amount: 20)
        if UserManager.isLoggedIn
        {
            userNameTxt.text = UserManager.getUserData!.adv_name!
            emailTxt.text = UserManager.getUserData!.adv_email!
        }
        titleTxt.placeholder = Resources.Common.entermsgDetails
        whatsappBtn.isHidden = UserService.shared.currentAppSettings != nil ? !UserService.shared.currentAppSettings!.isAllowWhatsapp() : true
    
    }
    
    @IBAction func sendClicked()
    {
        UserService.shared.submitFeedback(comment: titleTxt.text!, name: userNameTxt.text!, email: emailTxt.text!){ (data) in
            AppHelper.showSuccessAlert(message: Resources.Common.msgSentSuccessfuly, confirmBtnTitle: Resources.Common.ok) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    @IBAction func whatsappClicked()
    {
        AppHelper.makeWhatsAppMsg(to: UserService.shared.currentAppSettings!.site_whatsapp ?? "0", content: "")
    }
    @IBAction func fbClicked()
    {
        AppHelper.openInWeb(instagramHandle: UserService.shared.currentAppSettings!.app_face ?? "0")
    }
    @IBAction func twitterClicked()
    {
        AppHelper.openInWeb(instagramHandle: UserService.shared.currentAppSettings!.app_twitter ?? "0")
    }
    @IBAction func googleClicked()
    {
        AppHelper.openInWeb(instagramHandle: UserService.shared.currentAppSettings!.app_gplus ?? "0")
    }
    @IBAction func instaClicked()
    {
        AppHelper.openInWeb(instagramHandle: UserService.shared.currentAppSettings!.app_ins ?? "0")
    }
    @IBAction func linkedClicked()
    {
        AppHelper.openInWeb(instagramHandle: UserService.shared.currentAppSettings!.app_linkedin ?? "0")
    }
}
