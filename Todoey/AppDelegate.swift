//
//  AppDelegate.swift
//  Todoey
//
//  Created by Brian Lee on 7/18/18.
//  Copyright © 2018 Cheng Yeh Lee. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        do {
            _ = try Realm()
        } catch {
            print("Error instantiation Realm: \(error)")
        }


        return true
    }
}

