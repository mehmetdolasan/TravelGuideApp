//
//  FlightsViewController.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import UIKit

class FlightsViewController: UIViewController {
  
  @IBOutlet weak var flightsTableView: UITableView!
  
  var viewModel = FlightsViewModel()
  private var model = FlightsModel()
  
  var flights: [FlightsCellViewModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    model.fetchData()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    setupUI()
    
    viewModel.viewDelegate = self
    viewModel.didViewLoad()
    
  }
  
  //changing the status bar color
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.barStyle = .default
  }
  
  func setupUI() {
    flightsTableView.delegate = self
    flightsTableView.dataSource = self
    let nib = UINib(nibName: "FlightsTableViewCell", bundle: nil)
    flightsTableView.register(nib, forCellReuseIdentifier: "FlightsTableViewCell")
  }
  
}

extension FlightsViewController: FlightsViewModelViewProtocol {
  func didCellItemFetch(_ flights: [FlightsCellViewModel]) {
    
    self.flights = flights
    DispatchQueue.main.async {
      self.flightsTableView.reloadData()
    }
  }
}

extension FlightsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destVC = storyboard?.instantiateViewController(withIdentifier: "ContentDetailViewController") as! ContentDetailViewController
    destVC.flag = "Flight"
    destVC.flight = self.flights[indexPath.row]
    navigationController?.pushViewController(destVC, animated: true)
  }
}

extension FlightsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return flights.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = flightsTableView.dequeueReusableCell(withIdentifier: "FlightsTableViewCell") as! FlightsTableViewCell
    
    cell.bgImage.image = UIImage(named: "searchItemBg-1")
    cell.nameLabel.text = "\(self.flights[indexPath.row].origin!) to \(self.flights[indexPath.row].destination!)"
    let price = String(self.flights[indexPath.row].price!)
    cell.priceLabel.text = price + "$"
    cell.selectionStyle = .none
    
    return cell
  }
}

