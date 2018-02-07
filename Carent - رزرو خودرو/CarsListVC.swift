//
//  CarsListVC.swift
//  Carent - رزرو خودرو
//
//  Created by Danoosh Chamani on 2/6/18.
//  Copyright © 2018 Danoosh Chamani. All rights reserved.
//

import UIKit

class CarsListVC: UIViewController {
    
    var carsList:[Car] = [Car]()
    @IBOutlet weak var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let info = Info(desc: "folan")
        let ins = Insurance()
        let car = Car(name: "GT86", picture: #imageLiteral(resourceName: "city"), code: "asdkasdj", price: 1000, info: info, insurance: ins)
        let car2 = Car(name: "Corrola", picture: #imageLiteral(resourceName: "781028-black-and-white-cars-grayscale-porsche-911-carrera"), code: "asdkasdj", price: 10000000, info: info, insurance: ins)
        carsList.append(car)
        carsList.append(car2)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "CarCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 14, left: 10, bottom: 14, right: 10)
        layout.itemSize = CGSize(width:screenSize.width - 30 , height: 150)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 13
        collectionView!.collectionViewLayout = layout
        collectionView.contentSize = CGSize(width: 500, height: 1000)
        collectionView.isPagingEnabled = true
        collectionView.alwaysBounceVertical = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        slideMenu.addRightGestures()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openMenu(_ sender:UIButton){
        slideMenu.openRight()
    }
    
}

extension CarsListVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CarCollectionViewCell
        cell.imgView.image = carsList[indexPath.row].pic
        cell.name.text = carsList[indexPath.row].name
        cell.priceLbl.text = "\(carsList[indexPath.row].price)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let car = carsList[indexPath.row]
        let vc = RentCarVC(nibName: "RentCarVC", bundle: nil)
        vc.car = car
        navController.pushViewController(vc, animated: true)
    }
    
}
