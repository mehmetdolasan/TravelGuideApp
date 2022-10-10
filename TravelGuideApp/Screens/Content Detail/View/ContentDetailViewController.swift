//
//  ContentDetailViewController.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import UIKit

class ContentDetailViewController: UIViewController {
  
  @IBOutlet weak var backgroundImg: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var addBookmarkButton: UIButton!
  
  var flight: FlightsCellViewModel?
  var hotel: HotelsCellViewModel?
  var flag: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    putBackButtonInFrontOfBgImg()
    hideBackButton()
    setupUI()
    
    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow.left")
    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow.left")
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ",style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    
  }
  
  //set the status bar color is white
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  override func viewDidAppear(_ animated: Bool) {
    navigationController?.navigationBar.barStyle = .black
  }
  
  private func setupUI() {
    if flag == "Flight" {
      if let flight = flight {
        self.titleLabel.text = "\(flight.origin ?? "") to \(flight.destination ?? "")"
        self.descLabel.text = "\(flight.price ?? 0) $"
        self.addBookmarkButton.isHidden = true
      }
    }else {
      if let hotel = hotel {
        self.titleLabel.text = hotel.hotelName
        self.descLabel.text = hotel.desc
      }
    }
  }
  
  private func hideBackButton() {
    //hide back button
    self.navigationItem.setHidesBackButton(true, animated: true)
  }
  
  private func putBackButtonInFrontOfBgImg() {
    self.view.bringSubviewToFront(backButton)
    self.view.sendSubviewToBack(backgroundImg)
    backButton.layer.zPosition = 1
  }
  
  
  
  @IBAction func backButtonTapped(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func buttonAddBookmarkTapped(_ sender: Any) {
    
    let alert = UIAlertController(title: "Sure to Add", message: "Do you want Add to Bookmarks ", preferredStyle: UIAlertController.Style.actionSheet)
    
    alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
      
          let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
          let data = Bookmarks(context: managedContext)
      data.setValue(self.hotel?.hotelName, forKey: #keyPath(Bookmarks.name))
      data.setValue(self.hotel?.desc, forKey: #keyPath(Bookmarks.desc))
          AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
      
      
    }))
    alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))
    
    self.present(alert,animated: true,completion: nil)
    
  }

}
