//
//  HomeScreenViewController.swift
//  MovieTicketBookingApp
//
//  Created by Nguyễn Mạnh Linh on 11/08/2023.
//

import UIKit
import CollectionViewPagingLayout
import Kingfisher

class HomeScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    @IBOutlet weak var ButtonView: UIView!
    @IBOutlet weak var collectionVoucher: UICollectionView!
    @IBOutlet weak var movieCategory: UILabel!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var collectionMovieComingSoon: UICollectionView!
    @IBOutlet weak var collectionMovieView: UICollectionView!
    
    var moviesForView: [Movie] = []
    var moviesForComingSoon: [Movie] = []
    var voucher: [Voucher] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        callAPIMovies()
        callAPIVouchers()
    }
    
    func starsImageNames(for rating: Double) -> [String] {
        let maxRating: Double = 5.0
        let fullStarImageName = "fullStar"
        let halfStarImageName = "halfStar"
        let emptyStarImageName = "emptyStar"
        
        let numberOfFullStars = Int(rating)
        var numberOfHalfStars = 0
        
        if rating > Double(numberOfFullStars) {
            numberOfHalfStars = 1
        }
        
        let numberOfEmptyStars = Int(maxRating) - numberOfFullStars - numberOfHalfStars
        
        var starImageNames: [String] = []
        
        for _ in 0..<numberOfFullStars {
            starImageNames.append(fullStarImageName)
        }
        
        if numberOfHalfStars > 0 {
            starImageNames.append(halfStarImageName)
        }
        
        for _ in 0..<numberOfEmptyStars {
            starImageNames.append(emptyStarImageName)
        }
        
        return starImageNames
    }
    
    func configCollectionView() {
        let layoutCollectionMovieView = UICollectionViewFlowLayout()
        layoutCollectionMovieView.scrollDirection = .horizontal
        layoutCollectionMovieView.sectionInset = UIEdgeInsets.zero
        collectionMovieView.collectionViewLayout = layoutCollectionMovieView
        collectionMovieView.isPagingEnabled = true
        collectionMovieView.showsHorizontalScrollIndicator = false
        collectionMovieView.dataSource = self
        collectionMovieView.delegate = self
        collectionMovieView.register(UINib(nibName: "MovieCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCategoryCollectionViewCell")
        
        let comingSoonLayout = CollectionViewPagingLayout()
        comingSoonLayout.scrollDirection = .horizontal
        collectionMovieComingSoon.collectionViewLayout = comingSoonLayout
        collectionMovieComingSoon.isPagingEnabled = true
        collectionMovieComingSoon.showsHorizontalScrollIndicator = false
        collectionMovieComingSoon.dataSource = self
        collectionMovieComingSoon.delegate = self
        collectionMovieComingSoon.register(UINib(nibName: "MovieCSCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCSCollectionViewCell")
        
        let layoutCollectionVoucher = UICollectionViewFlowLayout()
        layoutCollectionVoucher.scrollDirection = .horizontal
        layoutCollectionVoucher.sectionInset = UIEdgeInsets.zero
        collectionVoucher.collectionViewLayout = layoutCollectionVoucher
        collectionVoucher.isPagingEnabled = true
        collectionVoucher.showsHorizontalScrollIndicator = false
        collectionVoucher.dataSource = self
        collectionVoucher.delegate = self
        collectionVoucher.register(UINib(nibName: "VoucherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VoucherCollectionViewCell")
    }
    
    func callAPIMovies() {
        APIHandler().getMovies { welcome in
            self.moviesForView = welcome.data
            print(print("getMovie + \(welcome.data)"))
            self.moviesForComingSoon = welcome.data
            self.collectionMovieView.reloadData()
            self.collectionMovieComingSoon.reloadData()
        }
    }
    
    func callAPIVouchers(){
        APIHandler().getVouchers { voucherWelcome in
            self.voucher = voucherWelcome.data
            print("voucherWelcome + \(voucherWelcome)")
            self.collectionVoucher.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionMovieView {
            return moviesForView.count
        } else if collectionView == collectionMovieComingSoon {
            return moviesForComingSoon.count
        } else if collectionView == collectionVoucher {
            return voucher.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        if collectionView == collectionMovieView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCategoryCollectionViewCell", for: indexPath) as! MovieCategoryCollectionViewCell
            let movie = moviesForView[indexPath.row]
            if let cell = cell as? MovieCategoryCollectionViewCell {
                cell.movieName.text = movie.title
                print("\(movie.title)")
                let url = URL(string: movie.thumbnail)
                cell.moviePoster.kf.setImage(with: url)
                let starImageNames = starsImageNames(for: movie.rating)
                for i in 0..<5 {
                    let imageView = UIImageView(image: UIImage(named: starImageNames[i]))
                    imageView.frame = CGRect(x: CGFloat(i) * 20, y: (cell.movieName.frame.height - 5), width: 20, height: 20) // Điều chỉnh vị trí và kích thước của từng ảnh
                    cell.contentView.addSubview(imageView)
                }
            }
            
        } else if collectionView == collectionMovieComingSoon {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCSCollectionViewCell", for: indexPath) as! MovieCSCollectionViewCell
            let movie = moviesForComingSoon[indexPath.row]
            if let cell = cell as? MovieCSCollectionViewCell {
                let url = URL(string: movie.thumbnail)
                cell.movieComingSoonPoster.kf.setImage(with: url)
            }
            
        } else if collectionView == collectionVoucher {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VoucherCollectionViewCell", for: indexPath) as! VoucherCollectionViewCell
            let voucher = voucher[indexPath.row]
            if let cell = cell as? VoucherCollectionViewCell {
                cell.titleVoucher.text = voucher.content
                cell.titleVoucher.numberOfLines = 5
                print(voucher.content)
                let url = URL(string: voucher.thumbnail)
                cell.imgVoucher.kf.setImage(with: url)
                print(voucher.thumbnail)
            }
        }
        else {
            cell = UICollectionViewCell()
        }
        return cell
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionMovieView {
            // Chỉnh kích thước cho collectionMovieView
            let cellWidth: CGFloat = 180
            let cellHeight: CGFloat = 350
            return CGSize(width: cellWidth, height: cellHeight)
        } else if collectionView == collectionVoucher {
            // Chỉnh kích thước cho collectionVoucher
            let cellWidth: CGFloat = 250
            let cellHeight: CGFloat = 150
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
        return CGSize(width: 0, height: 0) // Giá trị mặc định, bạn có thể điều chỉnh tùy theo yêu cầu
    }
}

