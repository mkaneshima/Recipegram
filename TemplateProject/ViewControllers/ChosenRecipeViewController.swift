//
//  ChosenRecipeViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import Bond
import ConvenienceKit
import Mixpanel

class ChosenRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    // MARK: PhotoUploadTask
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    // MARK: Initialization for Recipe class
    var recipe: Recipe?
    {
        didSet
        {
            if recipe != nil && chosenImageView != nil && servingsLabel != nil && prepTimeLabel != nil && cookTimeLabel != nil && skillLabel != nil && ingredientsTextView != nil
            {
                // The selected image from the RecipeViewController timeline
                chosenImageView.image = recipe?.image.value
                
                // Recipe titles
                recipeTitleLabel.text = recipe?.recipeTitles
                
                // Servings, prep times, and cook times
                servingsLabel.text = recipe?.servings
                prepTimeLabel.text = recipe?.prepTimes
                cookTimeLabel.text = recipe?.cookTimes
                
                // Ingredients
                ingredientsImageView.image = UIImage(data: recipe!.ingredientsImages.getData()!)
                ingredientsTextView.text = recipe?.ingredients
                
            }
            
        }
    }
    
    // MARK: If the user selects the photo from the Recipe Timeline, switch to ChosenRecipeViewController
    @IBOutlet weak var chosenImageView: UIImageView!
    {
        didSet
        {
            if recipe != nil
            {
                chosenImageView.image = recipe?.image.value
            }
        }
    }
    
    // MARK: Recipe titles
    @IBOutlet weak var recipeTitleLabel: UILabel!
        {
        didSet
        {
            if recipe != nil
            {
                recipeTitleLabel.text = recipe?.recipeTitles
            }
        }
    }
    
    // MARK: Servings updates
    @IBOutlet weak var servingsLabel: UILabel!
        {
        didSet
        {
            if recipe != nil
            {
                servingsLabel.text = recipe?.servings
            }
        }
    }
    
    // MARK: Prep time updates
    @IBOutlet weak var prepTimeLabel: UILabel!
        {
        didSet
        {
            if recipe != nil
            {
                prepTimeLabel.text = recipe?.prepTimes
            }
        }
    }
    
    // MARK: Cook time updates
    @IBOutlet weak var cookTimeLabel: UILabel!
        {
        didSet
        {
            if recipe != nil
            {
                cookTimeLabel.text = recipe?.cookTimes
            }
        }
    }
    
    // MARK: Skill updates
    @IBOutlet weak var skillLabel: UILabel!
    {
        didSet
        {
            if recipe != nil
            {
                skillLabel.text = recipe?.skillLevel
            }
        }
        
    }
    
    // MARK: Updated images of ingredients
    @IBOutlet weak var ingredientsImageView: UIImageView!
    
    // MARK: Ingredients updates in text
    @IBOutlet weak var ingredientsTextView: UITextView!
    {
        didSet
        {
            if recipe != nil
            {
                ingredientsTextView.text = recipe?.ingredients
            }
        }
    }
    
    // MARK: Updated directions with text and image
    @IBOutlet weak var updatedDirectionsTableView: UITableView!
    var updatedDirectionsArray: [String] = []
    var updatedImagesArray: [UIImage] = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updatedDirectionsTableView.dataSource = self
        updatedDirectionsTableView.delegate = self
        
        
        // Do any additional setup after loading the view.
        
        recipe!.ingredientsImages.getDataInBackgroundWithBlock
        {
            (data: NSData?, error: NSError?) -> Void in
            if let error = error
            {
                ErrorHandling.defaultErrorHandler(error)
            }
            if let data = data
            {
                let image = UIImage(data: data, scale:1.0)!
                self.ingredientsImageView.image = image
              //  Recipe.imageCache[self.recipe!.ingredientsImage!.name] = image
            }
            
        }
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        updatedDirectionsTableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Delegate for UpdatedDirectionsTableViewCell
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        //        return Int(updatedDirectionsArray.count ?? 0) // Create 1 row as an example
        
        return recipe!.directionsText.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("UpdatedDirectionsCell") as! UpdatedDirectionsTableViewCell
        
        if recipe!.directionsText.count > 0
        {
            cell.updatedDirectionsTextView.text = recipe?.directionsText[indexPath.row]
            
            let directionsImage =  recipe?.directionsImages[indexPath.row]
            
            cell.updatedDirectionsImageView.image = UIImage(data:directionsImage!.getData()!)
        }
        else
        {
            cell.updatedDirectionsTextView.showsVerticalScrollIndicator = true
            cell.updatedDirectionsTextView.text = ""
        }
        
        return cell
    }
    
}



