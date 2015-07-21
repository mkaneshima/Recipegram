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

class RecipeTableViewCell: UITableViewCell
{
    var likeBond: Bond<[PFUser]?>!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var likesIconImageView: UIImageView!
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    // MARK: Button Callbacks
    @IBAction func moreButtonTapped(sender: AnyObject)
    {
//        timeline?.showActionSheetForPost(post!)
    }
    @IBAction func likeButtonTapped(sender: AnyObject)
    {
        recipe?.toggleLikeRecipe(PFUser.currentUser()!)
    }
    
    var recipe:Recipe?
    {
        didSet
        {
            // free memory of image stored with post that is no longer displayed
            if let oldValue = oldValue where oldValue != recipe
            {
                likeBond.unbindAll()
                recipeImageView.designatedBond.unbindAll()
                
                if (oldValue.image.bonds.count == 0)
                {
                    oldValue.image.value = nil
                }
            }
            
            if let recipe = recipe
            {
                // bind the image of the post to the 'postImage' view
                recipe.image ->> recipeImageView
                
                // bind the likeBond that we defined earlier, to update like label and button when likes change
                recipe.likes ->> likeBond
            }
        }
    }
    
    // MARK: Initialization
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)

        likeBond = Bond<[PFUser]?>()
        {
            [unowned self] likeList in
            if let likeList = likeList
            {
                self.likesLabel.text = self.stringFromUserList(likeList)
                self.likeButton.selected = contains(likeList, PFUser.currentUser()!)
                self.likesIconImageView.hidden = (likeList.count == 0)
            }
            else
            {
                // if there is no list of users that like this post, reset everything
                self.likesLabel.text = ""
                self.likeButton.selected = false
                self.likesIconImageView.hidden = true
            }
        }
    }

    // Generates a comma separated list of usernames from an array (e.g. "User1, User2")
    func stringFromUserList(userList: [PFUser]) -> String
    {
        let usernameList = userList.map
        {
            user in user.username!
        }
        let commaSeparatedUserList = ", ".join(usernameList)
        
        return commaSeparatedUserList
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
