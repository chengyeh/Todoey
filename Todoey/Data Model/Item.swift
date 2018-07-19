//
//  Item.swift
//  Todoey
//
//  Created by Brian Lee on 7/19/18.
//  Copyright © 2018 Cheng Yeh Lee. All rights reserved.
//

import Foundation

class Item: Codable {
    private var title: String
    private var done: Bool

    init(_ thingToDo: String) {
        title = thingToDo
        done = false
    }

    public func getTitle() -> String {
        return title
    }

    public func isDone() -> Bool {
        return done
    }

    public func toggleDone() {
        done = !done
    }
}
