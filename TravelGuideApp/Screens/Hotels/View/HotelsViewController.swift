//
//  HotelsViewController.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import UIKit

class HotelsViewController: UIViewController {
  
  @IBOutlet weak var hotelsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    setupUI()
  }
  //sayafa geçişinde status bar renk değişimi
  override func viewWillAppear(_ animated: Bool) {
    //navigationController?.navigationBar.barStyle = .default
  }
  
  func setupUI(){
    hotelsTableView.delegate = self
    hotelsTableView.dataSource = self
    let nib = UINib(nibName: "HotelsTableViewCell", bundle: nil)
    hotelsTableView.register(nib, forCellReuseIdentifier: "HotelsTableViewCell")
  }
  
}

extension HotelsViewController: UITableViewDelegate {
  
}

extension HotelsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = hotelsTableView.dequeueReusableCell(withIdentifier: "HotelsTableViewCell", for: indexPath) as! HotelsTableViewCell
    
    cell.bgImage.image = UIImage(named: "searchItemBg-1")
    cell.nameLabel.text = "Name"
    cell.descLabel.text = "Description"
    
    return cell
  }
  
}
