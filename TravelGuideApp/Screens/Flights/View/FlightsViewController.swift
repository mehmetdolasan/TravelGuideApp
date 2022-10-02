//
//  FlightsViewController.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import UIKit

class FlightsViewController: UIViewController {
  
  @IBOutlet weak var flightsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    setupUI()
    
  }
  
  //sayafa geçişinde status bar renk değişimi
  override func viewWillAppear(_ animated: Bool) {
    //navigationController?.navigationBar.barStyle = .default
  }
  
  func setupUI() {
    flightsTableView.delegate = self
    flightsTableView.dataSource = self
    let nib = UINib(nibName: "FlightsTableViewCell", bundle: nil)
    flightsTableView.register(nib, forCellReuseIdentifier: "FlightsTableViewCell")
  }
  
}

extension FlightsViewController: UITableViewDelegate {
  
}

extension FlightsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = flightsTableView.dequeueReusableCell(withIdentifier: "FlightsTableViewCell") as! FlightsTableViewCell
    
    cell.bgImage.image = UIImage(named: "searchItemBg-1")
    cell.nameLabel.text = "Name"
    cell.descLabel.text = "Description"
    
    return cell
  }
}

