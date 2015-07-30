//
//  ChosenRecipeViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class ChosenRecipeViewController: UIViewController, UITableViewDelegate
{
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var prepTimeLabel: UILabel!
    
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var ingredientsImageView: UIImageView!
    
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    @IBOutlet weak var updatedDirectionsTableView: UITableView!
    
    var updatedDirectionsArray: [String] = []
    var updatedImagesArray: [UIImage] = []

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
    var recipe: Recipe?
    {
        didSet
        {
            if recipe != nil && chosenImageView != nil
            {
                chosenImageView.image = recipe?.image.value
            }
        }
    }

    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    {
        didSet
        {
            if recipe != nil
            {
                recipeTitleLabel.text = recipe?.title.value
            }
        }
    }

    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Delegate
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return Int(updatedDirectionsArray.count ?? 0) // Create 1 row as an example
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("UpdatedDirectionsCell") as! UpdatedDirectionsTableViewCell
        
        let directions = updatedDirectionsArray[indexPath.row]
        let updatedImages = updatedImagesArray[indexPath.row]
        cell.updatedDirectionsLabel.text = directions
        cell.updatedDirectionsImageView.image = updatedImages
        
        return cell
    }

}



