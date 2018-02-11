//
//  RegisterEmail.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/6/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift
class RegisterEmail: UIViewController {
    @IBOutlet weak var emailTxtField: ACFloatingTextfield!
    @IBOutlet weak var passwordTxtField: ACFloatingTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ges = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(ges)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    func setupView(){
        emailTxtField.selectedLineColor = UIColor(red: 252, green: 55, blue: 104, alpha: 0.1)
        emailTxtField.placeHolderColor = UIColor(red: 211, green: 211, blue: 211, alpha: 0.8)
        emailTxtField.selectedPlaceHolderColor = UIColor(red: 252, green: 55, blue: 104, alpha: 1)
        emailTxtField.lineColor = UIColor(red: 211, green: 211, blue: 211, alpha: 0.1)
        passwordTxtField.selectedLineColor = UIColor(red: 252, green: 55, blue: 104, alpha: 0.1)
        passwordTxtField.placeHolderColor = UIColor(red: 211, green: 211, blue: 211, alpha: 0.8)
        passwordTxtField.selectedPlaceHolderColor = UIColor(red: 252, green: 55, blue: 104, alpha: 1)
        passwordTxtField.lineColor = UIColor(red: 211, green: 211, blue: 211, alpha: 0.1)

    }
    
    func checkEmail() -> Bool{
        email = emailTxtField.text!
        var flag = true
        if email.matches(for: "\\S+@\\S+\\.\\S+").count > 0 {
            do{
                let result = try db!.prepare("SELECT email FROM customer WHERE email = '\(email)'")
                for _ in result {
                    flag = false
                }
                if !flag {
                    emailTxtField.showErrorWithText(errorText: "قبلا ثبت شده است")
                }
            }catch{
                print(error)
            }
        }else{
            flag = false
            emailTxtField.showErrorWithText(errorText: "ایمیل معتبر نیست")
        }
        return flag
    }
    
    @IBAction func nextPressed(_ sender: UIButton){
        if checkEmail() {
            if passwordTxtField.text != "" {
                password = passwordTxtField.text!
                let vc = RegisterationVC(nibName: "RegisterationVC", bundle: nil)
                navController.pushViewController(vc, animated: true)
            }else{
                passwordTxtField.showErrorWithText(errorText: "این فیلد را نیز پر کنید")
            }
        }
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton){
        navController.popViewController(animated: true)
    }
    
}
