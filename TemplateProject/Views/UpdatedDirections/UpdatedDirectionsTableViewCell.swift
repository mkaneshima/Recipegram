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
    
    
    // MARK: How to get the directions content (text and image objects) from NewRecipeViewController to show up in ChosenRecipeViewController
//    func displayDirection()
//    {
//        if let updatedDirectionImageView = updatedDirectionsImageView, updatedDirectionTextView = updatedDirectionsTextView
//        {
//            if (updatedDirectionTextView != self.recipe.directionsText || updatedDirectionImageView != self.recipe.directionsImages)
//            {
//                updatedDirectionTextView.text = self.directionsViewController.directionsTextField.text
//                updatedDirectionImageView.image = self.directionsViewController.directionsImageView.image
//            }
//           
//        }
//    }
//    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        updatedDirectionsTextView.showsVerticalScrollIndicator = true
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
