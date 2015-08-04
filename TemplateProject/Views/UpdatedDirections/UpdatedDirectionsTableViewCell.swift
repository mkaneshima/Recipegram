//
//  UpdatedDirectionsTableViewCell.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/26/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class UpdatedDirectionsTableViewCell: UITableViewCell
{
    let recipe = Recipe()
    
    @IBOutlet weak var updatedDirectionsImageView: UIImageView!
    
    @IBOutlet weak var updatedDirectionsTextView: UITextView!
//    var updatedDirections: [String] = []
//    var updatedImages: [UIImage] = []
    
   
//    let direction = Direction()
    
    // MARK: How to get the directions content (text and image objects) from NewRecipeViewController to show up in ChosenRecipeViewController
    func displayDirection()
    {
        if let updatedDirectionImageView = updatedDirectionsImageView, updatedDirectionTextView = updatedDirectionsTextView
        {
            updatedDirectionImageView.image = recipe.image.value
            updatedDirectionTextView.text = recipe.directionsText[0]
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
