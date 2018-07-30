//
//  Item.swift
//  Todoey
//
//  Created by Brian Lee on 7/27/18.
//  Copyright © 2018 Cheng Yeh Lee. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var createdDate: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
