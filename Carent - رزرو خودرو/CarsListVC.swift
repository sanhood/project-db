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
        do{
            do{
                try db!.run("DELETE FROM car")
                try db!.run("DELETE FROM insurance")
                try db!.run("DELETE FROM technical_info")
            }catch{
                print(error)
            }
            try db!.run("INSERT INTO car (id,model,image,price) VALUES (?,?,?,?)",[100,"toyota","aksdnandjakndkjasndjkasndjkasd",10000000])
            try db!.run("INSERT INTO insurance (code,car_id,name,start,end) VALUES (?,?,?,?,?)",[10340,100,"bime iran","2000-01-02","2004-01-02"])
            try db!.run("INSERT INTO insurance (code,car_id,name,start,end) VALUES (?,?,?,?,?)",[10341,100,"bime kharej","2002-01-02","2010-01-02"])
            try db!.run("INSERT INTO technical_info (car_id,description) VALUES (?,?)",[100,"dor range tokhmi"])
        }catch{
            print(error)
        }
        getCars()
//        let info = Info(desc: "folan")
//        let ins = Insurance()
//        let car = Car(name: "GT86", picture: #imageLiteral(resourceName: "city"), code: "asdkasdj", price: 1000, info: info, insurance: ins)
//        let car2 = Car(name: "Corrola", picture: #imageLiteral(resourceName: "781028-black-and-white-cars-grayscale-porsche-911-carrera"), code: "asdkasdj", price: 10000000, info: info, insurance: ins)
//        carsList.append(car)
//        carsList.append(car2)
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
    
    func getCars(){
        do{
            let result = try db!.prepare("SELECT * FROM car INNER JOIN technical_info ON (technical_info.car_id = car.id)")
            for row in result {
               // print(row)
                let car_id = Int(row[0] as! Int64)
                let model = row[1] as! String
                var img:UIImage?
                print(row[2])
                let imgStr = (row[2] as! String != "") ? row[2] as! String : nil
                if imgStr != nil {
                    let imgData = Data(base64Encoded: imgStr!)
                   // img = UIImage(data: imgData!)
                }
                let price = row[3] as! Int64
                let info = Info(desc: row[5] as! String)
                var insurances = [Insurance]()
                let insur = try db!.prepare("SELECT code,name,start,end FROM car INNER JOIN insurance ON (insurance.car_id = '\(car_id)')")
                for row2 in insur {
                    print(row2)
                    let code = Int(row2[0] as! Int64)
                    let name = row2[1] as! String
                    let start = (row2[2] as! String).split(separator: "-")
                    let startDate = Date(year: Int(start[0])!, month: Int(start[1])!, day: Int(start[2])!, identifire: .persian)
                    let end = (row2[3] as! String).split(separator: "-")
                    let endDate = Date(year: Int(end[0])!, month: Int(end[1])!, day: Int(end[2])!, identifire: .persian)
                    let newInsur = Insurance(name: name, code: code, start: startDate, end: endDate)
                    insurances.append(newInsur)
                }
                let newCar = Car(model: model, picture: img, code: car_id, price: Double(price), info: info, insurance: insurances)
                carsList.append(newCar)
            }
        }catch{
            print(error)
        }
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
        cell.name.text = carsList[indexPath.row].model
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
