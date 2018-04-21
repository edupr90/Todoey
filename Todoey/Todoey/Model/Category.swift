//
//  Category.swift
//  Todoey
//
//  Created by Eduardo  Velez on 4/16/18.
//  Copyright © 2018 Eduardo  Velez. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundColor = ""
    let items = List<Item>()
}
