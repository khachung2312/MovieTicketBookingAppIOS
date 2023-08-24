//
//  MovieSessionSelectionViewController.swift
//  MovieTicketBookingApp
//
//  Created by Khắc Hùng on 14/08/2023.
//

import UIKit

class MovieSessionSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var btnContinueOutlet: UIButton!
    @IBOutlet weak var cvMovieDatetimes: UICollectionView!
    @IBOutlet weak var tblCenema: UITableView!
    var movieTheaterData: MovieTheaterResponse?
    var isShowCollectionViewTime = [Bool]()
    var selectedDate: Date?
    var selectedMovieTheater: Slot?
    var selectedMovieType: Price?
    var selectedMovieName: Theater?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        callAPIGetMovieTheater()
        
    }
    
    
    func callAPIGetMovieTheater() {
        let apiHandler = APIHandler()
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let dateString = dateFormatter.string(from: currentDate)
        apiHandler.getMovieTheatersByDate(date: dateString) { movieTheaterResponseData in
            self.movieTheaterData = movieTheaterResponseData
            self.initializeCollectionViewTimeStates()
            DispatchQueue.main.async {
                self.tblCenema.reloadData()
            }
        }
    }
    
    
    
    func initializeCollectionViewTimeStates() {
        isShowCollectionViewTime = [Bool](repeating: false, count:  movieTheaterData?.data.count ?? 0)
    }
    
    func setupTableView() {
        tblCenema.delegate = self
        tblCenema.dataSource = self
        tblCenema.register(UINib(nibName: "CenemaTableViewCell", bundle: nil), forCellReuseIdentifier: "CenemaCellIdentifier")
        cvMovieDatetimes.delegate = self
        cvMovieDatetimes.dataSource = self
        cvMovieDatetimes.register(UINib(nibName: "MovieDatetimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieDatetimeCellIdentifier")
        btnContinueOutlet.layer.cornerRadius = 7
        btnContinueOutlet.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvMovieDatetimes.dequeueReusableCell(withReuseIdentifier: "MovieDatetimeCellIdentifier", for: indexPath) as! MovieDatetimeCollectionViewCell
        cell.layer.cornerRadius = 5
        let currentDate = Date()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = indexPath.item
        
        let targetDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        let dateFormatter = DateFormatter()
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "E"
        dateFormatter.dateFormat = "dd"
        
        if let date = targetDate {
            if calendar.isDateInToday(date) {
                let dateString = dateFormatter.string(from: date)
                cell.lblDays.text = "Hôm nay"
                cell.lblDate.text = dateString
            } else {
                let dayString = dayFormatter.string(from: date)
                let dateString = dateFormatter.string(from: date)
                cell.lblDays.text = dayString
                cell.lblDate.text = dateString
            }
        } else {
            cell.lblDate.text = ""
        }
        if indexPath.item == 0 {
            cell.lblDays.font = UIFont.systemFont(ofSize: 14)
            cell.lblDays.textColor = .systemCyan
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTheaterData?.data.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func showContinueButton() {
        btnContinueOutlet.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCenema.dequeueReusableCell(withIdentifier: "CenemaCellIdentifier") as! CenemaTableViewCell
        cell.btnContinueOutlet = { [weak self] in
              self?.showContinueButton()
          }
        
        cell.viewTime.layer.borderWidth = 0.5
        cell.viewTime.layer.cornerRadius = 5
        cell.imgLogo.layer.cornerRadius = 10
        cell.viewTime.layer.borderColor = UIColor.lightGray.cgColor
        cell.lblCinemaName.text = movieTheaterData?.data[indexPath.row].theater.name
        cell.isCollectionViewTimeVisible = isShowCollectionViewTime[indexPath.row]
        cell.buttonAction = { [weak self] in
            self?.isShowCollectionViewTime[indexPath.row].toggle()
            self?.tblCenema.reloadRows(at: [indexPath], with: .none)
        }
        cell.continueButtonGetMovieTheter = { movieShowtime in
            self.movieTheaterData = movieShowtime
        }
        cell.continueButtonGetName = { movieShowtime in
            self.selectedMovieName = movieShowtime
        }
        cell.continueButtonGetSlot = { movieShowtime in
            self.selectedMovieTheater = movieShowtime
        }
        
        cell.continueButtonGetPrice = { movieShowtime in
            self.selectedMovieType = movieShowtime
        }
        return cell
    }
    var selectedIndexPath: IndexPath?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedIndexPath,
           let previousCell = collectionView.cellForItem(at: selectedIndexPath) as? MovieDatetimeCollectionViewCell {
            previousCell.backgroundColor = .clear
            
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieDatetimeCollectionViewCell {
            cell.backgroundColor = .systemPink
        }
        
        selectedIndexPath = indexPath
        
        let currentDate = Date()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = indexPath.item
        selectedDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = selectedDate {
            let dateString = dateFormatter.string(from: date)
            let apiHandler = APIHandler()
            apiHandler.getMovieTheatersByDate(date: dateString) { movieTheaterResponseData in
                self.movieTheaterData = movieTheaterResponseData
                self.initializeCollectionViewTimeStates()
                DispatchQueue.main.async {
                    self.tblCenema.reloadData()
                }
            }
        }
        
    }
    
    @IBAction func btnContinue(_ sender: UIButton) {
        guard let seatSelectionViewController = UIStoryboard(name: "BookTicketsStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "SeatSelectionViewController") as? SeatSelectionViewController else {
            return
        }
        seatSelectionViewController.movieTheater = movieTheaterData
        seatSelectionViewController.selectedMovieTheater = selectedMovieTheater
        seatSelectionViewController.selectedMovieTheaterType = selectedMovieType
        seatSelectionViewController.selectedMovieName = selectedMovieName
        self.navigationController?.pushViewController(seatSelectionViewController, animated: true)

    }
    
}

extension MovieSessionSelectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 70)
    }
    
}

