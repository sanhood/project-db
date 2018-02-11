//
//  Insurance.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/6/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import Foundation
class Insurance: NSObject {
    let name:String
    let start:Date
    let end:Date
    let code:Int
    
    init(name:String,code:Int,start:Date,end:Date){
        self.name = name
        self.code = code
        self.start = start
        self.end = end
    }
}
