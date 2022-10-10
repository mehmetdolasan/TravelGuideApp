//
//  BookmarksTableViewCell.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 1.10.2022.
//

import UIKit

class BookmarksTableViewCell: UITableViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var bgImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    bgImage.clipsToBounds = true
    bgImage.layer.cornerRadius = 15
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
    
  }
  
}
