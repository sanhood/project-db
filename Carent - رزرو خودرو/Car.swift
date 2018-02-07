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
    let name:String
    let pic:UIImage
    let code:String
    let price:Double
    let info:Info
    let insurance:Insurance
    
    init(name:String,picture:UIImage,code:String,price:Double,info:Info,insurance:Insurance){
        self.name = name
        self.pic = picture
        self.code = code
        self.price = price
        self.info = info
        self.insurance = insurance
    }
    
}
