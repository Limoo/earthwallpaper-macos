//
//  Preview.swift
//  EarthPornWallpaper
//
//  Created by Tibor Leon Hahne on 13/03/2017.
//  Copyright © 2017 Tibor Leon Hahne. All rights reserved.
//

import Cocoa
import ObjectMapper

class Preview: Mappable {
    var images: [Image]?
    var enabled: Bool?
    
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        images    <- map["images"]
        enabled   <- map["enabled"]
    }

}
