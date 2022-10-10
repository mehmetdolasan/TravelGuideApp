//
//  FlightsTableViewCell.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 2.10.2022.
//

import UIKit

class FlightsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var bgImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    bgImage.clipsToBounds = true
    bgImage.layer.cornerRadius = 15
    
  }
  
}
