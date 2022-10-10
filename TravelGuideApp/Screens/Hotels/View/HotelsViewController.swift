//
//  HotelsViewController.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import UIKit

class HotelsViewController: UIViewController {
  
  @IBOutlet weak var hotelsTableView: UITableView!
  
  var viewModel = HotelsViewModel()
  private var model = HotelsModel()
  
  var hotels: [HotelsCellViewModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    model.fetchData()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    setupUI()
    
    viewModel.viewDelegate = self
    viewModel.didViewLoad()
    
  }
  //sayafa geçişinde status bar renk değişimi
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.barStyle = .default
  }
  
  func setupUI(){
    hotelsTableView.delegate = self
    hotelsTableView.dataSource = self
    let nib = UINib(nibName: "HotelsTableViewCell", bundle: nil)
    hotelsTableView.register(nib, forCellReuseIdentifier: "HotelsTableViewCell")
  }
  
}

extension HotelsViewController: HotelsViewModelViewProtocol {
  func didCellItemFetch(_ hotels: [HotelsCellViewModel]) {
    
    self.hotels = hotels
    DispatchQueue.main.async {
      self.hotelsTableView.reloadData()
    }
  }
}

extension HotelsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let destVC = storyboard?.instantiateViewController(withIdentifier: "ContentDetailViewController") as! ContentDetailViewController
    destVC.flag = "Hotel"
    destVC.hotel = self.hotels[indexPath.row]
    navigationController?.pushViewController(destVC, animated: true)
  }
}

extension HotelsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return hotels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = hotelsTableView.dequeueReusableCell(withIdentifier: "HotelsTableViewCell", for: indexPath) as! HotelsTableViewCell
    
    cell.bgImage.image = UIImage(named: "searchItemBg-1")
    cell.nameLabel.text = self.hotels[indexPath.row].hotelName
    cell.descLabel.text = self.hotels[indexPath.row].desc
    cell.selectionStyle = .none
    
    return cell
  }
  
}
