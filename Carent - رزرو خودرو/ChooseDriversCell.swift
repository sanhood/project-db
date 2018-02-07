//
//  ChooseDriversCell.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/7/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import UIKit

class ChooseDriversCell: UITableViewCell {
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var gender:UILabel!
    @IBOutlet weak var birthDate:UILabel!
    @IBOutlet weak var id:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(name:String,gender:String,bd:String,id:String){
        self.name.text = name
        self.gender.text = gender
        self.birthDate.text = bd
        self.id.text = id
    }
    
}
