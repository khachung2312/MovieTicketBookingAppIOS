//
//  MovieSessionSelectionViewController.swift
//  MovieTicketBookingApp
//
//  Created by Khắc Hùng on 14/08/2023.
//

import UIKit

class MovieSessionSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var cvMovieDatetimes: UICollectionView!
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    @IBOutlet weak var tblCenema: UITableView!
    let cinemaNames = ["CGV Pamulang Barat sdjs sdj sjdh zdf sè sdf", "Rạp B", "Rạp C", "Rạp D"]
    var isShowCollectionViewTime = [Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCollectionViewTimeStates()
        setupTableView()
    }
    
    func initializeCollectionViewTimeStates() {
          isShowCollectionViewTime = [Bool](repeating: false, count: cinemaNames.count)
      }
    
    func setupTableView() {
        tblCenema.delegate = self
        tblCenema.dataSource = self
        tblCenema.register(UINib(nibName: "CenemaTableViewCell", bundle: nil), forCellReuseIdentifier: "CenemaCellIdentifier")
        cvMovieDatetimes.delegate = self
        cvMovieDatetimes.dataSource = self
        cvMovieDatetimes.register(UINib(nibName: "MovieDatetimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieDatetimeCellIdentifier")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        daysOfWeek.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvMovieDatetimes.dequeueReusableCell(withReuseIdentifier: "MovieDatetimeCellIdentifier", for: indexPath) as! MovieDatetimeCollectionViewCell
        
        cell.lblDays.text = daysOfWeek[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemaNames.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCenema.dequeueReusableCell(withIdentifier: "CenemaCellIdentifier") as! CenemaTableViewCell
        cell.viewTime.layer.borderWidth = 0.5
        cell.viewTime.layer.cornerRadius = 5
        cell.imgLogo.layer.cornerRadius = 10
        cell.viewTime.layer.borderColor = UIColor.lightGray.cgColor
        cell.lblCinemaName.text = cinemaNames[indexPath.row]
        cell.isCollectionViewTimeVisible = isShowCollectionViewTime[indexPath.row]
        cell.buttonAction = { [weak self] in
            self?.isShowCollectionViewTime[indexPath.row].toggle()
            self?.tblCenema.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }
    
    
}

extension MovieSessionSelectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 60)
    }
    
}
