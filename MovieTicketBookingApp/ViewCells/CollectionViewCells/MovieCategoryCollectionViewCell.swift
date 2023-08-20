//
//  MovieCategoryCollectionViewCell.swift
//  MovieTicketBookingApp
//
//  Created by Nguyễn Mạnh Linh on 13/08/2023.
//

import UIKit

class MovieCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
   
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgStar1.image = UIImage(named: "emptyStar")
        imgStar2.image = UIImage(named: "emptyStar")
        imgStar3.image = UIImage(named: "emptyStar")
        imgStar4.image = UIImage(named: "emptyStar")
        imgStar5.image = UIImage(named: "emptyStar")
    }
    func starRating(rating: Double) {
        let stars = [imgStar1, imgStar2, imgStar3, imgStar4, imgStar5]
        let intNumber = Int(rating)

        for i in 0..<intNumber {
            stars[i]?.image = UIImage(named: "fullStar")
        }

        if intNumber < stars.count && rating - Double(intNumber) >= 0.5 {
            stars[intNumber]?.image = UIImage(named: "halfStar")
        }
    }
}
