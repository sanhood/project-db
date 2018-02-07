//
//  RegisterationVC.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/6/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import UIKit

class RegisterationVC: UIViewController {
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var profilePic:UIImageView!
    @IBOutlet weak var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let ges = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(ges)
        let nib = UINib(nibName: "CarCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 14, left: 10, bottom: 14, right: 10)
        layout.itemSize = CGSize(width:100 , height: 100)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 13
        collectionView!.collectionViewLayout = layout
        collectionView.contentSize = CGSize(width: 600, height: 100)
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceVertical = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func setupView(){
        
    }
    
    @IBAction func registerPressed(_ sender: UIButton){
        let vc = CarsListVC(nibName: "CarsListVC", bundle: nil)
        navController.pushViewController(vc, animated: true)
    }
    
    @IBAction func backPressed(_ sender: UIButton){
        navController.popViewController(animated: true)
    }
    
    @IBAction func picPressed(_ sender: UIButton!){
        if sender.tag == 0{   //change profile pic
            let alert = UIAlertController(title: "انتخاب عکس", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "دوربین", style: .default, handler: { _ in
                self.openCamera()
            }))
            alert.addAction(UIAlertAction(title: "گالری", style: .default, handler: { _ in
                self.openGallary()
            }))
            alert.addAction(UIAlertAction.init(title: "انصراف", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}


extension RegisterationVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        if let img = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            chosenImage = img
        }
        else if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            chosenImage = img
        }
        profilePic.image = chosenImage

        let data = UIImageJPEGRepresentation(chosenImage, 1)
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(userID)/ProfilePic.jpg")
        do {
            try data?.write(to: fileURL, options: .atomic)
        } catch {
            print(error)
        }
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
}
