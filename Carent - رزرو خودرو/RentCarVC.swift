//
//  RentCarVC.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/7/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import UIKit

class RentCarVC: UIViewController {
    var car: Car!
    @IBOutlet weak var carImgView:UIImageView!
    @IBOutlet weak var detailsTxtView:UITextView!
    @IBOutlet weak var startInsurance:UILabel!
    @IBOutlet weak var endInsurance:UILabel!
    @IBOutlet weak var withDriverSwitch:UISwitch!
    @IBOutlet weak var pricePerDay:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        withDriverSwitch.isOn = isDriverChoosed
    }
    
    @IBAction func rentPressed(_ sender: UIButton){
        let alert = UIAlertController(title: "تبریک", message: "سفارش شما ثبت شد", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: { (action) in
            let vc = CarsListVC(nibName: "CarsListVC", bundle: nil)
            navController.pushViewController(vc, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: UIButton){
        navController.popViewController(animated: true)
    }

    @IBAction func switchSwitched(_ sender: UISwitch){
        if withDriverSwitch.isOn {
            let vc = ChooseDriver(nibName: "ChooseDriver", bundle: nil)
            navController.pushViewController(vc, animated: true)
        }
    }
}
