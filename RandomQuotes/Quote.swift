//
//  Quote.swift
//  RandomQuotes
//
//  Created by Dongwoo Pae on 12/14/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

struct Quote: Codable, Equatable {
    let quote: String
    let author: String
    let category: String
}

