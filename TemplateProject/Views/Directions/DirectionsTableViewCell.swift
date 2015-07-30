//
//  DirectionsTableViewCell.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/20/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class DirectionsTableViewCell: UITableViewCell
{
    @IBOutlet weak var directionsTextView: UITextView!
    @IBOutlet weak var directionsImageView: UIImageView!
    @IBOutlet weak var directionsCameraButton: UIButton!
    
    
    var directions: [String]?
    
    
    @IBAction func directionsCameraButtonPressed(sender: AnyObject)
    {
        
    }
    
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        directionsTextView.scrollEnabled = true
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
