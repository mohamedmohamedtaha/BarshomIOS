//
//  imagesCollectionView.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/4/21.
//

import UIKit

class imageClass {
    var img:UIImage?
    var url:String?
}

protocol imgsCollectionDelegate {
  func reload()
  func imgsEmpty()
}

class imagesCollectionView: UICollectionView {

  
  var imagePicker = UIImagePickerController()
  var imgs = [imageClass]()
  var selectedPhotos = [UIImage]()
  var imgsData = [Data]()
  var imgsLimit = 1
  var collectionViewVC:UIViewController?
  var collectionViewTVC:UITableViewController?
  var dlegate:imgsCollectionDelegate?
  
  var flowHeightConstraint: NSLayoutConstraint?
  
  var isTVC = false
  
    override func draw(_ rect: CGRect) {
      //
    }
  
  func collectionConfigration(_ TVC:UITableViewController,limit:Int){
    isTVC = true
    self.collectionViewTVC = TVC
    Configration(limit)
  }
  
  func collectionConfigration(_ vc:UIViewController,limit:Int){
    isTVC = false
    collectionViewVC = vc
    Configration(limit)
  }
  
  func Configration(_ limit:Int)  {
    handleUI()
    imgsLimit = limit
  }
  func handleUI(){
    registerCells()
    self.delegate=self
    self.dataSource=self
    handleLayOut()
  }
  
  func handleLayOut(){
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    self.collectionViewLayout = layout
    addConstraint()
  }
  
  func registerCells(){
    self.register(UINib(nibName: photoCell.identifier, bundle: nil), forCellWithReuseIdentifier: photoCell.identifier)
    self.register(UINib(nibName: addNewphotoCell.identifier, bundle: nil), forCellWithReuseIdentifier: addNewphotoCell.identifier)
  }
  
  func addConstraint(){
    flowHeightConstraint =  self.heightAnchor.constraint(equalToConstant: 0)
    flowHeightConstraint?.isActive = true
  }
  
  func reloadCollection(){
    updateHConstraint(100)
  }
  
  func emptyCollection(){
    updateHConstraint(0)
  }
  
  func updateHConstraint(_ constant:CGFloat){
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.flowHeightConstraint?.constant = constant
                self.layoutIfNeeded()
                self.collectionViewTVC?.tableView.reloadData()
                self.reloadData()
            }, completion: nil)
    
//    DispatchQueue.main.async {
//      self.HConstraint?.constant = constant
//      UIView.animate(withDuration: 1, animations:{
//        self.layoutIfNeeded()
//      })
//      
//      }
  }
}

extension imagesCollectionView {

  
  func addNewphoto(){

      if imgs.count >= imgsLimit {
        Utilities.showAlert(collectionViewTVC!, messageToDisplay:(Strings.YouCanNotaddMore.Localized + " \(imgsLimit) ") + Strings.YouCanNotaddMore.Localized)
      }else {
          if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
              imagePicker.delegate = self
              imagePicker.sourceType = .savedPhotosAlbum;
              imagePicker.allowsEditing = false
              collectionViewTVC!.present(imagePicker, animated: true, completion: nil)
          }
      }
  }
  
}

extension imagesCollectionView:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  

  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return (imgs.count == 0)  ? 0:imgs.count+1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

      
          if indexPath.row == imgs.count  {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addNewphotoCell", for: indexPath) as! addNewphotoCell
              return cell
          }else {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCell
              cell.delegate = self
         
              if imgs[indexPath.row].img != nil {
                  cell.img.image = imgs[indexPath.row].img
              }

              cell.cellConfigration(indexPath.row)
              return cell
              
          }
      
     
      
      
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
          if indexPath.row == imgs.count  {
              addNewphoto()
          }
      
  }

  fileprivate var sectionInsets: UIEdgeInsets {
      return .zero
  }
  
  fileprivate var itemsPerRow: CGFloat {
      return 4
  }
  
  fileprivate var interitemSpace: CGFloat {
      return 8.0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
      
          let sectionPadding = sectionInsets.left * (itemsPerRow + 1)
          let interitemPadding = max(0.0, itemsPerRow - 1) * interitemSpace
          let availableWidth = collectionView.bounds.width - sectionPadding - interitemPadding
          let widthPerItem = availableWidth / itemsPerRow

          return CGSize(width: widthPerItem, height: 100)

  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 8.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      
      return interitemSpace
  }
}

extension imagesCollectionView :UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    
    
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let imgc = imageClass()
        imgc.img = chosenImage
        imgc.url = ""
     let imgData = chosenImage.jpegData(compressionQuality: 0.1)
       
            imgs.append(imgc)
            self.reloadData()
            selectedPhotos.append(chosenImage)
            imgsData.append(imgData!)
        
    
        //dlegate?.reload()
        reloadCollection()
        if imgs.count == 0 {
          //dlegate?.imgsEmpty()
          emptyCollection()
        }
    collectionViewTVC!.dismiss(animated:true, completion: nil)
        
    
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if imgs.count == 0 {
          //dlegate?.imgsEmpty()
          emptyCollection()
        }
      collectionViewTVC!.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        
        if imgs.count == 0 {
          //dlegate?.imgsEmpty()
          emptyCollection()
          }
      collectionViewTVC!.dismiss(animated: true, completion: { () -> Void in})
        //dlegate?.reload()
       reloadCollection()
        
    }
    
}


extension imagesCollectionView:photosDelegate {
    
    func remove(_ index: Int) {
        
            self.imgs.remove(at: index)
            imgsData.remove(at: index)
            selectedPhotos.remove(at: index)
            self.reloadData()
        if imgs.count == 0 {
          //dlegate?.imgsEmpty()
          emptyCollection()
        }
            
    }
}



extension UICollectionView {

  
var HConstraint: NSLayoutConstraint? {
    get {
        return constraints.first(where: {
            $0.firstAttribute == .height && $0.relation == .equal
        })
    }
    set { setNeedsLayout() }
}
  
}
