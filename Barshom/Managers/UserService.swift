//
//  AuthService.swift
//  HalaHalaCar
//
//  Created by Muhammad Azmi Al Hashemi on 9/23/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation

var isNormalLogin = true
import Firebase
class UserService {
    
    private init() {}
    public var currentAppSettings : appSettings?
    public static let shared = UserService()
    
    struct NotificationKeys {
        static let didLogin = "didLoginNotificationKey"
        static let didUpdateProfile = "didUpdateProfileNotificationKey"
    }
    
    func login(
        parameter: [String: Any],
        showProgress: Bool? = true,
        completion: ((Any,Bool) -> Void)? = nil) {
        let pars = parameter

//        print("token" + " - - -" + InstanceID.instanceID().token()!)
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.Users.login,
            parameters: pars,
            headers: nil,
            attachments: [],
            showProgress: showProgress) {
                (data, status) in
                if !status
                {
                    completion?(data,status)
                    return
                }
                else
                {
                    if let x = data as? [String : Any]
                    {
                        let user = x["return"] as! [String : Any]
                        UserManager.saveUserInfo(user: user)
                        completion?(user,true)
                    }
                }
                      
        }
        
    }
    
    func getUserData(
        userID: String,
        completion: (([String: Any]) -> Void)? = nil) {
        
        let  pars = ["userId":userID]
        WebServiceMananger.makeCallJSON(
            method: .post,
            urlString: Constants.APIProvider.Users.getUserData,
            parameters: pars,
            headers: nil) {
                (data, status) in
                if let x = data as? [String : Any]
                {
                    let user = x["return"] as! [String : Any]
//                    UserManager.saveUserInfo(user: user)
                    completion?(user)
                }
        }
        
    }
    
    func changeReceiveOrders(
        status: String,
        completion: (([String: Any]) -> Void)? = nil) {
        
        let  pars = ["userId":UserManager.getUserData!.id,"getOrders":status]
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.changeReceiveOrders,
            parameters: pars,
            headers: nil,
            attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    
    func submitFeedback(
        comment: String,
        name: String,
        email: String,
        completion: (([String: Any]) -> Void)? = nil) {
        
        let  pars = ["contact_message":comment,"contact_name":name,"contact_email":email]
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.submitFeedback,
            parameters: pars,
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func updateUserToken(
        token: String,
        completion: (([String: Any]) -> Void)? = nil) {
        
        let  pars = ["playerId":token,"userId":UserManager.getUserData!.id!]
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.Users.updateUserToken,
            parameters: pars,
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func addEditProduct(
        isAdd: Bool,
        parameters : [String: Any],
        image: Attachment!,
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: isAdd ? Constants.APIProvider.addProduct : Constants.APIProvider.editProduct,
            parameters: parameters,
            headers: nil, attachments: [image]) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
    }
    func addEditCategory(
        isAdd: Bool,
        parameters : [String: Any],
        image: Attachment!,
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: isAdd ? Constants.APIProvider.addTraderDepartment : Constants.APIProvider.editTraderDepartment,
            parameters: parameters,
            headers: nil, attachments: [image]) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
    }
    func addTraderDepartment(
        parameters : [String: Any],
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.addTraderDepartment,
            parameters: parameters,
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }

    
    
    func register(
        parameters: [String: Any],
        images: [Attachment],
        completion: ((Any?) -> Void)? = nil){
        var pars = parameters
        pars.updateValue("", forKey: "fcm_token")
        WebServiceMananger.upload(method: .post, urlString: Constants.APIProvider.Users.register , parameters: pars, headers: nil, attachments: images) { (data, status) in
            
            if let x = data as? [String : Any]
            {
                
                completion?(x)
            }
            else
            {
               completion?(nil)

            }
        }
        
        
        
    }
    func updateUserProfile(
        parameters: [String: Any],
        images: [Attachment],
        completion: ((Any?) -> Void)? = nil){
        var pars = parameters
        pars.updateValue("", forKey: "fcm_token")
//        pars.updateValue(InstanceID.instanceID().token()!, forKey: "fcm_token")
//       print("token" + " - - -" + InstanceID.instanceID().token()!)
        WebServiceMananger.upload(method: .post, urlString: Constants.APIProvider.Users.updateProfile , parameters: pars, headers: nil, attachments: images) { (data, status) in
            
            if let x = data as? [String : Any]
            {
                
                completion?(x)
            }
            else
            {
               completion?(nil)

            }
        }
        
        
        
    }
    func updateUserPassword(
        parameters: [String: Any],
        completion: ((Any?) -> Void)? = nil){
        var pars = parameters
        pars.updateValue("", forKey: "fcm_token")
//        pars.updateValue(InstanceID.instanceID().token()!, forKey: "fcm_token")
//       print("token" + " - - -" + InstanceID.instanceID().token()!)
        WebServiceMananger.upload(method: .post, urlString: Constants.APIProvider.Users.updateProfile , parameters: pars, headers: nil, attachments: []) { (data, status) in
            
            if let x = data as? [String : Any]
            {
                
                completion?(x)
            }
            else
            {
               completion?(nil)

            }
        }
        
        
        
    }

    func activate(parameters : [String: Any],
                  completion: ((Any,Bool) -> Void)? = nil){
        
        
        
        WebServiceMananger.makeCall(
            method: .post,
            urlString: Constants.APIProvider.Users.activateProfile,
            parameters: parameters,
            headers: nil) {
                (data, status) in
            if !status
            {
                completion?(data,status)
                return
            }
            else
            {
                if let x = data as? [String : Any]
                {
                    let user = x["return"] as! [String : Any]
                    completion?(user,true)
                }
            }
        }
        
        
    }

    func forgetPassword(parameters : [String: Any],
                  completion: ((Any,Bool) -> Void)? = nil){
        
        
        
        WebServiceMananger.makeCall(
            method: .post,
            urlString: Constants.APIProvider.Users.forgetPassword,
            parameters: parameters,
            headers: nil) {
                (data, status) in
            if !status
            {
                completion?(data,status)
                return
            }
            else
            {
                if let x = data as? [String : Any]
                {
                    let user = x["return"]
                    completion?(user,true)
                }
            }
        }
        
        
    }
    func checkForgotPassword(parameters : [String: Any],
                  completion: ((Any,Bool) -> Void)? = nil){
        
        
        
        WebServiceMananger.makeCall(
            method: .post,
            urlString: Constants.APIProvider.Users.checkForgotPassword,
            parameters: parameters,
            headers: nil) {
                (data, status) in
            if !status
            {
                completion?(data,status)
                return
            }
            else
            {
                if let x = data as? [String : Any]
                {
                    let user = x["return"]
                    completion?(user,true)
                }
            }
        }
        
        
    }
    
    func resetPassword(parameters : [String: Any],
                  completion: ((Any,Bool) -> Void)? = nil){
        
        
        
        WebServiceMananger.makeCall(
            method: .post,
            urlString: Constants.APIProvider.Users.resetPassword,
            parameters: parameters,
            headers: nil) {
                (data, status) in
            if !status
            {
                completion?(data,status)
                return
            }
            else
            {
                if let x = data as? [String : Any]
                {
                    let user = x["return"]
                    completion?(user,true)
                }
            }
        }
        
        
    }
    
    
    func getTermsAbout(url:String ,completion: @escaping ((_ clinics: String) -> Void)) {
        
        
        WebServiceMananger.upload(
            method: .post,
            urlString: url,
            parameters: nil,
            headers: nil, attachments: []) {
                (data, status) in
                
            guard let dicJSON = data as? [String: Any] else {
                completion("")
                return
            }
             completion(dicJSON["return"] as! String)
        }
        
    }
    

    
    func getUserOrders(status: String,completion: @escaping ((_ clinics: GroupOrders) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString:  Constants.APIProvider.getUserOrders ,
            parameters: [UserManager.getUserData!.getUserKey():UserManager.getUserData!.id!,"status":status],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion(GroupOrders(JSONString: "")!)
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [String: Any] else {
                    completion(GroupOrders(JSONString: "")!)
                    return
                }
            
                completion(GroupOrders(JSON: dicArrayJSON)!)
        }
    }
    func getOrderDetails(orderId: String,completion: @escaping ((_ clinics: Order) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString:  Constants.APIProvider.getOrderDetails ,
            parameters: ["orderId":orderId],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion(Order(JSONString: "")!)
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [String: Any] else {
                    completion(Order(JSONString: "")!)
                    return
                }
            
                completion(Order(JSON: dicArrayJSON)!)
        }
    }
    func getAppSettings(completion: @escaping ((_ clinics: appSettings) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString:  Constants.APIProvider.getSettings ,
            parameters: nil,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion(appSettings(JSONString: "")!)
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [String: Any] else {
                    completion(appSettings(JSONString: "")!)
                    return
                }
            self.currentAppSettings = appSettings(JSON: dicArrayJSON)!
            completion(self.currentAppSettings!)
        }
        
    }
    func getMealDetails(mealId:String,completion: @escaping ((_ clinics: Products?) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getMealDetails,
            parameters: ["id_meal":mealId],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion(nil)
                    return
                }
                guard let dicArrayJSON = dicJSON["data"] as? [[String: Any]] else {
                    completion(nil)
                    return
                }
                
                var clinics: [Products] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Products(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
            completion(clinics.first)
        }
        
    }
    
    func getTraderDepartments(completion: @escaping ((_ clinics: [Category]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getTraderDepartments,
            parameters: ["id":UserManager.getUserData!.id!],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["category_productivefamily"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Category] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Category(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getDriverWithdraws(completion: @escaping ((_ clinics: [WithdrawBalance]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getWithdrawRequests,
            parameters: ["userId":UserManager.getUserData!.id!],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [WithdrawBalance] = []
                for countryJSON in dicArrayJSON {
                    guard let country = WithdrawBalance(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getSections(completion: @escaping ((_ clinics: [Category]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getSections,
            parameters: nil,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["data"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Category] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Category(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getShifts(completion: @escaping ((_ clinics: [Shifts]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getShifts,
            parameters: nil,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Shifts] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Shifts(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getMarketCategory(userId:String,completion: @escaping ((_ clinics: [Category]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getMarketCategory,
            parameters: ["userId":userId],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Category] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Category(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    
    func getUserPackages(userId:String,completion: @escaping ((_ clinics: [Package]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getUserPackages,
            parameters: ["userId":userId],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Package] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Package(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getMarketPackages(userId:String,isSub: Bool,completion: @escaping ((_ clinics: [TraderPackage]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: isSub ? Constants.APIProvider.getMarketSubPackages : Constants.APIProvider.getMarketPackages,
            parameters: ["userId":userId],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [TraderPackage] = []
                for countryJSON in dicArrayJSON {
                    guard let country = TraderPackage(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    
    func getProducts(pars:[String:Any],completion: @escaping ((_ clinics: [Products]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getProducts,
            parameters: pars,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Products] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Products(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getOtherMarkets(pars:[String:Any],completion: @escaping ((_ clinics: [Store]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getOtherMarkets,
            parameters: pars,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Store] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Store(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getTickets(completion: @escaping ((_ clinics: [Ticket]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getComplaints,
            parameters: ["userId":UserManager.getUserData!.id!],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Ticket] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Ticket(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getTicketMessages(ticketId:String ,completion: @escaping ((_ clinics: [Message]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getComplaintMessages,
            parameters: ["userId":UserManager.getUserData!.id!,"complainId":ticketId],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Message] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Message(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getCities(completion: @escaping ((_ clinics: [City]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getCities,
            parameters: nil,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [City] = []
                for countryJSON in dicArrayJSON {
                    guard let country = City(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    
    
    func getBanks(completion: @escaping ((_ clinics: [Bank]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getBanks,
            parameters: nil,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Bank] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Bank(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    
    
    func getMnadeeb(params :[String:Any] ,completion: @escaping ((_ clinics: [Worker]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getWorkers,
            parameters: params,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var workers: [Worker] = []
                for workerJSON in dicArrayJSON {
                    var id : Int = -1
                    if workerJSON["adv_id"] is Int{
                        id = workerJSON["adv_id"] as! Int
                    }
                    if workerJSON["adv_id"] is String{
                        id = Int((workerJSON["adv_id"] as! String)) ?? -1
                    }
                    
                    let worker = Worker(adv_id: id, adv_name: (workerJSON["adv_name"] as? String ?? ""), adv_email: (workerJSON["adv_email"] as? String ?? "") )
//                    guard let worker = Worker(JSON: workerJSON) else { continue }
                    workers.append(worker)
                }
                completion(workers)
        }
        
    }
    
    
    func getSlideShow(completion: @escaping ((_ clinics: [SlideShow]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getAdsense,
            parameters: nil,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [SlideShow] = []
                for countryJSON in dicArrayJSON {
                    guard let country = SlideShow(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getUserNotifications(completion: @escaping ((_ clinics: [Notifications]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getUserNotifications,
            parameters: ["userId":UserManager.getUserData!.id!],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Notifications] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Notifications(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getUserAddress(completion: @escaping ((_ clinics: [AddressModel]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getUserAddress,
            parameters: ["userId":UserManager.getUserData!.id!],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [AddressModel] = []
                for countryJSON in dicArrayJSON {
                    guard let country = AddressModel(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func addUserAddress(pars:[String:Any] ,completion: (([String: Any]) -> Void)? = nil) {

        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.addUserAddress,
            parameters: pars,
            attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
        }
        
    }
    func addWithdrawRequest(pars:[String:Any] ,completion: (([String: Any]) -> Void)? = nil) {

        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.addWithdrawRequest,
            parameters: pars,
            attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
        }
        
    }
    func getPlaceDetails(lat:String,lng:String , completion: @escaping ((_ clinics: [Place]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getPlaceByLocation(lat: lat, lng: lng),
            parameters: nil,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["results"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Place] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Place(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getFAQ(completion: @escaping ((_ clinics: [FAQ]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.commonQuestions,
            parameters: nil,
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["return"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [FAQ] = []
                for countryJSON in dicArrayJSON {
                    guard let country = FAQ(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    
    func deleteNotification(
        notId : String,
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.deleteNotification,
            parameters: ["userId":UserManager.getUserData!.id!,"notifyId":notId],
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func cancelOrder(
        url: String,
        orderId : String,
        orderReason : String,
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: url,
            parameters: ["userId":UserManager.getUserData!.id!,"orderId":orderId,"reason":orderReason],
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func sendOrder(
        pars: [String:Any],
        attach: Attachment?,
        completion: (([String: Any]) -> Void)? = nil) {
        
        var attachments = [Attachment]()
        if attach != nil {
            attachments.append(attach!)
        }
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.sendOrder,
            parameters: pars,
            headers: nil, attachments: attachments) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func subscribeClientPackage(
        pars: [String:Any],
        attach: Attachment?,
        completion: (([String: Any]) -> Void)? = nil) {
        
        var attachments = [Attachment]()
        if attach != nil {
            attachments.append(attach!)
        }
        WebServiceMananger.upload(
            method: .post,
            urlString: UserManager.getUserData!.adv_type == "user" ? Constants.APIProvider.subscribeClientPackage : Constants.APIProvider.subscribeUserPackage,
            parameters: pars,
            headers: nil, attachments: attachments) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
    }
    func sendComplaint(
        pars: [String:Any],
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.sendComplaint,
            parameters: pars,
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func sendTicketMessage(
        pars: [String:Any],
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.sendComplainMessage,
            parameters: pars,
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func reportProduct(
        pars: [String:Any],
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.reportProduct,
            parameters: pars,
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func applyDiscountCoupon(
        pars: [String:Any],
        completion: ((Coupon?) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.applyCoupon,
            parameters: pars,
            headers: nil, attachments: []) {
                (data, status) in
                
            guard let dicJSON = data as? [String: Any] else {
                completion!(nil)
                return
            }
            guard let dicArrayJSON = dicJSON["return"] as? [String: Any] else {
                completion!(nil)
                return
            }
            
            
            completion?(Coupon(JSON: dicArrayJSON ))
                
        }
        
    }
    func rateOrder(
        pars: [String:Any],
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.rateOrder,
            parameters: pars,
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func rateProduct(
        pars: [String:Any],
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.rateProduct,
            parameters: pars,
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func cancelComplaint(
        complainId: String,
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.closeComplaint,
            parameters: ["userId":UserManager.getUserData!.id!,"typeId":complainId],
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func deleteCategory(
        complainId: String,
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.deleteCategory,
            parameters: ["userId":UserManager.getUserData!.id!,"catId":complainId],
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func deleteProduct(
        complainId: String,
        completion: (([String: Any]) -> Void)? = nil) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.deleteProduct,
            parameters: ["userId":UserManager.getUserData!.id!,"proId":complainId],
            headers: nil, attachments: []) {
                (data, status) in
                
            completion?(data as! [String : Any])
                
        }
        
    }
    func getTraderProductsByCat(catId:String ,completion: @escaping ((_ clinics: [Products]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getTraderProductsByCat,
            parameters: ["user_id":UserManager.getUserData!.id!,"category":catId],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["data"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Products] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Products(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    
    func getTraderBills(completion: @escaping ((_ clinics: [Bills]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getTraderBills,
            parameters: ["user_id":UserManager.getUserData!.id!],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["data"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Bills] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Bills(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
    func getTraderOffers(completion: @escaping ((_ clinics: [Category]) -> Void)) {
        
        WebServiceMananger.upload(
            method: .post,
            urlString: Constants.APIProvider.getTraderOffers,
            parameters: ["user_id":UserManager.getUserData!.id!],
            attachments: []) {
                (data, status) in
                
                guard let dicJSON = data as? [String: Any] else {
                    completion([])
                    return
                }
                guard let dicArrayJSON = dicJSON["data"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                var clinics: [Category] = []
                for countryJSON in dicArrayJSON {
                    guard let country = Category(JSON: countryJSON) else { continue }
                    clinics.append(country)
                }
                completion(clinics)
        }
        
    }
}
