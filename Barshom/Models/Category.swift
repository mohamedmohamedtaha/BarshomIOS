/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Category : Mappable {
    var cat_id : String?
    var cat_name : String?
    var cat_nameEn : String?
    var image : String?
    var isSelected = false
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

        cat_id <- map["cat_id"]
        cat_name <- map["cat_name"]
        cat_nameEn <- map["cat_name"]
        image <- map["imageUrl"]
	}

}
struct FAQ : Mappable {
    var question_id : String?
    var question_title : String?
    var question_body : String?
    var isSelected = false
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        question_id <- map["question_id"]
        question_title <- map["question_title"]
        question_body <- map["question_body"]
    }

}
struct City : Mappable {
    var city_id : String?
    var city_name : String?
    var city_fast_order : String?
    var city_other_price : String?
    var city_delivery_price : String?
    var city_barshom_price : String?
    var city_other_normal_price : String?
    var city_barshom_normal_price : String?
    var city_parent_id : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        city_id <- map["city_id"]
        city_name <- map["city_name"]
        city_fast_order <- map["city_fast_order"]
        city_other_price <- map["city_other_price"]
        city_delivery_price <- map["city_delivery_price"]
        city_barshom_price <- map["city_barshom_price"]
        city_other_normal_price <- map["city_other_normal_price"]
        city_barshom_normal_price <- map["city_barshom_normal_price"]
        city_parent_id <- map["city_parent_id"]
    }

}

struct Bank : Mappable {
    var bank_id : String?
    var bank_name : String?
    var bank_ipan : String?
    var bank_thumb_id : String?
    var bank_image : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        bank_id <- map["bank_id"]
        bank_name <- map["bank_name"]
        bank_ipan <- map["bank_ipan"]
        bank_thumb_id <- map["bank_thumb_id"]
        bank_image <- map["bank_image"]
    }

}
struct SlideShow : Mappable {
    var ads_id : String?
    var ads_title : String?
    var image_url : String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        ads_id <- map["ads_id"]
        ads_title <- map["ads_title"]
        image_url <- map["image_url"]
    
    }

}
struct Message : Mappable {
    var iD : String?
    var msg_text : String?
    var msg_type_id : String?
    var msg_from_type : String?
    var msg_user_id : String?
    var other_user_name : String?
    var other_user_image : String?
    var msg_created_at : String?
    var created_since : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        iD <- map["ID"]
        msg_text <- map["msg_text"]
        msg_type_id <- map["msg_type_id"]
        msg_from_type <- map["msg_from_type"]
        msg_user_id <- map["msg_user_id"]
        other_user_name <- map["other_user_name"]
        other_user_image <- map["other_user_image"]
        msg_created_at <- map["msg_created_at"]
        created_since <- map["created_since"]
    }

}
