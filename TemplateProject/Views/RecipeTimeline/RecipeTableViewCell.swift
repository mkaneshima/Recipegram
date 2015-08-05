//
//  RecipeTableViewCell.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/18/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Bond
import Parse
import Foundation

class RecipeTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    
    var recipe:Recipe?
    {
        didSet
        {
            // free memory of image stored with post that is no longer displayed
            if let oldValue = oldValue where oldValue != recipe
            {
                recipeImageView.designatedBond.unbindAll()
                
                if (oldValue.image.bonds.count == 0)
                {
                    oldValue.image.value = nil
                }
            }
            
            if let recipe = recipe
            {
                // bind the image of the recipe to the 'recipeImage' view
                recipe.image ->> recipeImageView
                
                usernameLabel.text = recipe.user?.username
                
                // Add the DateTools in the Podfile
//                postTimeLabel.text = recipe.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""

            }
            
            
            
        }
    }
    
    // MARK: Initialization
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)

    }
    
    // MARK: Additional methods
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
