/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Products : Mappable {
    var pro_id : String?
    var pro_name : String?
    var pro_adv_id : String?
    var pro_rate : String?
    var pro_details : String?
    var pro_store_id : String?
    var pro_cat_id : String?
    var pro_kg_discount_price : String?
    var pro_box_discount_price : String?
    var pro_kg_quantity : String?
    var pro_box_quantity : String?
    var pro_box_kilos_number : String?
    var pro_kg_price : String?
    var pro_box_price : String?
    var pro_thumb_id : String?
    var pro_unit_quantity : String?
    var pro_unit_discount_price : String?
    var pro_unit_price : String?

    
    var rates = [Rates]()
    var cat_name : String?
    var discount_per : String?
    var imageUrl : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        pro_id <- map["pro_id"]
        pro_name <- map["pro_name"]
        pro_adv_id <- map["pro_adv_id"]
        pro_rate <- map["pro_rate"]
        pro_details <- map["pro_details"]
        pro_store_id <- map["pro_store_id"]
        pro_cat_id <- map["pro_cat_id"]
        pro_kg_discount_price <- map["pro_kg_discount_price"]
        pro_box_discount_price <- map["pro_box_discount_price"]
        pro_kg_quantity <- map["pro_kg_quantity"]
        pro_box_quantity <- map["pro_box_quantity"]
        pro_box_kilos_number <- map["pro_box_kilos_number"]
        pro_kg_price <- map["pro_kg_price"]
        pro_box_price <- map["pro_box_price"]
        pro_thumb_id <- map["pro_thumb_id"]
        rates <- map["rates"]
        cat_name <- map["cat_name"]
        discount_per <- map["discount_per"]
        imageUrl <- map["imageUrl"]
        pro_unit_quantity <- map["pro_unit_quantity"]
       
        pro_unit_discount_price <- map["pro_unit_discount_price"]
        pro_unit_price <- map["pro_unit_price"]

    }

}

struct Rates : Mappable {
    var rate_id : String?
    var rate_value : String?
    var rate_user_id : String?
    var rate_body : String?
    var user_name : String?
    var user_image : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        rate_id <- map["rate_id"]
        rate_value <- map["rate_value"]
        rate_user_id <- map["rate_user_id"]
        rate_body <- map["rate_body"]
        user_name <- map["user_name"]
        user_image <- map["user_image"]
    }

}
