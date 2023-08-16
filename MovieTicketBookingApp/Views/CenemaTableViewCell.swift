//
//  CenemaTableViewCell.swift
//  MovieTicketBookingApp
//
//  Created by Khắc Hùng on 14/08/2023.
//

import UIKit

class CenemaTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var cvMovieShowtime: UICollectionView!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var btnDropdow: UIButton!
    @IBOutlet weak var lblCinemaName: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    
    let movieShowtimes = ["15.00", "16.00", "17.00", "18.00", "20.00"]
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cvMovieShowtime.register(UINib(nibName: "MovieShowtimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieShowtimeCellIdentifier")
        cvMovieShowtime.dataSource = self
        cvMovieShowtime.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieShowtimes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvMovieShowtime.dequeueReusableCell(withReuseIdentifier: "MovieShowtimeCellIdentifier", for: indexPath) as! MovieShowtimeCollectionViewCell
        cell.lblTime.text = movieShowtimes[indexPath.row]
        cell.layer.cornerRadius = 15
        return cell
    }
}

extension CenemaTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
}
