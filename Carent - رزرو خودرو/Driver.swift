//
//  Driver.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/7/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import Foundation
class Driver:NSObject {
    let name:String
    let gender:String
    let birthDate:String
    let id:String
    
    init(name:String,gender:String,birthDate:String,id:String){
        self.name = name
        self.gender = gender
        self.birthDate = birthDate
        self.id = id
    }
}
