//
//  complainDetailsVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 31/03/2021.
//



import UIKit
import DZNEmptyDataSet
class complainDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // var menuButton = UIBarButtonItem()
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var sendMsgTF : RVTxtFaild!
    @IBOutlet weak var sendImg : UIButton!
    var notificationList = [Message]()
    var officeID = ""
    
    override func viewDidLoad() {
        Utilities.addLogoTitleView(self)
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.keyboardDismissMode = .onDrag
        self.hideKeyboardWhenTappedAround()
       
        getData(showProgress: true)
    }
    
    
    func getData(showProgress: Bool)
    {
        
        UserService.shared.getTicketMessages(ticketId: officeID) { (data) in
            self.notificationList = data
            self.tableView.reloadData()
            if self.notificationList.count > 0
            {
                self.tableView.scrollToRow(at: IndexPath(row: self.notificationList.count-1, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
    @IBAction func sendClicked()
    {
        
            if(!ValidationHelper.isValidName(sendMsgTF.text!))
            {
                AppHelper.showErrorAlert(message: Resources.Common.entermsgDetails)
                return
            }
        
        let pars =  ["fromUserId": UserManager.getUserData!.id!,
                     "complainId": officeID,
                     "message": sendMsgTF.text!]

        UserService.shared.sendTicketMessage(pars: pars) { (data) in
            self.sendMsgTF.text = ""
            self.dismissKeyboard()
            self.getData(showProgress: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let img = #imageLiteral(resourceName: "send_btn")
        sendImg.setImage(!LanguageManager.isArabic ? img : img.flipImage()!, for: .normal)
        
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getCellIdentifies(data:  notificationList[indexPath.row]), for: indexPath) as! MessageFromCell
        cell.handleCells(data: notificationList[indexPath.row])
        return cell
    }
    
    
    func getCellIdentifies(data: Message) -> String
    {
            return data.msg_user_id! == UserManager.getUserData!.id ? "MessageFromCell" : "MessageToCell"
    }
    
    // Set the spacing between sections
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    
    
    
    
    
}
extension complainDetailsVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return notificationList.count == 0
        
    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "chat").maskWithColor(color: Color.mainColor!)!
    }
    
    func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        let animation = CABasicAnimation(keyPath: "transform")
        
        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 0.0, 1.0))
        
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT
        
        return animation
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = LanguageManager.isArabic ? "لا يوجد رسائل" : "No messages yet !"
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]
        return NSAttributedString(string: text, attributes: attributes)
    }
}


