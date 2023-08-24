//
//  SeatSelectionViewController.swift
//  MovieTicketBookingApp
//
//  Created by Khắc Hùng on 14/08/2023.
//

import UIKit

class SeatSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var lblTicketType: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewShowDetail: UIView!
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var lblPriceTotal: UILabel!
    @IBOutlet weak var lblTicketTotal: UILabel!
    @IBOutlet weak var viewTicketType: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var lblCinemaName: UILabel!
    @IBOutlet weak var cvSeats: UICollectionView!
    
    var movieTheater: MovieTheaterResponse?
    var selectedMovieName: Theater?
    var selectedMovieTheater: Slot?
    var selectedMovieTheaterType: Price?
    var seatsData: SeatingData?
    var isSeatSelected: Bool = false
    
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
        callAPIGetSeats()
        lblCinemaName.text = selectedMovieName?.name
        lblTime.text = selectedMovieTheater?.slotTime
        lblDate.text = selectedMovieTheater?.slotDate
        lblTicketType.text = selectedMovieTheaterType?.name
        
    }
    
    var seatArray: [Seat] = []
    var newSeat = Seat(seatID: 0, seatCode: "", status: "", type: "", price: 0)
    func callAPIGetSeats() {
        APIHandler.init().getSeats(){
            seatsResponseData in
            self.seatsData = seatsResponseData
            self.cvSeats.reloadData()
            for i in 0..<(self.seatsData?.data.count ?? 0) {
                for j in 0..<(self.seatsData?.data[i].seats.count ?? 0) {
                    self.seatArray.append(self.seatsData?.data[i].seats[j] ?? self.newSeat)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let totalSeats = seatArray.count
        return totalSeats
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvSeats.dequeueReusableCell(withReuseIdentifier: "SeatCellIdentifier", for: indexPath) as! SeatCollectionViewCell
        
        cell.lblSeatName.text =  self.seatArray[indexPath.row].seatCode
        if seatArray[indexPath.row].status == "Booked" {
            cell.backgroundColor = UIColor(hex: "282633")
            cell.lblSeatName.text = "X"
        } else if seatArray[indexPath.row].type == "Regular" {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .systemPurple
        }
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = cvSeats.cellForItem(at: indexPath) as! SeatCollectionViewCell
        
        if cell.backgroundColor == UIColor(hex: "282633") {
            return
        }
        
        let selectedSeat = seatArray[indexPath.row]
        
        if cell.backgroundColor == UIColor(hex: "6C61AF") && selectedSeat.type == "Regular" {
            cell.backgroundColor = .lightGray
            
        } else if cell.backgroundColor == UIColor(hex: "6C61AF") {
            cell.backgroundColor = .systemPurple
            
        } else {
            cell.backgroundColor = UIColor(hex: "6C61AF")
            
        }
        
        updateTotalPrice()
        updateSeatCodes()
        isSeatSelected = cvSeats.indexPathsForSelectedItems?.count ?? 0 > 0
      
    }
    
    
    func updateSeatCodes() {
        var seatCodes = [String]()
        
        for indexPath in cvSeats.indexPathsForVisibleItems {
            let seat = seatArray[indexPath.row]
            
            if let cell = cvSeats.cellForItem(at: indexPath) as? SeatCollectionViewCell,
               cell.backgroundColor == UIColor(hex: "6C61AF") {
                seatCodes.append(seat.seatCode)
            }
        }
        
        lblTicketTotal.text = seatCodes.joined(separator: ", ")
    }
    
    func updateTotalPrice() {
        var totalPrice = 0
        
        for indexPath in cvSeats.indexPathsForVisibleItems {
            let seat = seatArray[indexPath.row]
            
            if let cell = cvSeats.cellForItem(at: indexPath) as? SeatCollectionViewCell,
               cell.backgroundColor == UIColor(hex: "6C61AF") {
                totalPrice += seat.price
            }
        }
        
        lblPriceTotal.text = "\(totalPrice)"
    }
    
    @IBAction func btnBooking(_ sender: UIButton) {
        
        if isSeatSelected {
            let movieBooking = MovieBooking(movieID: 1,
                                            theaterID: selectedMovieName?.id ?? 0,
                                            date: selectedMovieTheater?.slotDate ?? "nil",
                                            slotTime: selectedMovieTheater?.slotTime ?? "nil",
                                            bookedSeats: [
                                                BookedSeat(rowID: 1, rowCode: "A", seatID: 1, seatCode: "1"),
                                                BookedSeat(rowID: 2, rowCode: "B", seatID: 2, seatCode: "3")
                                                
                                            ])
            APIHandler.init().postMovieBooking(_movieBooking: movieBooking) { success in
                if success {
                    print("thong tin ve: ", movieBooking)
                    let alert = UIAlertController(title: "Thành công", message: "Đặt vé thành công", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { action in
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Thất bại", message: "Không đặt được vé", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { action in
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        } else {
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn ghế", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { action in
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
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
