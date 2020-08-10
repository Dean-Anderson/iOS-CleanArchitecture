//
//  ImagePack.swift
//  MVVM
//
//  Created by dean.anderson on 2020/02/19.
//  Copyright © 2020 Practice. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ImagePack {
    let thumbnailLink: String
    let link: String
    
    var thumbnailURL: URL? { URL(string: thumbnailLink) }
    var linkURL: URL? { URL(string: link) }
}

extension ImagePack {
    init(json: JSON) {
        let imageJSON = json["image"]
        thumbnailLink = imageJSON["thumbnailLink"].stringValue
        link          = json["link"].stringValue
    }
}
