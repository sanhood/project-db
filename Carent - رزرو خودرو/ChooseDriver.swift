//
//  ChooseDriver.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/7/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import UIKit

class ChooseDriver: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    var drivers:[Driver] = [Driver]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "ChooseDriversCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backPressed(_ sender: UIButton){
        navController.popViewController(animated: true)
    }
}


extension ChooseDriver: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drivers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChooseDriversCell
        let driver = drivers[indexPath.row]
        cell.configureCell(name: driver.name, gender: driver.gender, bd: driver.birthDate, id: driver.id)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
