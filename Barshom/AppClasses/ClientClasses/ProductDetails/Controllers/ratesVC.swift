//
//  ratesVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/27/20.
//

import UIKit
import DZNEmptyDataSet
class ratesVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
    var productData :Products?
    override func viewDidLoad() {
        super.viewDidLoad()

      hadleUI()
    }
  
  
  func hadleUI(){
    tableView.register(UINib(nibName: rateCell.identifier, bundle: nil), forCellReuseIdentifier: rateCell.identifier)
    tableView.dataSource = self
    tableView.emptyDataSetDelegate = self
    tableView.emptyDataSetSource = self
    Utilities.delay(0.1) {
      self.tableView.reloadData()
    }
  }
  
  @IBAction func addRateAction(_ sender: UIButton) {
    if !UserManager.isLoggedIn
    {
        AppHelper.showLoginAlert(vc: self)
        return
    }
    sheetPresenter.opensheetRateProductVC(self, storeyBoard:.rate, order:productData!.pro_id!)
  }

}

extension ratesVC:UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return productData!.rates.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: rateCell.identifier, for: indexPath) as! rateCell
    cell.celllConfigration(rate: productData!.rates[indexPath.row])
    return cell
  }
}
extension ratesVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return productData!.rates.count == 0

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
        let text = (LanguageManager.isArabic ? "لا يوجد تقييمات" : "No reviews yet !")
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}
