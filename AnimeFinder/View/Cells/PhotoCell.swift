//
//  PhotoCell.swift
//  AnimeFinder
//
//  Created by Caleb Wheeler on 9/4/20.
//  Copyright © 2020 Caleb Wheeler. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var TheImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
