//
//  UpdatedDirectionsTableViewCell.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/26/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class UpdatedDirectionsTableViewCell: UITableViewCell
{

    @IBOutlet weak var updatedDirectionsImageView: UIImageView!
    
    @IBOutlet weak var updatedDirectionsLabel: UILabel!
    
    var updatedDirections: [String]?
    var updatedImages: UIImage?
    
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
