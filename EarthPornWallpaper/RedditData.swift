//
//  Data.swift
//  EarthPornWallpaper
//
//  Created by Tibor Leon Hahne on 13/03/2017.
//  Copyright © 2017 Tibor Leon Hahne. All rights reserved.
//

import Cocoa
import ObjectMapper

class RedditData: Mappable {
    var children: [Child]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        children    <- map["children"]
    }
}
