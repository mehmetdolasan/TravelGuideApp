//
//  SearchViewController.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import UIKit

class SearchViewController: UIViewController {
  
  //Design variables
  var viewModel = SearchViewModel()
  private var model = SearchModel()
  
  //MARK: hotel elements
  @IBOutlet weak var hotelStackView: UIStackView!
  @IBOutlet weak var hotelIcon: UIImageView!
  @IBOutlet weak var hotelLabel: UILabel!
  @IBOutlet weak var hotelLine: UIImageView!
  //MARK: flights elements
  @IBOutlet weak var flightsStackView: UIStackView!
  @IBOutlet weak var flightsIcon: UIImageView!
  @IBOutlet weak var flightsLabel: UILabel!
  @IBOutlet weak var flightsLine: UIImageView!
  //MARK: search textField
  @IBOutlet weak var searchTextField: UITextField!
  //MARK: tableView
  @IBOutlet weak var tableView: UITableView!
  //MARK: taps's status
  var hotelTapStatus = false
  var flightsTapStatus = false
  
  var tableFlightData: [FlightsCellViewModel] = []
  var tableHotelData: [HotelsCellViewModel] = []
  
  //MARK: lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    model.fetchFlightData()
    model.fecthHotelData()
    
    
    //MARK: init navbar large title
    navigationController?.navigationBar.prefersLargeTitles = true
    //MARK: init taps status and appereance
    flightsLine.isHidden = true
    hotelTapStatus = true
    flightsTapStatus = false
    
    //MARK: hotel stackView Tap Recognizer
    let hotelStackViewTap = UITapGestureRecognizer(target: self, action: #selector(hotelStackViewTapped))
    hotelStackView.addGestureRecognizer(hotelStackViewTap)
    
    //MARK: flights stackView Tap Recognizer
    let flightsStackViewTap = UITapGestureRecognizer(target: self, action: #selector(flightsStackViewTapped))
    flightsStackView.addGestureRecognizer(flightsStackViewTap)
    
    viewModel.viewDelegate = self
    viewModel.didViewLoad()
    
    //MARK: init setup ui
    setupUI()
    
  }
  
  //MARK: hotel stackView tapped
  @objc
  func hotelStackViewTapped(sender: AnyObject) {
    
    hotelTapStatus = true
    flightsTapStatus = false
    
    hotelIcon.image = UIImage(named: "hotelsSelected")
    hotelLabel.textColor = UIColor(red: 0.929, green: 0.261, blue: 0.367, alpha: 1.0)
    flightsLabel.textColor = UIColor(red: 0.760, green: 0.773, blue: 0.841, alpha: 1.0)
    flightsIcon.image = UIImage(named: "flightsUnselected")
    
    flightsLine.isHidden = true
    hotelLine.isHidden = false
    
    //
    tableView.reloadData()
    tableView.dataSource = self
    viewModel.didViewLoad()
    
    
  }
  //MARK: flights stackView tapped
  @objc
  func flightsStackViewTapped(sender: AnyObject) {

    flightsTapStatus = true
    hotelTapStatus = false
    
    flightsIcon.image = UIImage(named: "flightsSelected")
    flightsLabel.textColor = UIColor(red: 0.929, green: 0.261, blue: 0.367, alpha: 1.0)
    hotelLabel.textColor = UIColor(red: 0.760, green: 0.773, blue: 0.841, alpha: 1.0)
    hotelIcon.image = UIImage(named: "hotelsUnselected")
    
    hotelLine.isHidden = true
    flightsLine.isHidden = false
    
    //
    tableView.reloadData()
    tableView.dataSource = self
    viewModel.didViewLoad()
    
    
  }
  
  //MARK: setup ui
  func setupUI(){
    tableView.dataSource = self
    
    let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
    
  }
  
}

extension SearchViewController: SearchViewModelViewProtocol {
  func didFlightCellItemFetch(_ flights: [FlightsCellViewModel]) {
    self.tableFlightData = flights
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func didHotelCellItemFetch(_ hotels: [HotelsCellViewModel]) {
    self.tableHotelData = hotels
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
}


//MARK: tableView data  source
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if hotelTapStatus {
      return tableHotelData.count
    }else {
      return tableFlightData.count
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if hotelTapStatus {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
      cell.bgImage.image = UIImage(named: "searchItemBg-1")
      if let hotelName = tableHotelData[indexPath.row].hotelName, let hotelDesc = tableHotelData[indexPath.row].desc {
        cell.nameLabel.text = hotelName
        cell.descLabel.text = hotelDesc
        
      }
      cell.selectionStyle = .none
      return cell
      
    }else {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
      cell.bgImage.image = UIImage(named: "searchItemBg-1")
      if let origin = tableFlightData[indexPath.row].origin,
         let destination = tableFlightData[indexPath.row].destination,
         let price = tableFlightData[indexPath.row].price {
        
        cell.nameLabel.text = origin + " to " + destination
        cell.descLabel.text = "\(price)"
        
      }
      
      cell.selectionStyle = .none
      return cell
    }
  }
}
