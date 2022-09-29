//
//  HomeCollectionViewCell.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 29.09.2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var collectionViewBgImage: UIImageView!
  @IBOutlet weak var collectionViewBookmarkImage: UIImageView!
  
  @IBOutlet weak var collectionViewTitleLabel: UILabel!
  @IBOutlet weak var collectionViewDescLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
