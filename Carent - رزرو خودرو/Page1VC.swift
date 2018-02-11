//
//  Page1VC.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/6/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift
class Page1VC: UIViewController {
    @IBOutlet weak var emailTxtField: ACFloatingTextfield!
    @IBOutlet weak var passwordTxtField: ACFloatingTextfield!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            do{
                try db!.run("DELETE FROM customer")
            }catch{
                print(error)
            }
            try db!.run("INSERT INTO customer (id,name,image,melliCode,password,email) VALUES (?,?,?,?,?,?)",[100,"dani","aksdnandjakndkjasndjkasndjkasd","0520239324","123","ghasem@s.c"])
        }catch{
            print(error)
        }
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(ges)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        slideMenu.removeRightGestures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView(){
        emailTxtField.selectedLineColor = UIColor(red: 255, green: 233, blue: 0, alpha: 0.1)
        emailTxtField.placeHolderColor = UIColor(red: 211, green: 211, blue: 211, alpha: 0.8)
        emailTxtField.selectedPlaceHolderColor = UIColor(red: 255, green: 233, blue: 0, alpha: 1)
        emailTxtField.lineColor = UIColor(red: 211, green: 211, blue: 211, alpha: 0.1)
        passwordTxtField.selectedLineColor = UIColor(red: 255, green: 233, blue: 0, alpha: 0.1)
        passwordTxtField.placeHolderColor = UIColor(red: 211, green: 211, blue: 211, alpha: 0.8)
        passwordTxtField.selectedPlaceHolderColor = UIColor(red: 255, green: 233, blue: 0, alpha: 1)
        passwordTxtField.lineColor = UIColor(red: 211, green: 211, blue: 211, alpha: 0.1)
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.borderColor = UIColor(red: 178, green: 178, blue: 178, alpha: 0.1).cgColor
        loginBtn.layer.borderWidth = 0.2
    }
    
    func check() -> Bool{
        email = emailTxtField.text!
        password = passwordTxtField.text!
        var flag = false
        do{
            let result = try db!.prepare("SELECT password FROM customer WHERE email = '\(email)' and password = '\(password)'")
            for _ in result {
                flag = true
            }
            print(flag)
        }catch{
            print(error)
        }
        return flag
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    @IBAction func loginPressed(_ sender: UIButton){
        if check() {
            let vc = CarsListVC(nibName: "CarsListVC", bundle: nil)
            navController.pushViewController(vc, animated: true)
        }else{
            let alert = UIAlertController(title: "خطا", message: "ایمیل و یا پسورد شما اشتباه می‌باشد‌", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func signupPressed(_ sender: UIButton){
        let vc = RegisterEmail(nibName: "RegisterEmail", bundle: nil)
        navController.pushViewController(vc, animated: true)
    }
    
}
extension Page1VC: UITextFieldDelegate {
    
}
