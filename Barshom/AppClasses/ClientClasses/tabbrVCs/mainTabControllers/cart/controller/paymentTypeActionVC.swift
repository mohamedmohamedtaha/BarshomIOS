//
//  paymentTypeAction.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/31/20.
//

import UIKit
import MFSDK
import DropDown
enum paymentType {
  case cash,ePayment,bank,net,wallet
}
class paymentTypeActionVC: UITableViewController ,imgsCollectionDelegate{
    @IBOutlet weak var packgeCollection: UICollectionView!
    @IBOutlet weak var paymentCollection: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    @IBOutlet weak var workersView: UIView!
    @IBOutlet weak var cashIcon: UIImageView!
    @IBOutlet weak var netIcon: UIImageView!
    @IBOutlet weak var walletIcon: UIImageView!
  @IBOutlet weak var epaymentIcon: UIImageView!
  @IBOutlet weak var bankIcon: UIImageView!
  
    @IBOutlet weak var cashBG: UIView!
    @IBOutlet weak var netBG: UIView!
    @IBOutlet weak var walletBG: UIView!
  @IBOutlet weak var epaymentBG: UIView!
    @IBOutlet weak var bankBG: UIView!
    @IBOutlet weak var accountNumberView: UIStackView!

    
    @IBOutlet weak var todayBG: UIView!
    @IBOutlet weak var tomorrowBG: UIView!
    @IBOutlet weak var todaySV: UIView!
    @IBOutlet weak var tomorrowSV: UIView!

    @IBOutlet weak var cashSV: UIView!
    @IBOutlet weak var netSV: UIView!
    @IBOutlet weak var walletSV: UIView!
    @IBOutlet weak var epaymentSV: UIView!
    @IBOutlet weak var bankSV: UIView!
    
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var tomorrowLbl: UILabel!
    var paymentMethods = [MFPaymentMethod]()
    var selectedPaymentMethodIndex = 0

    
    @IBOutlet weak var imgsCollectionView: imagesCollectionView!
    @IBOutlet weak var accountHolderTxt: RVTxtFaild!
    @IBOutlet weak var accountNameTxt: RVTxtFaild!
    @IBOutlet weak var bankNameTxt: RVTxtFaild!
    @IBOutlet weak var workerNameTxt: RVTxtFaild!

    var dropDown = DropDown()
    var dropDownMandob = DropDown()

    var allCities = [Bank]()
    var allWorkers = [Worker]()
    var isLoadingWorkers : Bool = false

  var isPackage = false
  var pars :[String:Any]?
  var roundNumber:CGFloat = 20.0
  var selectedVColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1).cgColor
  var isToday = true
    var totalPrice = 0.0
    var bankHolder = ""
    var bankUserName = ""
    var bankName : Bank?
    var selectedWorker : Worker?
    var selectedImg = [Data]()
  var type:paymentType = .cash
    var selectedAttach : Attachment?
  override func viewDidLoad() {
        super.viewDidLoad()
      
  
      loadWorkers()
  
    if isPackage
    {
        type = .cash
    }
    packgeCollection.register(UINib(nibName: shiftCell.identifier, bundle: nil), forCellWithReuseIdentifier: shiftCell.identifier)
    packgeCollection.dataSource = self
    packgeCollection.delegate = self
    paymentCollection.dataSource = self
    paymentCollection.delegate = self
      Utilities.addLogoTitleView(self)
      clearViewa()
    if type == .cash {
        selectType(cashIcon, BG: cashBG, SV: cashSV)
    }
    else if type == .ePayment
    {
        selectType(epaymentIcon, BG: epaymentBG, SV: epaymentSV)
    }
    else if type == .bank
    {
        selectType(bankIcon, BG: bankBG, SV: bankSV)
    }
    else if type == .net
    {
        selectType(bankIcon, BG: netBG, SV: netSV)
    }
    else if type == .wallet
    {
        selectType(walletIcon, BG: walletBG, SV: walletSV)
    }
//    cashBG.isHidden = isPackage
//    walletBG.isHidden = isPackage
    handleDateTime()
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    dateFormatter.locale = Locale(identifier: LanguageManager.isArabic ? "ar" : "en")
    todayLbl.text = dateFormatter.string(from: date)
    tomorrowLbl.text = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: date)!)
    self.tableView.reloadData()
    print(pars)
    if !isPackage {
        UserService.shared.getShifts { [self] (shifts) in
            shiftsList = shifts
            heightConstraint.constant = CGFloat(shiftsList.count * 60)
            self.packgeCollection.reloadData()
            self.tableView.reloadData()
        }
    }
        initiatePayment()
      imgsCollectionView.collectionConfigration(self, limit: 1)
      imgsCollectionView.dlegate = self

    }
    func reload(imgs: [Data]) {
        selectedImg = imgs
    }
    func imgsEmpty(imgs: [Data]) {
        selectedImg = imgs
    }
    @IBAction func addPhoto(_ sender: UIButton) {
      imgsCollectionView.addNewphoto()
    }
    
      @IBAction func holderChanged(_ sender: Any) {
          bankHolder = accountHolderTxt.text!
      }
      @IBAction func nameChanged(_ sender: Any) {
          bankUserName = accountNameTxt.text!

      }
      @IBAction func bankClicked(_ sender: Any) {
          dropDown.anchorView = sender as! UIButton
          dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
          dropDown.backgroundColor = UIColor.white
          //dropDown.cellNib = UINib(nibName: "dropdowenCell", bundle: nil)
          dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
              //guard let cell = cell as? dropdowenCell else { return }
              cell.optionLabel.textAlignment = LanguageManager.isArabic ? .right : .left
              
          }
          if allCities.count == 0
          {
              UserService.shared.getBanks { (cities) in
                  self.allCities = cities
                  self.showDirectionsMenu(cities: self.allCities)

              }
          }
          else
          {
              self.showDirectionsMenu(cities: allCities)
          }
      }
    
      func showDirectionsMenu(cities : [Bank])
      {
          let cit = cities
          self.dropDown.dataSource = cit.map{$0.bank_name!}
          self.dropDown.selectionAction = { [self](index: Int, item: String) in
          
                  bankName = allCities[index]
                  bankNameTxt.text = bankName!.bank_name!
              
          }
          self.dropDown.show()
      }
    
    func showManadebMenu(workers : [Worker])
    {
        let wor = workers
        self.dropDown.dataSource = wor.map{$0.adv_name!}
        self.dropDown.selectionAction = { [self](index: Int, item: String) in
            selectedWorker = allWorkers[index]
            workerNameTxt.text = selectedWorker!.adv_name!
        }
        self.dropDown.show()
    }
    
    @IBAction func mandobClicked(_ sender: Any) {
        
        dropDownMandob.anchorView = sender as! UIButton
        dropDownMandob.bottomOffset = CGPoint(x: 0, y:(dropDownMandob.anchorView?.plainView.bounds.height)!)
        dropDownMandob.backgroundColor = UIColor.white
        //dropDown.cellNib = UINib(nibName: "dropdowenCell", bundle: nil)
        dropDownMandob.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            //guard let cell = cell as? dropdowenCell else { return }
            cell.optionLabel.textAlignment = LanguageManager.isArabic ? .right : .left
        }
        self.showManadebMenu(workers: allWorkers)

      
       
    }
    
    
 
      

    func handleDateTime()
    {
        todayBG.dropShadow(roundCorner:roundNumber)
        tomorrowBG.dropShadow(roundCorner:roundNumber)
        
        todayBG.layer.borderColor = isToday ? Color.mainColor!.cgColor : UIColor.clear.cgColor
        todaySV.layer.backgroundColor = isToday ? Color.tintColor!.cgColor : UIColor.clear.cgColor
        todaySV.layer.borderColor = !isToday ? Color.tintColor!.cgColor : UIColor.clear.cgColor
        
        tomorrowBG.layer.borderColor = !isToday ? Color.mainColor!.cgColor : UIColor.clear.cgColor
        tomorrowSV.layer.backgroundColor = !isToday ? Color.tintColor!.cgColor : UIColor.clear.cgColor
        tomorrowSV.layer.borderColor = isToday ? Color.tintColor!.cgColor : UIColor.clear.cgColor
    }
  func selectType(_ img:UIImageView,BG:UIView,SV:UIView){
    clearViewa()
      
      if type == .bank{
          self.accountNumberView.isHidden = false
      }else {
          self.accountNumberView.isHidden = true

      }
      
    BG.layer.borderColor = Color.mainColor?.cgColor
    BG.removeShadow()
    SV.backgroundColor = Color.tintColor
    SV.layer.borderColor = UIColor.clear.cgColor
    switch type {
    case .cash:
      img.image = #imageLiteral(resourceName: "cashSelected")
    case .ePayment:
      img.image = #imageLiteral(resourceName: "epaymentSelected")
    case .net:
      img.image = #imageLiteral(resourceName: "epaymentSelected")
    case .wallet:
        img.image = #imageLiteral(resourceName: "pay_wallet").maskWithColor(color: Color.mainColor!)
    case .bank:
      img.image = #imageLiteral(resourceName: "bankTransferSelected")
    }
    self.tableView.reloadData()
    
  }
    
    func loadWorkers(){
        if UserManager.getUserData!.cat_name == "متاجر"{
            let id = UserManager.getUserData!.id
            UserService.shared.getMnadeeb(params: ["companyId":id]) { (workers) in
                self.isLoadingWorkers = true
                self.allWorkers = workers
              
  //              self.showManadebMenu(workers: workers)
            }
        }else {
            workersView.isHidden = true
        }
    }
  
  func clearViewa(){
    cashIcon.image = #imageLiteral(resourceName: "cash")
    epaymentIcon.image = #imageLiteral(resourceName: "epayment")
    netIcon.image = #imageLiteral(resourceName: "epayment")
    walletIcon.image = #imageLiteral(resourceName: "pay_wallet").maskWithColor(color: UIColor.gray)
    bankIcon.image = #imageLiteral(resourceName: "bankTransfer")

    cashBG.layer.borderColor = selectedVColor
    netBG.layer.borderColor = selectedVColor
    epaymentBG.layer.borderColor = selectedVColor
    bankBG.layer.borderColor = selectedVColor
    walletBG.layer.borderColor = selectedVColor

    cashBG.dropShadow(roundCorner:roundNumber)
    netBG.dropShadow(roundCorner:roundNumber)
    epaymentBG.dropShadow(roundCorner:roundNumber)
    bankBG.dropShadow(roundCorner:roundNumber)
    walletBG.dropShadow(roundCorner:roundNumber)

    cashSV.backgroundColor = .clear
    netSV.backgroundColor = .clear
    epaymentSV.backgroundColor = .clear
    bankSV.backgroundColor = .clear
    walletSV.backgroundColor = .clear

    cashSV.layer.borderColor = selectedVColor
    netSV.layer.borderColor = selectedVColor
    epaymentSV.layer.borderColor = selectedVColor
    bankSV.layer.borderColor = selectedVColor
    walletSV.layer.borderColor = selectedVColor
  }
  
    @IBAction func submitAction(_ sender: UIButton) {
        selectedAttach = nil
        if pars == nil
        {
            pars = ["":""]
        }
        var payMethod = "cash"
        switch type {
        case .cash:
            payMethod = "cash"

        case .net:
            payMethod = "net"

        case .ePayment:
            payMethod = "online"
        case .wallet:
            payMethod = "wallet"
        case .bank:
            payMethod = "bank"
            var isValid = true
            var errorMessages: [String] = []
            if !ValidationHelper.isValidName(bankHolder) {
                isValid = false
                errorMessages.append(Resources.Common.required(fieldName: Resources.Common.bankHolder))
            }
            if !ValidationHelper.isValidName(bankUserName) {
                isValid = false
                errorMessages.append(Resources.Common.required(fieldName: Resources.Common.bankAccount))
            }
            if bankName == nil {
                isValid = false
                errorMessages.append(Resources.Common.required(fieldName: Resources.Common.bankName))
            }
            if selectedImg.count == 0 {
                isValid = false
                errorMessages.append(Resources.Common.required(fieldName: Resources.Common.bankTransferImage))
            }
            if !isValid {
                AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
                return
            }
            pars!.updateValue(bankHolder, forKey: "accountName")
            pars!.updateValue(bankUserName, forKey: "accountNumber")
            pars!.updateValue(bankName!.bank_id!, forKey: "bankId")
            selectedAttach = Attachment()
            selectedAttach!.data = selectedImg[0]
            selectedAttach!.name = isPackage ? "imageData" : "transfarImage"
            selectedAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
            selectedAttach!.mimeType = "image/jpeg"
    
        }
        if UserManager.getUserCity  != nil {
            pars!.updateValue(UserManager.getUserCity!.city_id!, forKey: "cityId")
        }
        else
        {
            pars!.updateValue("34", forKey: "cityId")
        }
        
        pars!.updateValue(payMethod, forKey: "paymentMethod")
        pars!.updateValue(payMethod, forKey: "paymentType")
        pars!.updateValue(UserManager.getUserData!.id!, forKey: "userId")
        
        
        if UserManager.getUserData!.cat_name == "متاجر"{
            if (!isLoadingWorkers) {return}
            if (allWorkers.count == 0) {
                print("noo worker")
            }
            if selectedWorker == nil  {
                AppHelper.showErrorAlertOneButton(message:"الرجاء اختيار مندوب",confirmBtnTitle: "حسنا") {}
                return
            }else {
                pars!.updateValue(selectedWorker?.adv_id?.description, forKey: "workerId")
            }
            }
        

            if isPackage {
                if self.type == .ePayment {
                    self.executePayment(offer: totalPrice, name: "new package subscribtion")
                }
                else
                {
                    subscribePckg(pars: pars!, attachment: selectedAttach)
                }
            }
            else{
                let shift = shiftsList.filter{$0.isSelected}
                if shift.count == 0 {
                    AppHelper.showInfoAlert(message: LanguageManager.isArabic ? "اختر التاريخ و الوقت للتوصيل" : "Choose delivery date & time")
                    return
                }
                pars!.updateValue(shift[0].shift_id!, forKey: "shiftId")
                pars!.updateValue(isToday ? "today" : "tomorrow", forKey: "orderDay")
                if self.type == .ePayment {
                    self.executePayment(offer: totalPrice, name: "new order")
                }
                else
                {
                    sendOrder(pars: pars!, attachment: selectedAttach)
                }
                
            }
        
     
        
        
    }
  
    func sendOrder(pars: [String: Any],attachment: Attachment?)
    {
        print(pars)
        UserService.shared.sendOrder(pars: pars,attach: attachment) { (data) in
            
            cartList = [OrderProducts]()
            selectedAddress = nil
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "cart"),
                object: nil,
                userInfo: nil)
            Notify.post(.selectIndex,object:1)
            self.navigationController?.popToRootViewController(animated: true)
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)

        }
    }
    func subscribePckg(pars: [String: Any],attachment: Attachment?)
    {
        UserService.shared.subscribeClientPackage(pars: pars,attach: attachment) { (data) in
            if UserManager.getUserData!.adv_type == "user"
            {
                self.navigationController?.dismiss(animated: true,completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: data["message"] as! String)
            self.delay(time: 2) {
                self.MakeHomeRoot()

            }
        }

    }
    
    
    @IBAction func todayAction(_ sender: UIButton) {
        isToday = true
        handleDateTime()
    }
    @IBAction func tomorrowAction(_ sender: UIButton) {
        isToday = false
        handleDateTime()
    }
  @IBAction func cashAction(_ sender: UIButton) {
    type = .cash
    selectType(cashIcon, BG: cashBG, SV: cashSV)
  }
    @IBAction func netAction(_ sender: UIButton) {
      type = .net
      selectType(netIcon, BG: netBG, SV: netSV)
    }
    @IBAction func walletAction(_ sender: UIButton) {
      type = .wallet
      selectType(walletIcon, BG: walletBG, SV: walletSV)
    }
  
  @IBAction func ePaymentAction(_ sender: UIButton) {
//    AppHelper.showInfoAlert(message: Resources.Common.notavailable)
//    return
    type = .ePayment
    selectType(epaymentIcon, BG: epaymentBG, SV: epaymentSV)
  }
  
  @IBAction func bankAction(_ sender: UIButton) {
    type = .bank
    selectType(bankIcon, BG: bankBG, SV: bankSV)
  }
}
extension paymentTypeActionVC
{
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        if indexPath.row == 1 {
            if UserManager.getUserData!.cat_name == "متاجر" {
                return UITableView.automaticDimension

            }else{
                return 0
            }
            
        }
        if indexPath.row == 2 {
            return type == .ePayment ? 90 : 0
        }
        if 3...7 ~= indexPath.row {
            return type == .bank ? UITableView.automaticDimension : 0
        }
        if indexPath.row == 8 {
            return CGFloat(!isPackage ? (200 + (shiftsList.count * 60)) : 0)
        }
        
        return UITableView.automaticDimension
    }
}
extension paymentTypeActionVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,shiftDelegate{
    func selectShift(index: Int) {
        for (ind,i) in shiftsList.enumerated()
        {
            if ind == index {
                shiftsList[ind].isSelected = true
            }
            else
            {
                shiftsList[ind].isSelected = false
            }
        }
        self.packgeCollection.reloadData()
    }
    
    
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return collectionView == packgeCollection ? shiftsList.count : paymentMethods.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == packgeCollection
    {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shiftCell.identifier, for: indexPath) as! shiftCell
      cell.delegate = self
        cell.index = indexPath.row
        cell.cellConfigration(storeData: shiftsList[indexPath.row])
      return cell
    }
    else
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PaymentMethodCollectionViewCell
            let selectedIndex = selectedPaymentMethodIndex ?? -1
            cell.configure(paymentMethod: paymentMethods[indexPath.row], selected: selectedIndex == indexPath.row)
        return cell
    }
    
  }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == paymentCollection
        {
            selectedPaymentMethodIndex = indexPath.row
            paymentCollection.reloadData()
        }
    }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView == paymentCollection ? CGSize(width: 90 , height: 80) : CGSize(width: Constants.ScreenWidth - 30 , height: 55)
    
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      
      return 5
  }
  
}
extension paymentTypeActionVC
{
    
    func initiatePayment() {
        Indicator.sharedInstance.show()
        let price = Double("0.0")//self.viewModel.totalItemsPrice.value
        let request = MFInitiatePaymentRequest(invoiceAmount: Decimal(price ?? 0.0), currencyIso: .saudiArabia_SAR)
        
        MFPaymentRequest.shared.initiatePayment(request: request, apiLanguage: .english, completion: { [weak self] (result) in
            Indicator.sharedInstance.dismiss()
            switch result {
            case .success(let initiatePaymentResponse):
                self!.paymentMethods = initiatePaymentResponse.paymentMethods!
                self!.paymentCollection.reloadData()
            case .failure(let failError):
                AppHelper.showInfoAlert(message: failError.errorDescription)
            }
        })
    }
    func executePayment(offer:Double,name:String) {
        let price = offer//self.viewModel.totalItemsPrice.value
        let request = MFExecutePaymentRequest(invoiceValue: Decimal(price ), paymentMethod: paymentMethods[selectedPaymentMethodIndex].paymentMethodId)
        request.customerName =  UserManager.getUserData!.adv_name ?? "test user"
            request.customerMobile =  "554782709" ?? "554782709"
                .replacingOccurrences(of: "611", with: "")
                .replacingOccurrences(of: "+966", with: "")
                .replacingOccurrences(of: "00966", with: "")
        print("testMobbile \(request.customerMobile)")

            request.customerEmail = UserManager.getUserData!.adv_email ?? "mohamed.elmakkawy@gmail.com"
            request.mobileCountryCode = "+966"
        let productDetails = "\(name)"
        request.invoiceItems.append(MFProduct(name: productDetails, unitPrice: price, quantity: 1))
            request.displayCurrencyIso = .saudiArabia_SAR
        request.language = MFLanguage(rawValue: LanguageManager.isArabic ? "ar" : "en")!
             //MFAPILanguage(rawValue: Language.currentLanguage())
            request.customerReference = name
            MFPaymentRequest.shared.executePayment(request: request, apiLanguage: MFAPILanguage(rawValue: LanguageManager.isArabic ? "ar" : "en")!) { [weak self] response, invoiceId  in
                guard let self = self else{return}
                switch response {
                case .success(let executePaymentResponse):
                    self.pars?.updateValue(invoiceId!, forKey: "transactionId")
                    if self.isPackage {
                        self.subscribePckg(pars: self.pars!, attachment: self.selectedAttach)
                    }
                    else
                    {
                        self.sendOrder(pars: self.pars!, attachment: self.selectedAttach)
                    }
//
                    
                case .failure(let failError):
                    AppHelper.showInfoAlert(message: failError.errorDescription)
                }
            }

    }
}
