//
//  SeatSelectionViewController.swift
//  MovieTicketBookingApp
//
//  Created by Khắc Hùng on 14/08/2023.
//

import UIKit

class SeatSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var viewShowDetail: UIView!
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var lblPriceTotal: UILabel!
    @IBOutlet weak var lblTicketTotal: UILabel!
    @IBOutlet weak var viewTicketType: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var lblCinemaName: UILabel!
    @IBOutlet weak var cvSeats: UICollectionView!
    
    let seatData = ["A1", "B1", "C1", "D1", "E1",
                    "A2", "B2", "C2", "D2", "E2",
                    "A3", "B3", "C3", "D3", "E3",
                    "A4", "B4", "C4", "D4", "E4",
                    "A5", "B5", "C5", "D5", "E5",
                    "A6", "B6", "C6", "D6", "E6",
                    "A7", "B7", "C7", "D7", "E7",
                    "A8", "B8", "C8", "D8", "E8",
                    "A9", "B9", "C9", "D9", "E9", ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        viewShowDetail.layer.cornerRadius = 30
        viewTime.layer.borderWidth = 0.5
        viewDate.layer.borderWidth = 0.5
        viewTicketType.layer.borderWidth = 0.5
        viewTime.layer.cornerRadius = 10
        viewDate.layer.cornerRadius = 10
        viewTicketType.layer.cornerRadius = 10
        viewTime.layer.borderColor = UIColor.lightGray.cgColor
        viewDate.layer.borderColor = UIColor.lightGray.cgColor
        viewTicketType.layer.borderColor = UIColor.lightGray.cgColor
        btnBook.layer.cornerRadius = 10
        
        cvSeats.delegate = self
        cvSeats.dataSource = self
        cvSeats.register(UINib(nibName: "SeatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SeatCellIdentifier")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seatData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvSeats.dequeueReusableCell(withReuseIdentifier: "SeatCellIdentifier", for: indexPath) as! SeatCollectionViewCell
        cell.lblSeatName.text = seatData[indexPath.row]
        if [0, 1, 5, 6, 10, 11, 15, 16, 20, 21, 25, 26, 30, 31, 35, 36, 40, 41].contains(indexPath.item) {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .systemPurple
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = cvSeats.cellForItem(at: indexPath) as! SeatCollectionViewCell
        if cell.backgroundColor == UIColor(hex: "6C61AF") &&  [0, 1, 5, 6, 10, 11, 15, 16, 20, 21, 25, 26, 30, 31, 35, 36, 40, 41].contains(indexPath.item){
              cell.backgroundColor = .lightGray
        } else if cell.backgroundColor == UIColor(hex: "6C61AF") {
            cell.backgroundColor = .systemPurple
        }
        else {
              cell.backgroundColor = UIColor(hex: "6C61AF")
          }
       
    }

    
    
}

extension SeatSelectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xFF0000) >> 16
        let g = (rgbValue & 0x00FF00) >> 8
        let b = rgbValue & 0x0000FF

        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: 1.0
        )
    }
}
