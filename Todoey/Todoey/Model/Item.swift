//
//  ItemModel.swift
//  Todoey
//
//  Created by Eduardo  Velez on 3/27/18.
//  Copyright © 2018 Eduardo  Velez. All rights reserved.
//

import Foundation
import UIKit

// Codable especifica que es encoder y decoder

class Item: Codable{
    var title: String = ""
    var done: Bool = false
}
