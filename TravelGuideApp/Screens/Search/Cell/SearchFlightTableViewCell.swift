//
//  SearchFlightTableViewCell.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 10.10.2022.
//

import UIKit

class SearchFlightTableViewCell: UITableViewCell {

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
    
}
