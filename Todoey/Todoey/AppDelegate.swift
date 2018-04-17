//
//  AppDelegate.swift
//  Todoey
//
//  Created by Eduardo  Velez on 3/24/18.
//  Copyright © 2018 Eduardo  Velez. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        do {
            _ = try Realm()
        }
        catch {
            print("Error initializing new realm \(error)")
        }
        
       // print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        return true
    }
}

