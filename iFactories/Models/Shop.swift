//
//  Shop.swift
//  iFactories
//
//  Created by navid einackchi on 6/14/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import Foundation
import SwiftyJSON

class Shop {
    
    var name: String = ""
    var freeDelivery: String = ""
    var area: String = ""
    var worker_count: String = ""
    var monthly_production_capacity: String = ""
    var standards: String = ""
    var logo: String = ""
    var permisions: String = ""
    var rewards: String = ""
    var place_of_delivery: String = ""
    var clearing: String = ""
    var banner: String = ""
    var mobile: String = ""
    var phone: String = ""
    var address: String = ""
    var email: String = ""
    var web: String = ""
    
    var id: Int = -1
    var guild: Int = -1
    var state: Bool = false
    
    public var guilds = NSMutableArray()
    public var others = NSMutableArray()
    var gallery = [String]()
    
    static func parseShop(obj: JSON) -> Shop {
        
 

        let cat = Shop()
        cat.id = obj["id"].intValue
        cat.guild = obj["guild"].intValue
       
        cat.name = obj["title"].stringValue
        cat.freeDelivery = obj["freeDelivery"].stringValue
        cat.area = obj["area"].stringValue
        cat.worker_count = obj["worker_count"].stringValue
        cat.monthly_production_capacity = obj["monthly_production_capacity"].stringValue
        cat.standards = obj["standards"].stringValue
        cat.logo = obj["logo"].stringValue
        cat.permisions = obj["permisions"].stringValue
        cat.rewards = obj["rewards"].stringValue
        cat.place_of_delivery = obj["place_of_delivery"].stringValue
        cat.clearing = obj["clearing"].stringValue
        cat.banner = obj["banner"].stringValue
        cat.mobile = obj["mobile"].stringValue
        cat.phone = obj["phone"].stringValue
        cat.address = obj["address"].stringValue
        cat.email = obj["email"].stringValue
        cat.web = obj["web"].stringValue
        
        let ads = obj["gallery"].arrayValue
        for s in ads
        {
            let ser = s.stringValue
            cat.gallery.append(ser)
        }
    
        let guildJSA = obj["guild"].arrayValue
        for s in guildJSA
        {
            let ser = Guild.parseGuild(obj: s)
            cat.guilds.add(ser)
        }
        
        let dwayJSA = obj["dway"].arrayValue
        for s in dwayJSA
        {
            let ser = GDIM.parseGDIM(obj: s)
            cat.others.add(ser)
        }
        
        
        let munitJSA = obj["munit"].arrayValue
        for s in munitJSA
        {
            let ser = GDIM.parseGDIM(obj: s)
            cat.others.add(ser)
        }
        
        let isoJSA = obj["iso"].arrayValue
        for s in isoJSA
        {
            let ser = GDIM.parseGDIM(obj: s)
            cat.others.add(ser)
        }
        return cat
    }
    
    
    
}

