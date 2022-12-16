/*
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Order : Mappable {
    var order_id : String?
    var order_pros_quan : String?
    var order_company_id : String?
    var order_user_id : String?
    var order_details : String?
    var order_location : String?
    var order_worker_id : String?
    var order_total : String?
    var order_payment_with : String?
    var order_status : String?
    var order_discount : String?
    var order_products_total : String?
    var order_transaction_id : String?
    var order_vat_amount : String?
    var order_delivary_price : String?
    var order_address : String?
    var order_week_number : String?
    var order_bank_id : String?
    var order_code : String?
    var order_return_amount : String?
    var order_package_id : String?
    var order_store_id : String?
    var order_bank_account_name : String?
    var order_bank_thumb_id : String?
    var order_bank_account_number : String?
    var order_type : String?
    var order_package_period : String?
    var order_package_period_from : String?
    var order_package_period_to : String?
    var order_app_delivary_price : String?
    var order_city_id : String?
    var order_package_day : String?
    var order_reject_reason : String?
    var order_cancel_reason : String?
    var order_created_at : String?
    var product_count : String?
    var invoice_order : String?
    var company_name : String?
    var company_address : String?
    var company_map_location : String?
    var order_delivery_time : String?
    var order_cat_image : String?
    var user_name : String?
    var user_phone : String?
    var user_image : String?
    var imageUrl : String?
    var order_products : [OrderProducts]?
    var order_rate : OrderRate?
    var worker_name : String?
    var worker_rate : Int?
    var worker_total_rates : Int?
    var worker_supplier_code : Int?
    var fzza3_amount : String?
    var worker_amount : String?
    var created_since : String?

    init?(map: Map) {

    }

    func getTotalDeliveryPrice() -> Double
    {
        let delvPrice = Double(order_delivary_price ?? "0") ?? 0
        let delvAppPrice = Double(order_app_delivary_price ?? "0") ?? 0
        
        return delvPrice + delvAppPrice
    }
    func getPaymentMethod() -> String
    {
        switch order_payment_with {
        case "cash":
            return Resources.Common.cashOnDelivery
        case "net":
            return Resources.Common.netOnDelivery
        case "online":
            return Resources.Common.bankPayment
        case "bank":
            return Resources.Common.cashOnDelivery
        default:
            return Resources.Common.cashOnDelivery
        }
    }
    func getOrderType() -> String
    {
        switch order_type {
        case "fast":
            return Resources.Common.fastOrder
        case "normal":
            return Resources.Common.normalOrder
        default:
            return Resources.Common.fastOrder
        }
    }
    mutating func mapping(map: Map) {

        order_id <- map["order_id"]
        order_pros_quan <- map["order_pros_quan"]
        order_company_id <- map["order_company_id"]
        order_user_id <- map["order_user_id"]
        order_details <- map["order_details"]
        order_location <- map["order_location"]
        order_worker_id <- map["order_worker_id"]
        order_total <- map["order_total"]
        order_payment_with <- map["order_payment_with"]
        order_status <- map["order_status"]
        order_discount <- map["order_discount"]
        order_products_total <- map["order_products_total"]
        order_transaction_id <- map["order_transaction_id"]
        order_vat_amount <- map["order_vat_amount"]
        order_delivary_price <- map["order_delivary_price"]
        order_address <- map["order_address"]
        order_week_number <- map["order_week_number"]
        order_bank_id <- map["order_bank_id"]
        order_code <- map["order_code"]
        order_return_amount <- map["order_return_amount"]
        order_package_id <- map["order_package_id"]
        order_store_id <- map["order_store_id"]
        order_bank_account_name <- map["order_bank_account_name"]
        order_bank_thumb_id <- map["order_bank_thumb_id"]
        order_bank_account_number <- map["order_bank_account_number"]
        order_type <- map["order_type"]
        order_package_period <- map["order_package_period"]
        order_package_period_from <- map["order_package_period_from"]
        order_package_period_to <- map["order_package_period_to"]
        order_app_delivary_price <- map["order_app_delivary_price"]
        order_city_id <- map["order_city_id"]
        order_package_day <- map["order_package_day"]
        order_reject_reason <- map["order_reject_reason"]
        order_cancel_reason <- map["order_cancel_reason"]
        order_created_at <- map["order_created_at"]
        product_count <- map["product_count"]
        invoice_order <- map["invoice_order"]
        company_name <- map["company_name"]
        company_address <- map["company_address"]
        company_map_location <- map["company_map_location"]
        order_delivery_time <- map["order_delivery_time"]
        order_cat_image <- map["order_cat_image"]
        user_name <- map["user_name"]
        user_phone <- map["user_phone"]
        user_image <- map["user_image"]
        imageUrl <- map["imageUrl"]
        order_products <- map["order_products"]
        order_rate <- map["order_rate"]
        worker_name <- map["worker_name"]
        worker_rate <- map["worker_rate"]
        worker_total_rates <- map["worker_total_rates"]
        worker_supplier_code <- map["worker_supplier_code"]
        fzza3_amount <- map["fzza3_amount"]
        worker_amount <- map["worker_amount"]
        created_since <- map["created_since"]
    }

}
struct OrderProducts : Mappable {
    var pro_id : String?
    var pro_name : String?
    var pro_thumb_id : String?
    var pro_adv_id : String?
    var pro_kg_price : String?
    var pro_box_price : String?
    var pro_kg_discount_price : String?
    var pro_box_discount_price : String?
    var pro_kg_quantity : String?
    var pro_box_quantity : String?
    var pro_box_kilos_number : String?
    var unitkey : String?
    var unitEn : String?
    var quantity : String?
    var allText : String?
    var imageUrl : String?
    var unit : String?
    var single_price : String?
    var q_price : Double?
    var pro_unit_quantity : String?
    var pro_unit_price : String?


    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        pro_id <- map["pro_id"]
        pro_name <- map["pro_name"]
        pro_thumb_id <- map["pro_thumb_id"]
        pro_adv_id <- map["pro_adv_id"]
        pro_kg_price <- map["pro_kg_price"]
        pro_box_price <- map["pro_box_price"]
        pro_kg_discount_price <- map["pro_kg_discount_price"]
        pro_box_discount_price <- map["pro_box_discount_price"]
        pro_kg_quantity <- map["pro_kg_quantity"]
        pro_box_quantity <- map["pro_box_quantity"]
        pro_box_kilos_number <- map["pro_box_kilos_number"]
        unitkey <- map["unitkey"]
        unitEn <- map["unitEn"]
        quantity <- map["quantity"]
        allText <- map["allText"]
        imageUrl <- map["imageUrl"]
        unit <- map["unit"]
        single_price <- map["single_price"]
        q_price <- map["q_price"]
        pro_unit_quantity <- map["pro_unit_quantity"]
        pro_unit_price <- map["pro_unit_price"]

    }

    func getQuantity() -> String
    {
        if unitkey == "kg" {
            return Resources.Common.kg
        }
        else if unitkey == "box"{
            return Resources.Common.box
        }else {
            return Resources.Common.unit

        }
    }
}
struct OrderRate : Mappable {
    var rate_id : String?
    var rate_user_id : String?
    var rate_advertiser_id : String?
    var rate_order_id : String?
    var rate_number : String?
    var rate_review : String?
    var rate_created_at : String?
   
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        rate_id <- map["rate_id"]
        rate_user_id <- map["rate_user_id"]
        rate_advertiser_id <- map["rate_advertiser_id"]
        rate_order_id <- map["rate_order_id"]
        rate_number <- map["rate_number"]
        rate_review <- map["rate_review"]
        rate_created_at <- map["rate_created_at"]

    }

}
struct GroupOrders : Mappable {
    var active = [Order]()
    var wait = [Order]()
    var done = [Order]()
    var canceled = [Order]()
    var send_to_worker = [Order]()
    var order_delivered = [Order]()
    var worker_on_delivery = [Order]()

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        active <- map["active"]
        wait <- map["wait"]
        done <- map["done"]
        canceled <- map["canceled"]
        send_to_worker <- map["send_to_worker"]
        order_delivered <- map["order_delivered"]
        worker_on_delivery <- map["worker_on_delivery"]

    }

}
