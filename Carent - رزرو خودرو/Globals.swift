//
//  Globals.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/6/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import Foundation
import SlideMenuControllerSwift
import SQLite
var slideMenu : SlideMenuController! = nil
var navController: UINavigationController! = nil
let path = NSSearchPathForDirectoriesInDomains(
    .documentDirectory, .userDomainMask, true
    ).first!
var email:String = ""
var password:String = ""
var userID:String = ""
var isSuperUser:Bool = false
var isDriverChoosed:Bool = false
let screenSize = UIScreen.main.bounds.size
var db: Connection? {
    get{
        do{
            return try Connection("\(path)/Carent.sqlite3")
        }catch{
            return nil
        }
    }
}


extension String {
    func matches(for regex : String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}

extension Date {
    init (year : Int ,month : Int , day : Int , identifire : Calendar.Identifier) {
        self.init()
        var date = DateComponents()
        date.year = year
        date.month = month
        date.day = day
        self = Calendar(identifier: identifire).date(from: date)!
    }
}

