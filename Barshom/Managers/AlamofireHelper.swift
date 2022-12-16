//
//  AlamofireHelper.swift
//  Nepros
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation
import Alamofire

public class AlamofireHelper {
    
    private init() {
    }
    
    private static func handleResponse(value: AnyObject,code: Int) -> (AnyObject, Bool,Bool?)
    {
        print(value)
        if code == 200 {
            if let response = value as? [String: AnyObject] {
                
                let status = response["status"] as? Int
                if status == 200 {
                    return ( value , true,true)
                }
                else
                {
                    if let msg = response["message"] as? String {
                        if msg.contains("مفعل") {
                            return ( value , false,true)

                        }
                        else
                        {
                            AppHelper.showWarningAlert(message:msg)
                            return ( value , false,false)
                        }
                    }
                    else
                    {
                        AppHelper.showWarningAlert(message: Resources.WebServiceMananger.corruptedResponse)
                        return ( value , false,true)

                    }
                    
                }
            }
            else
            {
                return ( value , false,true)
            }
        }
        else
        {
            AppHelper.showWarningAlert(message: value.description)
            return ( value , false,true)
        }
        
//        if  code != 200 && code != 201 && code != 202 && code != 203 && code != 204 {
//            if code == 401
//            {
//                return (value, false,false)
//            }
//            else if (code == 404 || code == 400) && value.description!.lowercased().contains("code")
//            {
//                return (value, false,true)
//            }
//            else if (code == 404) && value.description!.lowercased().contains("found")
//            {
//                return ("not found" as AnyObject, true,true)
//            }
//            else if (code == 400) && value.description!.lowercased().contains("exist")
//            {
//                return ("exist" as AnyObject, true,true)
//            }
//            else
//            {
//                if let response = value as? [String: AnyObject] {
//
//                    var errorsMsg = ""//Resources.WebServiceMananger.reviewErrors + "\n"
//                    for (key,value) in response {
//                        if let x = value as? String
//                        {
//                            errorsMsg.append(x)
//                        }
//                        else if let x = value as? [String]
//                        {
//                            for i in x
//                            {
//                                errorsMsg.append(key + " : " + i + "\n")
//                            }
//                        }
//                    }
//                    AppHelper.showWarningAlert(message: errorsMsg)
//                }  else if let response = value as? [String] {
//                    var errorsMsg = ""//Resources.WebServiceMananger.reviewErrors + "\n"
//                    for msg in response
//                    {
//                        errorsMsg.append(msg + "\n")
//                    }
//                    AppHelper.showWarningAlert(message: errorsMsg)
//                }
//                else {
//                    AppHelper.showWarningAlert(message: Resources.WebServiceMananger.corruptedResponse)
//                }
//            }
//        }
//        else {
//            return (value, true,true)
//        }
        
        
       
    }
    public static func printErrors(error: Error, data: Data?) {
        NSLog("\n\n===========Error===========")
        NSLog("Error Code: \(error._code)")
        NSLog("Error Messsage: \(error.localizedDescription)")
        if let data = data, let str = String(data: data, encoding: String.Encoding.utf8){
            print("Server Error: " + str)
        }
        debugPrint(error as Any)
        NSLog("===========================\n\n")
    }
    
    // MARK: - Upload
    public static func uploadRequest(
        method: Alamofire.HTTPMethod,
        urlString : String,
        parameters: [String: Any]?,
        headers: [String:String]?,
        attachments: [Attachment],
        
        completion : @escaping (_ data: AnyObject, _ status: Bool) -> ()) -> Void {
        
        print(parameters?.description)
        print(urlString)
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for i in parameters!
                {
                    let x = (i.value as! String).data(using: .utf8)
                    multipartFormData.append(x!, withName: i.key)
                }
                for attachment in attachments where attachment.data != nil {
                    multipartFormData.append(
                        attachment.data!,
                        withName: attachment.name,
                        fileName: attachment.fileName,
                        mimeType: attachment.mimeType
                    )
                }
        },
            usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold,
            to: urlString,
            method: method,
            headers: headers) { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress {
                        progress in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    }
                    upload.responseJSON { response in
                        switch response.result {
                        case .success (let value):
                            Indicator.sharedInstance.dismiss()
                            if urlString.contains("maps.googleapis.com") {
                                completion(value as AnyObject,true)
                            }
                            else
                            {
                                let x = handleResponse(value: value as AnyObject,code: response.response!.statusCode)
                                if x.1
                                {
                                    completion(x.0 ,x.1)
                                }
                                else if x.2!
                                {
                                    completion(x.0,x.1)
                                }
                            }
                            
                        case .failure(let error):
                            Indicator.sharedInstance.dismiss()
                            printErrors(error: error, data: response.data)
                            AppHelper.showErrorAlert(message: error.localizedDescription)
                        }
                    }
                case .failure(let encodingError):
                    Indicator.sharedInstance.dismiss()
                    printErrors(error: encodingError, data: nil)
                    AppHelper.showErrorAlert(message: encodingError.localizedDescription)
                }
        }
        
    }
    
    // MARK: - Make Call
    public static func makeCallRequest(
        method: HTTPMethod,
        urlString : String,
        parameters: [String: Any]?,
        headers: [String:String]?,
        completion : @escaping (_ data: AnyObject, _ status: Bool) -> ()) -> Void {
        
        
        Alamofire.request(
            urlString,
            method: method,
            parameters: parameters!,
            encoding : URLEncoding.httpBody,
            headers: headers!).responseJSON {
                response in
                
                if let res = response.response, res.statusCode == 500 {
                    Indicator.sharedInstance.dismiss()
                    AppHelper.showErrorAlert(message: Resources.WebServiceMananger.connectionFailed)
                    return
                }
                
                switch response.result {
                case .success (let value):
                    Indicator.sharedInstance.dismiss()
                    let x = handleResponse(value: value as AnyObject,code: response.response!.statusCode)
                    if x.1
                    {
                        completion(x.0 ,x.1)
                    }
                    
                case .failure(let error):
                    Indicator.sharedInstance.dismiss()
                    printErrors(error: error, data: response.data)
                    AppHelper.showErrorAlert(message: error.localizedDescription)
                }
        }
        
    }
    public static func makeCallRequestCreate(
        method: HTTPMethod,
        urlString : String,
        parameters: [String: Any]?,
        headers: [String:String]?,
        completion : @escaping (_ data: AnyObject, _ status: Bool,_ secsecong: Bool) -> ()) -> Void {
        
        print(urlString)
        print(parameters)
        Alamofire.request(
            urlString,
            method: method,
            parameters: parameters!,
            encoding: JSONEncoding.default,
            headers: headers!).responseJSON {
                response in
                
                if let res = response.response, res.statusCode == 500 {
                    Indicator.sharedInstance.dismiss()
                    AppHelper.showErrorAlert(message: Resources.WebServiceMananger.connectionFailed)
                    return
                }
                
                switch response.result {
                case .success (let value):
                    Indicator.sharedInstance.dismiss()
                    let x = handleResponse(value: value as AnyObject,code: response.response!.statusCode)
                   
                        completion(x.0 ,x.1,x.2!)
                    
                case .failure(let error):
                    Indicator.sharedInstance.dismiss()
                    printErrors(error: error, data: response.data)
                    AppHelper.showErrorAlert(message: error.localizedDescription)
                }
        }
        
    }
    
    // MARK: - Load Data
    public static func loadDataRequest(
        method: Alamofire.HTTPMethod,
        urlString : String,
        parameters: [String: Any]?,
        headers: [String:String]?,
        completion : @escaping (Data) -> ()) -> Void
    {
        
        Alamofire.request(
            urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
            method: method,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers).response { (response) in
                if let res = response.response, res.statusCode == 500 {
                    Indicator.sharedInstance.dismiss()
                    AppHelper.showErrorAlert(message: Resources.WebServiceMananger.connectionFailed)
                    return
                }
                
                Indicator.sharedInstance.dismiss()
                if let _ = response.data {
                    completion(response.data!)
                }
        }
    }
}

