//
//  WebserviceMananger.swift
//  MySchool
//
//  Created by MacBook Pro on 27/12/2016.
//  Copyright © 2016 MacBook Pro. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

class WebserviceMananger: NSObject {
    
    var imgsIds = [String]()
    
    struct Singleton {
        static let instance = WebserviceMananger()
    }
    
    class var sharedInstance: WebserviceMananger {
        return Singleton.instance
    }
    
    var accesskey = "CCQQ2sfW222wwfyv5w557Rt"
    var accessPassword = "Q20R30Uu10jyt1ES5WWsdQM"

  
    
  func getPrameterByCredentials(_ parameters: [String: AnyObject]?)->[String: AnyObject]{
    var args:[String:AnyObject] = [:]
    if parameters != nil {
      args = parameters!
    }
    args.updateValue(accesskey as AnyObject, forKey: "access_key")
    args.updateValue(accessPassword as AnyObject, forKey: "access_password")
    args.updateValue(Language.currentLanguage() as AnyObject, forKey: "app_lang")
    return args
  }
  
  
  func showProgress(_ isProgress:Bool = true, endEdit:Bool = true,vc:UIViewController){
    if endEdit {
     vc.view.endEditing(true)
    }
    if isProgress {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show(onView: vc.view)

    }
  }
  
  func hideProgress(){
    PKHUD.sharedHUD.hide()
  }
  
  
    func makeCall(method: Alamofire.HTTPMethod, urlString : String, parameters: [String: AnyObject]? , vc:UIViewController ,progress:Bool = true ,endEdit:Bool = true , completionHandler : @escaping (AnyObject?,NSError?) -> ()) -> Void
    {
        
        showProgress(progress,endEdit: endEdit, vc: vc)

            AF.request(urlString, method: method, parameters: getPrameterByCredentials(parameters)) .responseJSON { response in
             
                switch response.result {
                case .success (let value):
                    self.hideProgress()
                    completionHandler(value as AnyObject?, nil)
                case .failure(let error):
                    self.hideProgress()
                    completionHandler(nil, error as NSError?)
                }
            }
            
       
    }

    func makeCallWithEncoding(method: Alamofire.HTTPMethod, urlString : String, parameters: [String: AnyObject]? , vc:UIViewController ,progress:Bool = true , completionHandler : @escaping (AnyObject?,NSError?) -> ()) -> Void
    {
      
        
        if Reachability.isConnectedToNetwork() {
            
          showProgress(progress, vc: vc)
           
            AF.request(urlString, method: method, parameters: getPrameterByCredentials(parameters), encoding: JSONEncoding.default).responseJSON { response in
                
                switch response.result {
                case .success (let value):
                    self.hideProgress()
                    completionHandler(value as AnyObject?, nil)
                case .failure(let error):
                    self.hideProgress()
                    completionHandler(nil, error as NSError?)
                }
            }
            
        } else {
            
            
            self.hideProgress()
            Utilities.showAlert(vc, messageToDisplay : "لا يوجد اتصال بالإنترنت")
        }
    }

    
  func makeCallWithImgimg(_ urlString : String, files:Data? ,arg:[String:AnyObject]  , vc:UIViewController  , completionHandler : @escaping (AnyObject?,NSError?) -> ()) -> Void
  {
      if Reachability.isConnectedToNetwork() {
          
        showProgress(true, vc: vc)
          
        AF.upload(multipartFormData: { multipartFormData in
          
          for (key, value) in self.getPrameterByCredentials(arg) {
              multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
          }
          
          if files != nil {
              multipartFormData.append(files!, withName: "imageData", fileName: "imageData.jpg", mimeType: "image/jpg")
          }
          
          },
            to: urlString, method: .post )
            .responseJSON(completionHandler: { (response) in
                
                print(response)
                
                if let err = response.error{
                    print(err)
                  PKHUD.sharedHUD.hide()
                  completionHandler(nil, err as NSError )
                    return
                }
                
                let json = response.value
                
                if (json != nil)
                {
                  vc.view.endEditing(true)
                  PKHUD.sharedHUD.hide()
                  completionHandler(json as AnyObject?, nil)
             
                }
            })
        

          
          
      } else {
          
          PKHUD.sharedHUD.hide()
          Utilities.showAlert(vc, messageToDisplay : "لا يوجد اتصال بالإنترنت")
          
      }
  }
  
    
  func message(_ urlString : String,soundName:String = "soundData.mp3",img:Data?,sound:Data? ,args:[String:AnyObject]  , vc:UIViewController  , completionHandler : @escaping (AnyObject?,NSError?) -> ()) -> Void
  {
      if Reachability.isConnectedToNetwork() {
          
        showProgress(true, vc: vc)
          
        AF.upload(multipartFormData: { multipartFormData in
          
          for (key, value) in self.getPrameterByCredentials(args) {
            
            
              multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
          }
          
          if img != nil {
              multipartFormData.append(img!, withName: "imageData", fileName: "imageData.jpg", mimeType: "image/jpg")
          }
            
//            if sound != nil {
//            multipartFormData.append(sound!, withName: "soundData")
//
//           // multipartFormData.append(sound!, withName: "soundName")
//            }
          if sound != nil {
              multipartFormData.append(sound!, withName: "soundData", fileName: "recording.mp3", mimeType: "audio/mp3")
          }
          
          
          },
            to: urlString, method: .post )
            .responseJSON(completionHandler: { (response) in
                
                print(response)
                
                if let err = response.error{
                    print(err)
                  PKHUD.sharedHUD.hide()
                  completionHandler(nil, err as NSError )
                    return
                }
                
                let json = response.value
                
                if (json != nil)
                {
                  vc.view.endEditing(true)
                  PKHUD.sharedHUD.hide()
                  completionHandler(json as AnyObject?, nil)
             
                }
            })
        

          
          
      } else {
          
          PKHUD.sharedHUD.hide()
          Utilities.showAlert(vc, messageToDisplay : "لا يوجد اتصال بالإنترنت")
          
      }
  }
  
    func uploadimgs(_ urlString : String, files:[Data] ,productId:String  , vc:UIViewController  , completionHandler : @escaping (AnyObject?,NSError?) -> ()) -> Void
    {
        if Reachability.isConnectedToNetwork() {
            
          showProgress(true, vc: vc)
            
          AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in self.getPrameterByCredentials(nil) {
                multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            for i in files {
                multipartFormData.append(i, withName: "image[]", fileName: "image.jpg", mimeType: "image/jpg")
            }
            
            },
              to: urlString, method: .post )
              .responseJSON(completionHandler: { (response) in
                  
                  print(response)
                  
                  if let err = response.error{
                      print(err)
                    PKHUD.sharedHUD.hide()
                    completionHandler(nil, err as NSError )
                      return
                  }
                  
                  let json = response.value
                  
                  if (json != nil)
                  {
                    vc.view.endEditing(true)
                    completionHandler(json as AnyObject?, nil)
               
                  }
              })
          
  
            
            
        } else {
            
            PKHUD.sharedHUD.hide()
            Utilities.showAlert(vc, messageToDisplay : "لا يوجد اتصال بالإنترنت")
            
        }
    }
    

 
    
}
