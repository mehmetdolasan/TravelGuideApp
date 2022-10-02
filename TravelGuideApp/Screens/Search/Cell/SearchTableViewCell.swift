//
//  SearchTableViewCell.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 2.10.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var bgImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
    
    
  }
  
//  override func layoutSubviews() {
//    super.layoutSubviews()
//
//    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 15, right: 0))
//  }
  
}
