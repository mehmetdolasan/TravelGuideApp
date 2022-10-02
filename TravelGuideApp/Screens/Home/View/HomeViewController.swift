//
//  ViewController.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import UIKit

class HomeViewController: UIViewController {

  
  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var flightsButton: UIButton!
  @IBOutlet weak var hotelsButton: UIButton!
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //label ' ı öne almak için gerekli kod
    //titleLabel.layer.zPosition = 1
    self.view.bringSubviewToFront(flightsButton)
    self.view.sendSubviewToBack(backgroundImage)
    flightsButton.layer.zPosition = 1
    
    flightsButton.layer.cornerRadius = 8
    hotelsButton.layer.cornerRadius = 8
    
    let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
    collectionView.dataSource = self
    
  }
  
  
  @IBAction func hotelsButtonTapped(_ sender: Any) {
    let destVC = storyboard?.instantiateViewController(withIdentifier: "HotelsViewController")
    navigationController?.pushViewController(destVC!, animated: true)
    
  }
  @IBAction func flightsButtonTapped(_ sender: Any) {
    let destVC = storyboard?.instantiateViewController(withIdentifier: "FlightsViewController")
    navigationController?.pushViewController(destVC!, animated: true)
  }
  //set the status bar color is white
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  override func viewDidAppear(_ animated: Bool) {
    navigationController?.navigationBar.barStyle = .black
  }
}

extension HomeViewController: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
    cell.collectionViewBgImage.image = UIImage(named: "collectionViewImage")
    cell.collectionViewBookmarkImage.image = UIImage(named: "collectionViewBookmarkBg")
    cell.collectionViewTitleLabel.text = "EXPERIENCE"
    cell.collectionViewDescLabel.text = "Beatiful Alley Scene in Old Town in Europe at Sunset"
    return cell
  }
  
}

