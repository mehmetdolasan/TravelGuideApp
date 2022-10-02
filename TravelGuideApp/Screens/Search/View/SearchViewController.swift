//
//  SearchViewController.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import UIKit

class SearchViewController: UIViewController {
  
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
  //MARK: lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    
    flightsLine.isHidden = true
    hotelLine.isHidden = false
    
  }
  //MARK: flights stackView tapped
  @objc
  func flightsStackViewTapped(sender: AnyObject) {

    flightsTapStatus = true
    hotelTapStatus = false
    
    hotelLine.isHidden = true
    flightsLine.isHidden = false
    
    
  }
  
  //MARK: setup ui
  func setupUI(){
    tableView.dataSource = self
    tableView.delegate = self
    
    let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
  }
  
}
//MARK: tableView delegate
extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
//MARK: tableView data  source
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
    cell.bgImage.image = UIImage(named: "searchItemBg-1")
    cell.nameLabel.text = "Marina Bay"
    cell.descLabel.text = "Singapore"
    cell.layer.cornerRadius = 10
    return cell
    
  }
}
