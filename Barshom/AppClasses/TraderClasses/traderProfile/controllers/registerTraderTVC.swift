//
//  registerTraderTVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 19/05/2021.
//



import UIKit
import PopupDialog
import Photos
import AVFoundation
import MobileCoreServices
import DropDown
class registerTraderTVC: UITableViewController ,MapVCDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

  @IBOutlet weak var nameTxt: RVTxtFaild!
  @IBOutlet weak var storeTxt: RVTxtFaild!
  @IBOutlet weak var mobileTxt: RVTxtFaild!
  @IBOutlet weak var emailTxt: RVTxtFaild!
  @IBOutlet weak var storeTypeTxt: RVTxtFaild!
  
  @IBOutlet weak var bankNameTxt: RVTxtFaild!
  @IBOutlet weak var ownerNameTxt: RVTxtFaild!
  @IBOutlet weak var accountNumberTxt: RVTxtFaild!
  @IBOutlet weak var swiftCodeTxt: RVTxtFaild!
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var commercialIV: UIImageView!
    @IBOutlet weak var licenseIV: UIImageView!
    @IBOutlet weak var addressBg: UIView!
    @IBOutlet weak var hasAddressBg: UIView!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var passwordTxt: RVTxtFaild!
    @IBOutlet weak var retypePasswordTxt: RVTxtFaild!
    @IBOutlet weak var chackBg: UIView!
    @IBOutlet weak var userCodeTxt: RVTxtFaild!
    @IBOutlet weak var clickHereLb: UILabel!

    var isAgree = false
    var dropDown = DropDown()
    var allCities = [Category]()
    var selectedCity : Category?

    var selectedAddress : Address?
    var imgType = 0
    var selectedImgAttach : Attachment?
    var selectedLicenseImgAttach : Attachment?
    var selectedCommercialImgAttach : Attachment?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = clientMenuType.registerStore.rawValue.localized()
      nameTxt.AddImage(#imageLiteral(resourceName: "info"))
      storeTxt.AddImage(#imageLiteral(resourceName: "store"))
      mobileTxt.AddImage(#imageLiteral(resourceName: "contact"))
      emailTxt.AddImage(#imageLiteral(resourceName: "email"))
      storeTypeTxt.AddImage(#imageLiteral(resourceName: "store"))
        passwordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
        retypePasswordTxt.AddImage(#imageLiteral(resourceName: "car-key"))
        userCodeTxt.AddImage(#imageLiteral(resourceName: "info"))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: LanguageManager.isArabic ? "شروط و أحكام المتاجر" : "Trader Terms & Conditions", attributes: underlineAttribute)
        clickHereLb.attributedText = underlineAttributedString
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    func handleAdress()
    {
        if selectedAddress != nil {
            self.addressLb.text = selectedAddress!.address
            self.hasAddressBg.isHidden = false
            self.addressBg.isHidden = true
        }
        else
        {
            self.addressLb.text = ""
            self.hasAddressBg.isHidden = true
            self.addressBg.isHidden = false
        }
    }
    @IBAction func termsClickedAction(_ sender: UIButton) {
        let vc = AppStoryboard.terms.instance.instantiateViewController(withIdentifier: "aboutVC") as! aboutVC
        vc.type = .terms
        vc.userType = "company"
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addressAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "SelectLocationViewController") as! SelectLocationViewController
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
    func getCoordinatesBack(lat: String, lng: String) {
        UserService.shared.getPlaceDetails(lat: lat, lng: lng) { (data) in
            if(data.count > 0)
            {
            self.selectedAddress = Address(JSON: ["" : ""])!
                self.selectedAddress!.address = data.first!.formatted_address!
                self.selectedAddress!.lat = "\(data.first!.geometry!.location!.lat!)"
                self.selectedAddress!.lng = "\(data.first!.geometry!.location!.lng!)"
                self.handleAdress()
            }
        }
    }
    func selectAgreeTerms(){
      if isAgree {
        chackBg.backgroundColor = Color.tintColor
      }else{
        chackBg.backgroundColor = .white
      }
    }
    
    @IBAction func agreeTermsAction(_ sender: UIButton) {
      isAgree = !isAgree
      selectAgreeTerms()
    }
    @IBAction func selectImg()
    {
      imgType = 0
       showImagePicker()
    }
  @IBAction func selectLicenseImg()
  {
    imgType = 1
    showImagePicker()
  }
    @IBAction func selectCommercialImg()
    {
        imgType = 2
        showImagePicker()
    }
    @IBAction func selectCategory(sender: UIButton)
    {
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
            UserService.shared.getMarketCategory(userId: "15") { (dat) in
                self.allCities = dat
                self.showDirectionsMenu(cities: self.allCities)
            }
        
        }
        else
        {
            self.showDirectionsMenu(cities: allCities)
        }
    }
    func showDirectionsMenu(cities : [Category])
    {
        let cit = cities
        self.dropDown.dataSource = cit.map{$0.cat_name!}
        self.dropDown.selectionAction = { [self](index: Int, item: String) in
        
                selectedCity = allCities[index]
                storeTypeTxt.text = item

            
        }
        self.dropDown.show()
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
            errorMessages.append(Resources.Login.storeTypeRequired)
        }
        if selectedAddress == nil {
            isValid = false
            errorMessages.append(Resources.Login.familyAddressRequired)
        }
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
                "mapLocation":"\(selectedAddress!.lat),\(selectedAddress!.lng)",
                "userType":"company",
                "yourFriendCode":userCodeTxt.text!,
                "password":passwordTxt.text!,
                "catId":selectedCity!.cat_id!,
            ] as! [String : Any]
            var imgs = [Attachment]()
            if selectedImgAttach != nil {
                imgs.append(selectedImgAttach!)
            }
          if selectedLicenseImgAttach != nil {
              imgs.append(selectedLicenseImgAttach!)
          }
            if selectedLicenseImgAttach != nil {
                imgs.append(selectedCommercialImgAttach!)
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
                    switch imgType
                    {
                        case 0:
                            self.selectedImgAttach = Attachment()
                            self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                            self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                            self.selectedImgAttach!.mimeType = "image/jpeg"
                            self.userIV.image = selectedImage!.handleOrientation()
                            self.selectedImgAttach!.name = "imageData"
                        case 1 :
                            self.selectedLicenseImgAttach = Attachment()
                            self.selectedLicenseImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                            self.selectedLicenseImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                            self.selectedLicenseImgAttach!.mimeType = "image/jpeg"
                            self.licenseIV.image = selectedImage!.handleOrientation()
                            self.selectedImgAttach!.name = "licanseImage"
                        case 2:
                            self.selectedCommercialImgAttach = Attachment()
                            self.selectedCommercialImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                            self.selectedCommercialImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                            self.selectedCommercialImgAttach!.mimeType = "image/jpeg"
                            self.commercialIV.image = selectedImage!.handleOrientation()
                            self.selectedCommercialImgAttach!.name = "commercialRecordImage"
                        default:
                            self.selectedImgAttach = Attachment()
                            self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                            self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                            self.selectedImgAttach!.mimeType = "image/jpeg"
                            self.userIV.image = selectedImage!.handleOrientation()
                            self.selectedImgAttach!.name = "imageData"
                    }
                 
                }
            }
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            picker.dismiss(animated: true) {
              self.delay(time: 0.1) { [self] in
                    
                
                switch imgType
                {
                    case 0:
                        self.selectedImgAttach = Attachment()
                        self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedImgAttach!.mimeType = "image/jpeg"
                        self.userIV.image = selectedImage!.handleOrientation()
                        self.selectedImgAttach!.name = "imageData"
                    case 1 :
                        self.selectedLicenseImgAttach = Attachment()
                        self.selectedLicenseImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedLicenseImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedLicenseImgAttach!.mimeType = "image/jpeg"
                        self.licenseIV.image = selectedImage!.handleOrientation()
                        self.selectedImgAttach!.name = "licenseImage"
                    case 2:
                        self.selectedCommercialImgAttach = Attachment()
                        self.selectedCommercialImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedCommercialImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedCommercialImgAttach!.mimeType = "image/jpeg"
                        self.commercialIV.image = selectedImage!.handleOrientation()
                        self.selectedCommercialImgAttach!.name = "licenseImage"
                    default:
                        self.selectedImgAttach = Attachment()
                        self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedImgAttach!.mimeType = "image/jpeg"
                        self.userIV.image = selectedImage!.handleOrientation()
                        self.selectedImgAttach!.name = "imageData"
                }
                }
            }
            
            
        }
    }
}
