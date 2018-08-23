//
//  Category.swift
//  iFactories
//
//  Created by navid einackchi on 6/14/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category {
    var name: String = ""
    var image: String = ""
    var id: Int = -1
    var parent_id: Int = -1
    var state: Bool = true
    
    var type: Int = -1
    
   static func parseCategory(obj: JSON) -> Category {
        let cat = Category()
    cat.id = obj["id"].intValue
    cat.type = obj["type"].intValue
    cat.parent_id = obj["parent"].intValue
        cat.name = obj["title"].stringValue
        cat.image = obj["img"].stringValue
    
        return cat
    }

    
    
}
