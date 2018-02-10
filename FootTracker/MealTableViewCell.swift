//
//  MealTableViewCell.swift
//  FootTracker
//
//  Created by Mayte Mejia Palacios on 31/01/18.
//  Copyright © 2018 Mayte. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    //MARK: Propieties
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
