//
//  MovieDetailsViewController.swift
//  MovieTicketBookingApp
//
//  Created by Lê Đình Linh on 11/08/2023.
//

import UIKit
import AVKit
import AVFoundation
import Kingfisher
import WebKit

class MovieDetailsViewController: UIViewController {
    
    
    
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var viewOld: UIView!
    @IBOutlet weak var viewStar: UIView!
    @IBOutlet weak var imageStar5: UIImageView!
    @IBOutlet weak var imageStar4: UIImageView!
    @IBOutlet weak var imageStar3: UIImageView!
    @IBOutlet weak var imageStar2: UIImageView!
    @IBOutlet weak var imageStar1: UIImageView!
    @IBOutlet weak var lblOld: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblStar: UILabel!
    @IBOutlet weak var lblNameMovie: UILabel!
    @IBOutlet weak var lblPH: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblWritter: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var lblSinopsis: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var imageReview: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var playerController: AVPlayerViewController!
        let apiHandler = APIHandler()
        var itemMovie: Movie?
        private var listItem: [MovieResponse] = []
        var director: [Director] = []
        var writers: [Writer] = []
        var category: [Category] = []
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            imageStar1.image = UIImage(named: "empty")
            imageStar2.image = UIImage(named: "empty")
            imageStar3.image = UIImage(named: "empty")
            imageStar4.image = UIImage(named: "empty")
            imageStar5.image = UIImage(named: "empty")
            imageMovie.layer.cornerRadius = 20
            btnOrder.layer.cornerRadius = 10
            viewTime.layer.cornerRadius = 10
            viewTime.layer.borderColor = UIColor.white.cgColor
            viewTime.layer.borderWidth = 2.0
            viewOld.layer.cornerRadius = 10
            viewOld.layer.borderColor = UIColor.white.cgColor
            viewOld.layer.borderWidth = 2.0
            viewStar.layer.cornerRadius = 10
            viewStar.layer.borderColor = UIColor.white.cgColor
            viewStar.layer.borderWidth = 2.0
    //        let path: String = Bundle.main.path(forResource: "7673103127035251441", ofType: "mp4")!
    //        let url: URL = URL(fileURLWithPath: path)
    //        playerController = AVPlayerViewController()
    //        playerController.player = AVPlayer(url: url)
    //        playerController.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/3)
    //                view.addSubview(playerController.view)
            
          callAPIgetMovies()
            
        }
        func callAPIgetMovies() {
            apiHandler.getMovie { [weak self] movieResponse in
                self?.itemMovie = movieResponse
                DispatchQueue.main.async {
                    self?.lblNameMovie.text = self?.itemMovie?.title
                    if let director = self?.itemMovie?.directors.first {
                        self?.lblDirector.text = director.fullName
                    }
                    if let writter = self?.itemMovie?.writers.first {
                        self?.lblWritter.text = writter.fullName
                    }
                    if let category = self?.itemMovie?.categories.first {
                        self?.lblGenre.text = category.name
                    }
                    if let producers = self?.itemMovie?.producers.first {
                        self?.lblPH.text = producers.name
                    }
                    self?.lblSinopsis?.text = self?.itemMovie?.description
                    if let pgs = self?.itemMovie?.pgs.first {
                        self?.lblOld.text = pgs.name
                    }
                    if let movie = self?.itemMovie {
                        self?.starRating(rating: movie.rating)
                    }
                    if let imgMovie = URL(string: self?.itemMovie?.thumbnail ?? "") {
                        self?.imageMovie.kf.setImage(with: imgMovie)
                    }
                    if let trailer = self?.itemMovie?.trailers.first,
                        let imgTrailer = URL(string: trailer.thumbnail) {
                        self?.imageReview.kf.setImage(with: imgTrailer)
                    }
                    if let duration = self?.itemMovie?.duaration {
                        let hours = duration / 60
                        let minutes = duration % 60
                        self?.lblTime.text = "\(hours) giờ \(minutes) phút"
                    }
                    if let rating = self?.itemMovie?.rating {
                        self?.lblStar.text = String(rating)
                        } else {
                        self?.lblStar.text = ""
                    }
                }
            }
        }
            
    @IBAction func btnPlayVideo(_ sender: Any) {
       playVideo()
     
    }
    
    func starRating(rating: Double) {
        let stars = [imageStar1, imageStar2, imageStar3, imageStar4, imageStar5]
        let intNumber = Int(rating)

        for i in 0..<intNumber {
            stars[i]?.image = UIImage(named: "full")
        }

        if intNumber < stars.count && rating - Double(intNumber) >= 0.5 {
            stars[intNumber]?.image = UIImage(named: "half")
        }
    
    }
    func playVideo() {
        if let trailerURL = URL(string: itemMovie?.trailers.first?.url ?? "") {
            let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 5))
            let request = URLRequest(url: trailerURL)
            webView.load(request)
            view.addSubview(webView)
        }
    }
    

}


    


