//
//  Source.swift
//  EarthPornWallpaper
//
//  Created by Tibor Leon Hahne on 13/03/2017.
//  Copyright © 2017 Tibor Leon Hahne. All rights reserved.
//

import Cocoa
import ObjectMapper

class Source: Mappable {
    var url: String?
    var width: Int?
    var height: Int?
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        url    <- map["url"]
        width  <- map["width"]
        height <- map["height"]
    }

}
