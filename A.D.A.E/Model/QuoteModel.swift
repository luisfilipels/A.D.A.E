//
//  QuoteModel.swift
//  A.D.A.E
//
//  Created by Luis Filipe de Lima Sales on 22/01/20.
//  Copyright © 2020 Apple Developer Academy Foundation. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct QuotesJSON: Decodable {
    let contents: QuotesJSONContent
}

struct QuotesJSONContent: Decodable {
    let quotes: [Quote]
}

struct Quote: Decodable {
    let quote: String
    let author: String
}


