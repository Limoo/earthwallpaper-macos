//
//  RedditDto.swift
//  EarthPornWallpaper
//
//  Created by Tibor Leon Hahne on 13/03/2017.
//  Copyright © 2017 Tibor Leon Hahne. All rights reserved.
//

import Cocoa
import ObjectMapper

class Child: Mappable {
    var kind: String?
    var data: ChildData?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        kind    <- map["kind"]
        data     <- map["data"]
    }
}
