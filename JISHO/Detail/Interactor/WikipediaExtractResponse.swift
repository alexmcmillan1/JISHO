//
//  WikipediaExtractResponse.swift
//  JISHO
//
//  Created by Alex on 22/02/2020.
//  Copyright © 2020 Alex McMillan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WikipediaExtractResponse: Decodable {
    let query: Query
}

struct Query: Decodable {
    let pages: [String: JSON]
}
