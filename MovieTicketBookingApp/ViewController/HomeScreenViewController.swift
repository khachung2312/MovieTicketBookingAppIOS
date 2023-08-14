//
//  HomeScreenViewController.swift
//  MovieTicketBookingApp
//
//  Created by Nguyễn Mạnh Linh on 11/08/2023.
//

import UIKit

class HomeScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionMovieView {
            return moviesForView.count
        } else if collectionView == collectionMovieComingSoon {
            return moviesForComingSoon.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        if collectionView == collectionMovieView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCategoryCollectionViewCell", for: indexPath) as! MovieCategoryCollectionViewCell
            let movie = moviesForView[indexPath.row]
            if let cell = cell as? MovieCategoryCollectionViewCell {
                cell.movieName.text = movie.movieName
                if let image = UIImage(named: "\(movie.moviePoster)") {
                    cell.moviePoster.image = image
                }
            }
        } else if collectionView == collectionMovieComingSoon {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCSCollectionViewCell", for: indexPath) as! MovieCSCollectionViewCell
            let movie = moviesForComingSoon[indexPath.row]
            if let cell = cell as? MovieCSCollectionViewCell {
                if let image = UIImage(named: movie.moviePoster) {
                    cell.movieComingSoonPoster.image = image
                }
            }
        } else {
            cell = UICollectionViewCell()
        }
        
        return cell
    }
    
    
    
    @IBOutlet weak var collectionMovieComingSoon: UICollectionView!
    @IBOutlet weak var collectionMovieView: UICollectionView!
    
    @IBOutlet weak var movieCSSegment: UISegmentedControl!
    
    var moviesForView: [MoviesModel]!
    var moviesForComingSoon: [MoviesModel]!
    
    //var movies: MoviesTypealias = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        loadMovieData()
    }
    
    
    func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        
        collectionMovieView.collectionViewLayout = layout
        collectionMovieView.dataSource = self
        collectionMovieView.delegate = self
        collectionMovieView.register(UINib(nibName: "MovieCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCategoryCollectionViewCell")
        
        let comingSoonLayout = UICollectionViewFlowLayout()
        comingSoonLayout.scrollDirection = .horizontal
        comingSoonLayout.sectionInset = UIEdgeInsets.zero
        
        collectionMovieComingSoon.collectionViewLayout = comingSoonLayout
        collectionMovieComingSoon.dataSource = self
        collectionMovieComingSoon.delegate = self
        collectionMovieComingSoon.register(UINib(nibName: "MovieCSCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCSCollectionViewCell")
        
        movieCSSegment.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    func loadMovieData() {
        moviesForView = [
            MoviesModel(movieID: "1", movieName: "Star Wars: The Last", moviePoster: "poster1", categoryID: "1", time: "2h 30m", rating: 4),
            MoviesModel(movieID: "2", movieName: "Fast & Furious 9", moviePoster: "poster2", categoryID: "2", time: "2h 15m", rating: 3),
            MoviesModel(movieID: "3", movieName: "Star Wars: The Last", moviePoster: "poster1", categoryID: "1", time: "2h 30m", rating: 4),
            MoviesModel(movieID: "4", movieName: "Fast & Furious 9", moviePoster: "poster2", categoryID: "1", time: "2h 30m", rating: 4),
        ]
        
        moviesForComingSoon = [
            MoviesModel(movieID: "7", movieName: "The Conjuring 3", moviePoster: "poster1", categoryID: "3", time: "2h", rating: 4),
            MoviesModel(movieID: "8", movieName: "Movie 4", moviePoster: "poster2", categoryID: "3", time: "2h", rating: 4),
            MoviesModel(movieID: "9", movieName: "Movie 4", moviePoster: "poster2", categoryID: "3", time: "2h", rating: 4)
        ]
        
        collectionMovieView.reloadData()
        collectionMovieComingSoon.reloadData()
    }
    
    @objc func segmentedControlValueChanged(sender: UISegmentedControl) {
        // Update the data source for collectionMovieView based on the selected segment
        if sender.selectedSegmentIndex == 0 {
            // Load data for the first segment
            moviesForComingSoon = [
                MoviesModel(movieID: "11", movieName: "Star Wars: The Last", moviePoster: "poster1", categoryID: "1", time: "2h 30m", rating: 4),
            ]
        } else if sender.selectedSegmentIndex == 1 {
            // Load data for the second segment
            moviesForComingSoon = [
                MoviesModel(movieID: "12", movieName: "The Conjuring 3", moviePoster: "poster2", categoryID: "3", time: "2h", rating: 4),
            ]
        } else if sender.selectedSegmentIndex == 2 {
            // Load data for the second segment
            moviesForComingSoon = [
                MoviesModel(movieID: "13", movieName: "The Conjuring 3", moviePoster: "poster1", categoryID: "3", time: "2h", rating: 4),
            ]
            
            collectionMovieComingSoon.reloadData()
        }
    }
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        
        if collectionView == collectionMovieComingSoon {
            let centerPosterWidth = collectionViewWidth * 0.6 // Kích thước của poster chính
            let sidePosterWidth = collectionViewWidth * 0.2 // Kích thước của poster bên cạnh
            let posterHeight = collectionViewHeight
            
            if indexPath.item == 1 {
                return CGSize(width: centerPosterWidth, height: posterHeight)
            } else {
                return CGSize(width: sidePosterWidth, height: posterHeight)
            }
        } else {
            return CGSize(width: 200, height: 150)
        }
    }
}
