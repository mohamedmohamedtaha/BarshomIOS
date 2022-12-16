//
//  ValidationHelper.swift
//  HalaHalaCar
//
//  Created by Yo7ia on 9/3/18.
//  Copyright © 2018 RMG. All rights reserved.
//



import Foundation

class ValidationHelper {
    
    let PassowrdMinLength = 8
    let PhoneMinLength = 5
    let PhoneMaxLength = 12
    
    typealias ValidationResult = Results<(), Errorr>
    
    // Name
    
    class func validateName(_ name: String) -> ValidationResult {
        guard name.trimmed.count > 0 else {
            return .error(.invalidName)
        }
        return .success
    }
    
    class func isValidName(_ name: String) -> Bool {
        return validateName(name).isSuccess
    }
    
    
    
    // Username
    
    
    class func validateUsername(_ username: String) -> ValidationResult {
        let count = username.trimmed.count
        
        if count == 0
        {
            return .error(.enterUsername)
        }
        else if count > 0
        {
            return .success
        }
        else
        {
            return .error(.invalidUsername)
        }
    }
    
    class func validateUserPassword(_ password: String) -> ValidationResult {
        let PassowrdMinLength = 6
        
        let count = password.trimmed.count
        
        if count == 0
        {
            return .error(.enterEightCharPassword)
        }
        else if count >= PassowrdMinLength
        {
            return .success
        }
        else
        {
            return .error(.enterEightCharPassword)
        }
    }
    
    class func validateUername(_ username: String) -> ValidationResult {
        guard username.trimmed.count > 0 else {
            return .error(.invalidUsername)
        }
        return .success
    }
    
    class func isValidUsername(_ username: String) -> Bool {
        return validateUsername(username).isSuccess
    }
    
    // Password
    
    class func validatePassword(_ password: String) -> ValidationResult {
        let PassowrdMinLength = 6
        
        guard password.count >= PassowrdMinLength else {
            return .error(.invalidPassword)
        }
        return .success
    }
    
    class func isValidPassword(_ password: String) -> Bool {
        return validateUserPassword(password).isSuccess
    }
    
    // Email
    
    class func validateEmail(_ email: String) -> ValidationResult {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        guard NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email) else {
            return .error(.invalidEmail)
        }
        return .success
    }
    
    class func isValidEmail(_ email: String) -> Bool {
        return validateEmail(email).isSuccess
    }
    
    // Phone
    
    class func validatePhone(_ phone: String) -> ValidationResult {
        let set = CharacterSet(charactersIn: "0123456789+").inverted
        let arr = phone.components(separatedBy: set)
        guard arr.count == 1 else {
            return .error(.invalidNumber)
        }
        
        let PhoneMinLength = 5
        let PhoneMaxLength = 12
        guard phone.count >= PhoneMinLength && phone.count <= PhoneMaxLength else {
            return .error(.invalidNumber)
        }
        
        return .success
    }
    
    class func isValidPhone(_ phone: String) -> Bool {
        if phone.isEmpty
        {
            return true
        }
        return validatePhone(phone).isSuccess
    }
}
//
//  Error.swift
//  Phunation
//
//  Created by AMIT Developer on 10/24/16.
//  Copyright © 2016 AMIT Software. All rights reserved.
//

import Foundation



enum Errorr: Int {
    case invalidEmail
    case invalidName
    case invalidNumber
    case noInternetConnection
    case requiredFieldsMissing
    
    // API errors
    case invalidInput = 2100
    case usernameExists = 2101
    case emailExists = 2102
    case invalidUsername = 2112
    case enterUsername = 2109
    case emptyCart = 2110
    case enterEightCharPassword = 2111
    case invalidItemsInCart = 2114
    
    case invalidPassword = 2104
    case userNotActivated = 2105
    
    case emailDoesNotExist = 2106 // Forgot password
    case usernameDoesNotExist = 2107 // Login
    case invalidOldPassword = 2108
    
    case unknown = 2200
}


extension Errorr {
    var message: String {
        switch self {
        case .invalidName:
            return NSLocalizedString("Invalid name", comment: "")
        case .invalidItemsInCart:
            return NSLocalizedString("Invalid name", comment: "")
            
        case .enterUsername:
            return NSLocalizedString("Please enter your username/email", comment: "")
            
        case .emptyCart:
            return NSLocalizedString("No services in your wishlist", comment: "")
            
        case .invalidInput:
            return NSLocalizedString("Invalid input", comment: "")
            
        case .invalidNumber:
            return NSLocalizedString("Invalid number", comment: "")
            
        case .noInternetConnection:
            return NSLocalizedString("No internet connection", comment: "")
            
        case .requiredFieldsMissing:
            return NSLocalizedString("Please fill all highlighted entries", comment: "")
            
        case .usernameExists:
            return NSLocalizedString("This username already used", comment: "")
            
        case .usernameDoesNotExist:
            return NSLocalizedString("Username does not exist", comment: "")
            
        case .emailExists:
            return NSLocalizedString("This email already used", comment: "")
            
        case .emailDoesNotExist:
            return NSLocalizedString("This email does not exist", comment: "")
            
        case .invalidUsername:
            return NSLocalizedString("This username or email does not exist", comment: "")
            
        case .invalidPassword:
            return NSLocalizedString("Wrong password", comment: "")
            
        case .enterEightCharPassword:
            return NSLocalizedString("Password must be at least 8 characters", comment: "")
            
        case .invalidEmail:
            return NSLocalizedString("Please enter a valid email address\nexample@gmail.com", comment: "")
            
        case .userNotActivated:
            return NSLocalizedString("User is not active yet, please go to your email to activate your account", comment: "")
            
        case .invalidOldPassword:
            return NSLocalizedString("Password entered not matched with current password", comment: "")
            
        case .unknown:
            return NSLocalizedString("Something went wrong", comment: "")
        }
    }
}
enum Results<T, E> {
    case success
    case error(E)
    
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .error(_): return false
        }
    }
}
