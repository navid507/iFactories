//
//  Guild.swift
//  iFactories
//
//  Created by navid einackchi on 6/14/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import Foundation
import SwiftyJSON

class Guild {
    
    var name: String = ""
    var image: String = ""
    var id: Int = -1
    var parent_id: Int = -1
    var state: Bool = true
    var selected: Bool = true
    
    static func parseGuild(obj: JSON) -> Guild {
        let g = Guild()
        g.id = obj["id"].intValue
        g.parent_id = obj["pid"].intValue
        g.name = obj["title"].stringValue
        g.image = obj["img"].stringValue
        return g
    }

}
