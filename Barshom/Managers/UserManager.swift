//
//  UserManager.swift
//  HalaHalaCar
//
//  Created by Muhammad Azmi Al Hashemi on 9/4/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation

class UserManager: BaseUserManager {
    
    private static let UserDataKey = "UserDataKey"
    private static let UserCityKey = "UserCityKey"

    public static var getUserData: User? {
        get {
            if let x = UserDefaultsManager.getUserPreference(UserDataKey) as? Data
            {
                let dict = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(x)as! [String: Any]
                return User(JSON: dict)
            }
            return nil
        }
    }
    public static var getUserCity: City? {
        get {
            if let x = UserDefaultsManager.getUserPreference(UserCityKey) as? Data
            {
                let dict = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(x)as! [String: Any]
                return City(JSON: dict)
            }
            return nil
        }
    }
    
    
    
}
