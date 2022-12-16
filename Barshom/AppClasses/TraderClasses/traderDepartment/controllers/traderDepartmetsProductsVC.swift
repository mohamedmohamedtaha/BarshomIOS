//
//  traderDepartmetsProductsVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit

class traderDepartmetsProductsVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
    var selectedCat : Category?
    var productList = [Products]()
    override func viewDidLoad() {
        super.viewDidLoad()

        handleUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getProducts()
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "add" {
      let vc = segue.destination as! addTraderProductTVC
      vc.type = .add
    }
  }
  func handleUI(){
   
    tableView.register(UINib(nibName: mainPackagesCell.identifier, bundle: nil), forCellReuseIdentifier: mainPackagesCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    Utilities.delay {
      self.tableView.reloadData()
    }
    
  }
  
  @IBAction func addNewProductAction(_ sender: UIButton) {
    performSegue(withIdentifier: "add", sender: nil)
  }
    func getProducts()
    {
        var pars = ["userId":UserManager.getUserData!.id!]
        
        pars.updateValue(selectedCat!.cat_id!, forKey: "catId")
        
        UserService.shared.getProducts(pars: pars) { [self] (data) in
            
            productList =  data
            self.tableView.reloadData()
        }
    }
  
}


extension traderDepartmetsProductsVC:UITableViewDataSource,UITableViewDelegate ,traderDepartmentProductDelegate{
    func delete(product: Products) {
        AppHelper.showInfoAlert(message: Resources.Common.deleteProductAlert, confirmBtnTitle: Resources.Common.delete) {
            UserService.shared.deleteProduct(complainId: product.pro_id!) { (data) in
                AppHelper.showSuccessAlertWithoutButtons(vc: self, message:  data["message"] as! String)
                self.getProducts()
            }
        }
        
    }
    
    func edit(product: Products) {
        
    }
    func share(product: Products) {
        let textShare = [ "https://brshom.com/products/\(product.pro_id!)" ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
    
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: mainPackagesCell.identifier, for: indexPath) as! mainPackagesCell
    cell.cellVC = self
    cell.prodDelegate = self
    cell.cellConfigration(.traderDepartmentProducts)
    cell.productList = productList
    
    return cell
  }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = (Double(productList.count)/Double(2)).rounded(.up)
        print("test --- \(height)")
        return (height * 300)+40
    }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headercell = UIView()
    headercell.backgroundColor = .white
    let Lb = UILabel(frame: CGRect(x: LanguageManager.isArabic ? Constants.ScreenWidth-220 : 20, y: 0, width: 200, height: 40))
    Lb.text = Resources.Common.products
    Lb.font = UIFont.boldSystemFont(ofSize: 15)
    headercell.addSubview(Lb)
    return headercell
  }
}
