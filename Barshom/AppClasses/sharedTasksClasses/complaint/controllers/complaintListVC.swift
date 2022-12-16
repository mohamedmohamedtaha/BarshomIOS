//
//  complaintListVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit
import DZNEmptyDataSet
class complaintListVC: UIViewController {

  @IBOutlet weak var tableView:UITableView!
  @IBOutlet weak var addcomplaintBt: UIButton!
    var ticketList = [Ticket]()
  override func viewDidLoad() {
        super.viewDidLoad()

      tableView.register(UINib(nibName: complaintCell.identifier, bundle: nil), forCellReuseIdentifier: complaintCell.identifier)
    tableView.emptyDataSetDelegate = self
    tableView.emptyDataSetSource = self
    addcomplaintBt.layer.cornerRadius = addcomplaintBt.frame.height/2
    getTickets()
    }
    
    func getTickets()
    {
        UserService.shared.getTickets { (data) in
            self.ticketList = data
            self.tableView.reloadData()
        }
    }
  @IBAction func addTicekt(_ sender: UIButton) {
    sheetPresenter.opensheetReportOrderVC(self, storeyBoard: .complaint, order: nil,delegate: self)
  }
  

}

extension complaintListVC:UITableViewDataSource,UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ticketList.count
  }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: complaintCell.identifier, for: indexPath) as! complaintCell
    cell.delegate = self
    cell.cellConfigration(ticketData: ticketList[indexPath.row])
    return cell
  }
  
  
}
extension complaintListVC:complaintDelegate,reloadDelegate{
    func reload() {
        self.getTickets()
    }
    func reply(orderData: Ticket) {
        performSegue(withIdentifier: "chat", sender: orderData.cons_id!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chat"
        {
            let vc = segue.destination as! complainDetailsVC
            vc.officeID = sender as! String
        }
    }
    func cancel(orderData: Ticket) {
        UserService.shared.cancelComplaint(complainId: orderData.cons_id!) { (data) in
            AppHelper.showSuccessAlertWithoutButtons(vc: self, message: Resources.Common.ticketClosed)
            self.getTickets()
        }
    }
    
  
}
extension complaintListVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return ticketList.count == 0

    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage()//#imageLiteral(resourceName: "personwhite").maskWithColor(color: Color.mainColor!)!
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
        let text = LanguageManager.isArabic ? "لا يوجد تذاكر او شكاوى" : "No tickets/complaints yet !"
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}
