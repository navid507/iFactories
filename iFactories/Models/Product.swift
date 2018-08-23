//
//  Product.swift
//  iFactories
//
//  Created by navid einackchi on 6/14/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import Foundation
import SwiftyJSON
class Product {
    
    var  id: Int = -1
    var name: String = ""
    var image: String = ""
    var brand: String = ""
    var  unit: String = ""
    var  price: String = ""
    var  discount: String = ""
    var  inventory: String = ""
    var  productionDate: String = ""
    var  expireDate: String = ""
    var  minOrder: String = ""
    var  deliveryTime: String = ""
    var  desc: String = ""
    var  parent_id: Int = -1
    var state: Bool = false
    static func parseProduct(obj: JSON) -> Product {
        let prd = Product()
        prd.id = obj["id"].intValue
        prd.image = obj["img"].stringValue
        prd.desc = obj["desc"].stringValue
        prd.name = obj["title"].stringValue
        prd.brand = obj["brand"].stringValue
        prd.unit = obj["unit"].stringValue
        prd.price = obj["price"].stringValue
        prd.discount = obj["discount"].stringValue
        prd.inventory = obj["inventory"].stringValue
        prd.productionDate = obj["productionDate"].stringValue
        prd.expireDate = obj["expireDate"].stringValue
        prd.minOrder = obj["minOrder"].stringValue
        prd.deliveryTime = obj["deliveryTime"].stringValue
        prd.parent_id = obj["cat"].intValue
        
        return prd
    }
    
   

}
