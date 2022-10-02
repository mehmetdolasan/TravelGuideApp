//
//  BookmarksViewController.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import UIKit

class BookmarksViewController: UIViewController {
  
  
  @IBOutlet weak var bookmarksTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //largeNavbarTitle()
    configureTableView()
    
    //navigationController?.navigationBar.prefersLargeTitles = true
    
  }
//  private func largeNavbarTitle(){
//    //large navbar title
//    navigationController?.navigationBar.prefersLargeTitles = true
//  }
  
  private func configureTableView(){
    let nib = UINib(nibName: "BookmarksTableViewCell", bundle: nil)
    bookmarksTableView.register(nib, forCellReuseIdentifier: "BookmarksTableViewCell")
    bookmarksTableView.dataSource = self
    bookmarksTableView.delegate = self
  }
}

extension BookmarksViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = bookmarksTableView.dequeueReusableCell(withIdentifier: "BookmarksTableViewCell") as! BookmarksTableViewCell
    cell.bgImage.image = UIImage(named: "searchItemBg-1")
    cell.nameLabel.text = "Name"
    cell.descLabel.text = "Description"
    return cell
  }
  
}

extension BookmarksViewController: UITableViewDelegate {
  
}


