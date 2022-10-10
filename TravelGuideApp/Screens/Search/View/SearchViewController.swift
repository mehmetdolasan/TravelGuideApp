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
    
    
//    let f1 = FlightsCellViewModel(origin: "İzmir", destination: "İst", price: 80)
//    let f2 = FlightsCellViewModel(origin: "Antalya", destination: "İst", price: 60)
//    let f3 = FlightsCellViewModel(origin: "Adana", destination: "Bursa", price: 50)
//    let f4 = FlightsCellViewModel(origin: "Urfa", destination: "İzmir", price: 70)
//    tableFlightData.append(f1)
//    tableFlightData.append(f2)
//    tableFlightData.append(f3)
//    tableFlightData.append(f4)
//    let h1 = HotelsCellViewModel(hotelName: "Ordu Balıktaşı", desc: "Deniz Manzaralı 3 Yıldız")
//    let h2 = HotelsCellViewModel(hotelName: "Rixos Antalya", desc: "4 Yıldız Premium")
//    let h3 = HotelsCellViewModel(hotelName: "Six Senses Sarıyer", desc: "5 Yıldız Lüx")
//    tableHotelData.append(h1)
//    tableHotelData.append(h2)
//    tableHotelData.append(h3)
    
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
    //
    let nib2 = UINib(nibName: "SearchFlightTableViewCell", bundle: nil)
    tableView.register(nib2, forCellReuseIdentifier: "SearchFlightTableViewCell")
    
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
    if flightsTapStatus {
      return tableFlightData.count
    }else {
      return tableHotelData.count
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if flightsTapStatus {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFlightTableViewCell") as! SearchFlightTableViewCell
      //cell.bgImage.image = UIImage(named: "searchItemBg-1")
      cell.nameLabel.text = "\(tableFlightData[indexPath.row].origin ?? "") to \(tableFlightData[indexPath.row].destination ?? "")"
      cell.descLabel.text = "\(tableFlightData[indexPath.row].price ?? 0) $"
      cell.translatesAutoresizingMaskIntoConstraints = false
      cell.selectionStyle = .none
      return cell
    }else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
      cell.bgImage.image = UIImage(named: "searchItemBg-1")
      cell.nameLabel.text = tableHotelData[indexPath.row].hotelName
      cell.descLabel.text = tableHotelData[indexPath.row].desc
      cell.selectionStyle = .none
      return cell
    }
  }
}
