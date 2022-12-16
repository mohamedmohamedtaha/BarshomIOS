//
//  registerDriverTVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 20/05/2021.
//



import UIKit
import DropDown
import PopupDialog
import Photos
import AVFoundation
import MobileCoreServices

class registerDriverTVC: UITableViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

  @IBOutlet weak var nameTxt: RVTxtFaild!
  @IBOutlet weak var storeTxt: RVTxtFaild!
  @IBOutlet weak var mobileTxt: RVTxtFaild!
  @IBOutlet weak var emailTxt: RVTxtFaild!
  @IBOutlet weak var cityTxt: RVTxtFaild!
    @IBOutlet weak var carTypeTxt: RVTxtFaild!
    @IBOutlet weak var nationalIDTxt: RVTxtFaild!
    @IBOutlet weak var carPlateTxt: RVTxtFaild!

  @IBOutlet weak var bankNameTxt: RVTxtFaild!
  @IBOutlet weak var ownerNameTxt: RVTxtFaild!
  @IBOutlet weak var accountNumberTxt: RVTxtFaild!
  @IBOutlet weak var swiftCodeTxt: RVTxtFaild!
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var licenseIV: UIImageView!
    @IBOutlet weak var passwordTxt: RVTxtFaild!
    @IBOutlet weak var retypePasswordTxt: RVTxtFaild!
    @IBOutlet weak var chackBg: UIView!
    @IBOutlet weak var userCodeTxt: RVTxtFaild!
    @IBOutlet weak var clickHereLb: UILabel!

    var storeList = [Store]()
    var isAgree = false
    
      var dropDown = DropDown()
      var allCities = [City]()
    var selectedCity : City?
    var selectedStore : Store?
    var selectedImgAttach : Attachment?
    var selectedLicenseImgAttach : Attachment?
    var isUserImg = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = clientMenuType.registerRepresentative.rawValue.localized()

      nameTxt.AddImage(#imageLiteral(resourceName: "info"))
      storeTxt.AddImage(#imageLiteral(resourceName: "info"))
      mobileTxt.AddImage(#imageLiteral(resourceName: "contact"))
      emailTxt.AddImage(#imageLiteral(resourceName: "email"))
      cityTxt.AddImage(#imageLiteral(resourceName: "locate-1"))
        passwordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
        retypePasswordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
        carTypeTxt.AddImage(#imageLiteral(resourceName: "car"))
        carPlateTxt.AddImage(#imageLiteral(resourceName: "car"))
        nationalIDTxt.AddImage(#imageLiteral(resourceName: "storePaper"))
        userCodeTxt.AddImage(#imageLiteral(resourceName: "info"))

        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: LanguageManager.isArabic ? "شروط و أحكام المندوب" : "Driver Terms & Conditions", attributes: underlineAttribute)
        clickHereLb.attributedText = underlineAttributedString
    }
   
    func selectAgreeTerms(){
      if isAgree {
        chackBg.backgroundColor = Color.tintColor
      }else{
        chackBg.backgroundColor = .white
      }
    }
    @IBAction func termsClickedAction(_ sender: UIButton) {
        let vc = AppStoryboard.terms.instance.instantiateViewController(withIdentifier: "aboutVC") as! aboutVC
        vc.type = .terms
        vc.userType = "worker"
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func agreeTermsAction(_ sender: UIButton) {
      isAgree = !isAgree
      selectAgreeTerms()
    }
      @IBAction func selectImg()
      {
        isUserImg = true
         showImagePicker()
      }
    @IBAction func selectLicenseImg()
    {
      isUserImg = false
       showImagePicker()
    }
      @IBAction func editClicked()
      {
          var isValid = true
          var errorMessages: [String] = []
          if !ValidationHelper.isValidName(nameTxt.text!) {
              isValid = false
              errorMessages.append(Resources.Login.nameRequired)
          }
          if !ValidationHelper.isValidName(mobileTxt.text!) {
              isValid = false
              errorMessages.append(Resources.Login.mobileRequired)
          }
          if !ValidationHelper.isValidName(emailTxt.text!) {
              isValid = false
              errorMessages.append(Resources.Login.emailOnlyRequired)
          }
          if selectedCity == nil {
              isValid = false
              errorMessages.append(Resources.Login.choosecity)
          }
          
  //        if !ValidationHelper.isValidName(addressTxt.text!) {
  //            isValid = false
  //            errorMessages.append(Resources.Login.familyAddressRequired)
  //        }
          
        if !ValidationHelper.isValidName(passwordTxt.text!) {
            isValid = false
            errorMessages.append(Resources.Login.passwordRequired)
        }
        if !ValidationHelper.isValidName(retypePasswordTxt.text!) {
            isValid = false
            errorMessages.append(Resources.Login.confirmpasswordRequired)
        }
        if passwordTxt.text != retypePasswordTxt.text {
            isValid = false
            errorMessages.append(Resources.Login.passwordMismatchRequired)
        }
        if !isAgree {
            isValid = false
            errorMessages.append(Resources.Login.accepttermsRequired)
        }
          if !isValid {
              AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
          } else {
              var pars = [
                  "name":nameTxt.text!,
                  "mobile":mobileTxt.text!,
                "email":emailTxt.text!,
                "bankName":bankNameTxt.text!,
                "accountName":accountNumberTxt.text!,
                "accountNumber":swiftCodeTxt.text!,
                "ipanNumber":swiftCodeTxt.text!,
                "cityId":selectedCity!.city_id!,
                "yourFriendCode":userCodeTxt.text!,
                "carPlateNumber": carPlateTxt.text!,
                "workerID": nationalIDTxt.text!,
                "userType":"worker",
                "password":passwordTxt.text!,
              ] as! [String : Any]
            if selectedStore != nil {
                pars.updateValue(selectedStore!.adv_id!, forKey: "marketId")
            }
              var imgs = [Attachment]()
              if selectedImgAttach != nil {
                  imgs.append(selectedImgAttach!)
              }
            if selectedLicenseImgAttach != nil {
                imgs.append(selectedLicenseImgAttach!)
            }
            UserService.shared.register(parameters: pars, images: imgs) { (data) in
                if let x = data as? [String : Any]
                {
                    let user = x["return"] as! [String : Any]
                    AppHelper.showAlertWithTextField(textplaceholder: Resources.Login.activationCode, title: Resources.Login.activate, btnTitle: Resources.Login.activate) { [self] (code) in
                        let parms = ["mobile":mobileTxt.text!,"code":code]
                        UserService.shared.activate(parameters: parms) { (datas,success) in
                            if success
                            {
                                UserManager.saveUserInfo(user: datas as! [String : Any])
                                AppHelper.showSuccessAlert(message: Resources.Login.activationSuccess, confirmBtnTitle: Resources.Common.ok) {
                                    self.MakeHomeRoot()
                                }
                            }
                        
                        }
                        
                    }
                    
                }
                
            }
          }
      }
    @IBAction func storeClicked(_ sender: UIButton) {
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.backgroundColor = UIColor.white
        //dropDown.cellNib = UINib(nibName: "dropdowenCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            //guard let cell = cell as? dropdowenCell else { return }
            cell.optionLabel.textAlignment = LanguageManager.isArabic ? .right : .left
            
        }
        if storeList.count == 0
        {
            UserService.shared.getOtherMarkets(pars: ["":""]) { [self] (data) in
                storeList = data
                self.showStoresMenu(cities: storeList)
            }
        }
        else
        {
            self.showStoresMenu(cities: storeList)
        }
    }
    func showStoresMenu(cities : [Store])
    {
        let cit = cities
        self.dropDown.dataSource = cit.map{$0.adv_name!}
        self.dropDown.selectionAction = { [self](index: Int, item: String) in
        
            selectedStore = cities[index]
                storeTxt.text = item

            
        }
        self.dropDown.show()
    }
      @IBAction func cityClicked(_ sender: UIButton) {
          dropDown.anchorView = sender
          dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
          dropDown.backgroundColor = UIColor.white
          //dropDown.cellNib = UINib(nibName: "dropdowenCell", bundle: nil)
          dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
              //guard let cell = cell as? dropdowenCell else { return }
              cell.optionLabel.textAlignment = LanguageManager.isArabic ? .right : .left
              
          }
          if allCities.count == 0
          {
              UserService.shared.getCities { (cities) in
                  self.allCities = cities
                  self.showDirectionsMenu(cities: self.allCities)

              }
          }
          else
          {
              self.showDirectionsMenu(cities: allCities)
          }
      }
      func showDirectionsMenu(cities : [City])
      {
          let cit = cities
          self.dropDown.dataSource = cit.map{LanguageManager.isArabic ? $0.city_name! : $0.city_name!}
          self.dropDown.selectionAction = { [self](index: Int, item: String) in
          
                  selectedCity = allCities[index]
                  cityTxt.text = LanguageManager.isArabic ? selectedCity?.city_name! : selectedCity?.city_name!

              
          }
          self.dropDown.show()
      }
      func showImagePicker()
      {
          let title = Resources.Common.addImages
          let message = Resources.Common.imageSource
          
          // Add buttons to dialog
          let popup = PopupDialog(title: title, message: message, preferredWidth: 580)
          
          let libraryBtn = DefaultButton(title: Resources.Common.photoLibrary) {
              
              AppHelper.requestLibraryAcces(vc: self, completionHandler: {
                  self.showImagePickerWithSourceType(.photoLibrary, sender: self.view)
                  
              })
              //            self.initImagePicker(forSourceType: .photoLibrary, trigger: trigger)
          }
          let cameraBtn = DefaultButton(title: Resources.Common.camera) {
              AppHelper.requestCameraAcces(vc: self, completionHandler: {
                  self.showImagePickerWithSourceType(.camera, sender: self.view)
              })
              //            self.initImagePicker(forSourceType: .camera, trigger: trigger)
          }
          let cancelBtn = CancelButton(title: Resources.Common.cancel)  {
              popup.dismiss(animated: true, completion: nil)
          }
          popup.addButtons([libraryBtn, cameraBtn, cancelBtn])
          
          // Present dialog
          self.present(popup, animated: true, completion: nil)
      }
      
      func showImagePickerWithSourceType(_ sourceType: UIImagePickerController.SourceType, sender: UIView?) {
          
          let picker = UIImagePickerController()
          picker.delegate = self
          picker.sourceType = sourceType;
          picker.mediaTypes = [kUTTypeImage as String]
          picker.allowsEditing = false
          DispatchQueue.main.async {
              self.present(picker, animated: true, completion: nil)
          }
      }
      
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          var selectedImage: UIImage?
          if let editedImage = info[.editedImage] as? UIImage {
              selectedImage = editedImage
              picker.dismiss(animated: true) {
                  self.delay(time: 0.1) { [self] in
                    
                    if (isUserImg)
                    {
                        self.selectedImgAttach = Attachment()
                        self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedImgAttach!.mimeType = "image/jpeg"
                        self.userIV.image = selectedImage!.handleOrientation()
                        self.selectedImgAttach!.name = "imageData"

                    }
                    else
                    {
                        self.selectedLicenseImgAttach = Attachment()
                        self.selectedLicenseImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedLicenseImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedLicenseImgAttach!.mimeType = "image/jpeg"
                        self.licenseIV.image = selectedImage!.handleOrientation()
                        self.selectedLicenseImgAttach!.name = "licenseImage"

                    }
                  }
              }
          } else if let originalImage = info[.originalImage] as? UIImage {
              selectedImage = originalImage
              picker.dismiss(animated: true) {
                self.delay(time: 0.1) { [self] in
                    if (isUserImg)
                    {
                        self.selectedImgAttach = Attachment()
                        self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedImgAttach!.mimeType = "image/jpeg"
                        self.userIV.image = selectedImage!.handleOrientation()
                        self.selectedImgAttach!.name = "imageData"

                    }
                    else
                    {
                        self.selectedLicenseImgAttach = Attachment()
                        self.selectedLicenseImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedLicenseImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedLicenseImgAttach!.mimeType = "image/jpeg"
                        self.licenseIV.image = selectedImage!.handleOrientation()
                        self.selectedLicenseImgAttach!.name = "licenseImage"

                    }
                  }
              }
              
              
          }
      }
}
