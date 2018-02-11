//
//  Car.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/6/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import Foundation
import UIKit
class Car: NSObject {
    let model:String
    let pic:UIImage?
    let code:Int
    let price:Double
    let info:Info
    let insurance:[Insurance]
    
    init(model:String,picture:UIImage? = nil,code:Int,price:Double,info:Info,insurance:[Insurance]){
        self.model = model
        self.pic = picture
        self.code = code
        self.price = price
        self.info = info
        self.insurance = insurance
    }
    
}
