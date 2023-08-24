//
//  CenemaTableViewCell.swift
//  MovieTicketBookingApp
//
//  Created by Khắc Hùng on 14/08/2023.
//

import UIKit

class CenemaTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var lblTypeTicket: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var cvMovieShowtime: UICollectionView!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var btnDropdow: UIButton!
    @IBOutlet weak var lblCinemaName: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    var movieShowtimeData: MovieTheaterResponse?
   
    var buttonAction: (() -> Void)?
    var isCollectionViewTimeVisible = false {
        didSet {
            viewTime.isHidden = !isCollectionViewTimeVisible
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnShowTime(_ sender: UIButton) {
        buttonAction?()
    }
    
    var selectedMovieShowtime: MovieTheaterResponse?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cvMovieShowtime.register(UINib(nibName: "MovieShowtimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieShowtimeCellIdentifier")
        cvMovieShowtime.dataSource = self
        cvMovieShowtime.delegate = self
        callAPIGetTime()
    }
    
    func callAPIGetTime() {
        let apiHandler = APIHandler()
        apiHandler.getMovieTheaters() { movieTheaterResponseData in
            self.movieShowtimeData = movieTheaterResponseData
            DispatchQueue.main.async {
                self.cvMovieShowtime.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let slotCount = movieShowtimeData?.data[section].availableSlots.count ?? 0
        return slotCount
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvMovieShowtime.dequeueReusableCell(withReuseIdentifier: "MovieShowtimeCellIdentifier", for: indexPath) as! MovieShowtimeCollectionViewCell
        cell.lblTime.text = movieShowtimeData?.data[indexPath.row].availableSlots[indexPath.row].slotTime
        cell.layer.cornerRadius = 15
        
        return cell
    }
    var showSlot: Slot?
    var showMovieType: Price?
    var showMovieTheater: MovieTheaterResponse?
    var showMovieName: Theater?
    var selectedIndexPath: IndexPath?
    var btnContinueOutlet: (() -> Void)?
    var continueButtonGetMovieTheter: ((MovieTheaterResponse?) -> Void)?
    var continueButtonGetSlot: ((Slot?) -> Void)?
    var continueButtonGetPrice: ((Price?) -> Void)?
    var continueButtonGetName: ((Theater?) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        btnContinueOutlet!()
        if let selectedMovieTheater = movieShowtimeData{
            continueButtonGetMovieTheter!(selectedMovieTheater)
        }
        if let selectedMovieName = movieShowtimeData?.data[indexPath.row].theater{
            continueButtonGetName?(selectedMovieName)
            print("vitri: ", selectedMovieName.name)
        }
    
       
        if let selectedShowtime = movieShowtimeData?.data[indexPath.row].availableSlots[indexPath.row] {
            continueButtonGetSlot?(selectedShowtime)
        }
        if let selectedMovieType = movieShowtimeData?.data[indexPath.row].availableSlots[indexPath.row].prices[indexPath.row] {
            continueButtonGetPrice?(selectedMovieType)
        }

        if let selectedIndexPath = selectedIndexPath,
           let previousCell = collectionView.cellForItem(at: selectedIndexPath) as? MovieShowtimeCollectionViewCell {
            previousCell.backgroundColor = UIColor(hexString: "2F2C44")
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieShowtimeCollectionViewCell {
            cell.backgroundColor = .purple
            lblTypeTicket.text = movieShowtimeData?.data[indexPath.row].availableSlots[indexPath.row].prices[indexPath.row].name
            
            if let price = movieShowtimeData?.data[indexPath.row].availableSlots[indexPath.row].prices[indexPath.row].price {
                lblPrice.text =  "Giá: \(price) VNĐ"
            } else {
                lblPrice.text =  ""
            }
        }
    
        selectedIndexPath = indexPath
       
    }
}

extension CenemaTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var formattedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if formattedString.hasPrefix("#") {
            formattedString.remove(at: formattedString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: formattedString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
