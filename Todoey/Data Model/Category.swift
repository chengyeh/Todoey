//
//  Category.swift
//  Todoey
//
//  Created by Brian Lee on 7/27/18.
//  Copyright © 2018 Cheng Yeh Lee. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
