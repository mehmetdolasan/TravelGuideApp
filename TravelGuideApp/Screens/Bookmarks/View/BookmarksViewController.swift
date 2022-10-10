//
//  BookmarksViewController.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import UIKit
import CoreData

class BookmarksViewController: UIViewController {
  
  
  @IBOutlet weak var bookmarksTableView: UITableView!
  
  lazy var viewModel = BookmarksViewModel()
  private var bookmarks: [BookmarksCellViewModel] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //largeNavbarTitle()
    //navigationController?.navigationBar.prefersLargeTitles = true
    
    configureTableView()
    viewModel.viewDelegate = self
    viewModel.didViewLoad()
  }
  
  /*
  private func largeNavbarTitle(){
    large navbar title
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  */
  
  private func configureTableView(){
    let nib = UINib(nibName: "BookmarksTableViewCell", bundle: nil)
    bookmarksTableView.register(nib, forCellReuseIdentifier: "BookmarksTableViewCell")
    bookmarksTableView.dataSource = self
  }
  //add bookmarks with coredata
  private func addBookmarks() {
    let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    let data = Bookmarks(context: managedContext)
    data.setValue("Nevsehir", forKey: #keyPath(Bookmarks.name))
    data.setValue("Goreme", forKey: #keyPath(Bookmarks.desc))
    AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
  }
  
}
extension BookmarksViewController: BookmarksViewModelViewProtocol {
  func didCellItemFetch(_ items: [BookmarksCellViewModel]) {
    self.bookmarks = items
    self.bookmarksTableView.reloadData()
  }
}

extension BookmarksViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bookmarks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = bookmarksTableView.dequeueReusableCell(withIdentifier: "BookmarksTableViewCell") as! BookmarksTableViewCell
    cell.bgImage.image = UIImage(named: "searchItemBg-1")
    cell.nameLabel.text = bookmarks[indexPath.row].name
    cell.descLabel.text = bookmarks[indexPath.row].desc
    
    return cell
  }
  
}


