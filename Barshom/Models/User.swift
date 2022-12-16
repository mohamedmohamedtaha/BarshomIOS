/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct User : Mappable {
    var id : String?
    var adv_name : String?
    var adv_worker_type : String?
    var adv_owner_name : String?
    var adv_mobile : String?
    var adv_email : String?
    var adv_type : String?
    var adv_city_id : String?
    var adv_status : String?
    var adv_thumb_id : String?
    var adv_license_thumb_id : String?
    var adv_form_thumb_id : String?
    var adv_login_with : String?
    var adv_social_id : String?
    var adv_phone : String?
    var adv_map_location : String?
    var adv_bank_name : String?
    var adv_account_name : String?
    var adv_car_plate_number : String?
    var adv_commercial_record_id : String?
    var adv_car_type : String?
    var adv_ipan_number : String?
    var adv_connect_with : String?
    var adv_app_player_id : String?
    var adv_order : Int?
    var adv_account_number : String?
    var adv_balance : String?
    var adv_market_id : String?
    var adv_package_id : String?
    var adv_package_transaction_id : String?
    var adv_expire_date : String?
    var adv_rate : String?
    var adv_user_code : String?
    var adv_friend_code : String?
    var adv_delivery_time : String?
    var adv_address : String?
    var adv_get_orders : String?
    var adv_points : String?
    var adv_market_type : String?
    var adv_identification : String?
    var licenseImage : String?
    var commercialRecordImage : String?
    var formImage : String?
    var cat_name : String?
    var city_name : String?
    var imageUrl :String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["adv_id"]
        adv_name <- map["adv_name"]
        adv_worker_type <- map["adv_worker_type"]
        adv_owner_name <- map["adv_owner_name"]
        adv_mobile <- map["adv_mobile"]
        adv_email <- map["adv_email"]
        adv_type <- map["adv_type"]
        adv_city_id <- map["adv_city_id"]
        adv_status <- map["adv_status"]
        adv_thumb_id <- map["adv_thumb_id"]
        adv_license_thumb_id <- map["adv_license_thumb_id"]
        adv_form_thumb_id <- map["adv_form_thumb_id"]
        adv_login_with <- map["adv_login_with"]
        adv_social_id <- map["adv_social_id"]
        adv_phone <- map["adv_phone"]
        adv_map_location <- map["adv_map_location"]
        adv_bank_name <- map["adv_bank_name"]
        adv_account_name <- map["adv_account_name"]
        adv_car_plate_number <- map["adv_car_plate_number"]
        adv_commercial_record_id <- map["adv_commercial_record_id"]
        adv_car_type <- map["adv_car_type"]
        adv_ipan_number <- map["adv_ipan_number"]
        adv_connect_with <- map["adv_connect_with"]
        adv_app_player_id <- map["adv_app_player_id"]
        adv_order <- map["adv_order"]
        adv_account_number <- map["adv_account_number"]
        adv_balance <- map["adv_balance"]
        adv_market_id <- map["adv_market_id"]
        adv_package_id <- map["adv_package_id"]
        adv_package_transaction_id <- map["adv_package_transaction_id"]
        adv_expire_date <- map["adv_expire_date"]
        adv_rate <- map["adv_rate"]
        adv_user_code <- map["adv_user_code"]
        adv_friend_code <- map["adv_friend_code"]
        adv_delivery_time <- map["adv_delivery_time"]
        adv_address <- map["adv_address"]
        adv_get_orders <- map["adv_get_orders"]
        adv_points <- map["adv_points"]
        adv_market_type <- map["adv_market_type"]
        adv_identification <- map["adv_identification"]
        licenseImage <- map["licenseImage"]
        commercialRecordImage <- map["commercialRecordImage"]
        formImage <- map["formImage"]
        cat_name <- map["cat_name"]
        city_name <- map["city_name"]
        imageUrl <- map["imageUrl"]
    }

    func getUserKey()->String
    {
        switch adv_type {
        case "user":
          return "userId"
        case "company":
            return "advId"
        case "worker":
            return "workerId"

        default:
            return "userId"

        }
    }
    func getLat()->String
    {
        return adv_map_location!.components(separatedBy: ",")[0]
    }
    func getLng()->String
    {
        return adv_map_location!.components(separatedBy: ",")[1]
    }
}
