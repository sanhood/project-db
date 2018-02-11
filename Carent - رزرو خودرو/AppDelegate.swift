//
//  AppDelegate.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/6/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import SQLite
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let firstTime = UserDefaults.standard.value(forKey: "first") as? Bool {
            if firstTime {
                UserDefaults.standard.setValue(false, forKey: "first")
            }
        }else{
            do {
                try db!.execute("""
                            BEGIN TRANSACTION;
                            CREATE TABLE customer (
                                id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                                email TEXT UNIQUE NOT NULL,
                                password TEXT NOT NULL,
                                name TEXT NOT NULL,
                                melliCode TEXT NOT NULL,
                                image TEXT
                            );
                            CREATE TABLE car (
                                id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                                model TEXT NOT NULL,
                                image TEXT,
                                price INTEGER NOT NULL
                            );
                            CREATE TABLE technical_info (
                                car_id INTEGER PRIMARY KEY NOT NULL,
                                description TEXT,
                                FOREIGN KEY (car_id) REFERENCES car(id)
                            );
                            CREATE TABLE insurance (
                                code INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                                car_id INTEGER NOT NULL,
                                name TEXT,
                                start DATETIME,
                                end DATETIME,
                                FOREIGN KEY (car_id) REFERENCES car(id)
                            );
                            CREATE TABLE driver (
                                id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                                name TEXT NOT NULL,
                                birthDate DATETIME NOT NULL,
                                gender TEXT NOT NULL
                            );
                            CREATE TABLE rent (
                                customer_id INTEGER NOT NULL,
                                car_id INTEGER NOT NULL,
                                reserve_date DATETIME NOT NULL,
                                delivery_date DATETIME,
                                delivery_status INTEGER,
                                total_cost INTEGER,
                                PRIMARY KEY (customer_id,car_id,reserve_date),
                                FOREIGN KEY (car_id) REFERENCES car(id),
                                FOREIGN KEY (customer_id) REFERENCES customer(id)
                            );
                            CREATE TABLE request (
                                customer_id INTEGER NOT NULL,
                                car_id INTEGER NOT NULL,
                                reserve_date DATETIME NOT NULL,
                                driver_id INTEGER NOT NULL,
                                numberOfDays INTEGER NOT NULL,
                                PRIMARY KEY (customer_id,car_id,reserve_date,driver_id),
                                FOREIGN KEY (car_id) REFERENCES car(id),
                                FOREIGN KEY (customer_id) REFERENCES customer(id),
                                FOREIGN KEY (reserve_date) REFERENCES rent(reserve_date),
                                FOREIGN KEY (driver_id) REFERENCES driver(id)
                            );
                            COMMIT TRANSACTION;
                            """)
            }catch{
                print(error)
            }
        }
        let initialViewController = Page1VC(nibName: "Page1VC", bundle: nil)
        let rightVC = DrawerVC(nibName: "DrawerVC", bundle: nil)
        let nvc = UINavigationController(rootViewController: initialViewController)
        navController = nvc
        nvc.navigationBar.isHidden = true
        slideMenu = SlideMenuController(mainViewController: nvc, rightMenuViewController: rightVC)
        slideMenu.delegate = self
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window!.rootViewController = slideMenu
        window!.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}
extension AppDelegate: SlideMenuControllerDelegate {
    func rightDidOpen() {
//        let nvc = (slideMenu.mainViewController as! UINavigationController)
//        if let vc = nvc.topViewController as? DrawerVC {
//            vc.tableView.reloadData()
//        }
//        Floaty.global.hide()
//
    }
    
    func rightDidClose() {
//        let nvc = (slideMenu.mainViewController as? UINavigationController)
//        if nvc?.topViewController is MainVC {
//            Floaty.global.show()
//        }else {
//            Floaty.global.hide()
//        }
    }
    
}

