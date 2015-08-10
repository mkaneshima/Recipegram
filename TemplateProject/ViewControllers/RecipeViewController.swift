//
//  RecipeViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/18/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import ConvenienceKit
import AVFoundation
import FBSDKCoreKit
import FBSDKLoginKit

class RecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, TimelineComponentTarget
{
    @IBOutlet weak var tableView: UITableView!
    
    var selected: Int!
    
    // Segue Identifiers
    let recipeSegueIdentifier = "ShowRecipeSegue"
    let newRecipeSegueIdentifier = "CreateNewRecipeSegue"
    
    
    @IBOutlet weak var addRecipeBarButton: UIBarButtonItem!
    
    @IBAction func addButtonPressed(sender: AnyObject)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newRecipeViewController: AnyObject! = storyboard.instantiateViewControllerWithIdentifier(newRecipeSegueIdentifier)
        
    }

    
    // MARK: Logout bar button
    @IBOutlet weak var logoutBarButtonItem: UIBarButtonItem!
    
    
    @IBAction func logoutBarButtonItemPressed(sender: AnyObject)
    {
        PFUser.logOut()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.logOut()
    }
    
    
    // Timeline Component Protocol
    let defaultRange = 0...4
    let additionalRangeSize = 5
    var recipeTimelineComponent: TimelineComponent<Recipe, RecipeViewController>!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        recipeTimelineComponent = TimelineComponent(target: self)
        self.navigationController?.delegate = self
        
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        recipeTimelineComponent.loadInitialIfRequired()
        
        
    }
    
//    override func viewWillAppear(animated: Bool)
//    {
//        super.viewWillAppear(animated)
////        recipeTimelineComponent.loadInitialIfRequired()
//        
//        
//    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // If the user selects the recipe from the timeline, the RecipeViewController selects the segue to ChosenRecipeViewController
        if(segue.identifier == recipeSegueIdentifier)
        {
            let destViewController = segue.destinationViewController as! ChosenRecipeViewController
            destViewController.recipe = self.recipeTimelineComponent.content[selected]
        }
        
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue)
    {
        println("hello other segue")
    }
    
    

    // MARK: TimelineComponentTarget implementation
    func loadInRange(range: Range<Int>, completionBlock: ([Recipe]?) -> Void)
    {
        ParseHelper.timelineRequestforCurrentUser(range)
        {
            (result: [AnyObject]?, error: NSError?) -> Void in
            if let error = error
            {
                ErrorHandling.defaultErrorHandler(error)
            }

//            println(result?.description)
            let recipes = result as? [Recipe] ?? []
            completionBlock(recipes)
        }
    }
    
    // MARK: UIActionSheets
    func showActionSheetForRecipe(recipe: Recipe)
    {
        if (recipe.user == PFUser.currentUser())
        {
            showDeleteActionSheetForRecipe(recipe)
        }
        else
        {
            showFlagActionSheetForRecipe(recipe)
        }
    }
    
    func showDeleteActionSheetForRecipe(recipe: Recipe)
    {
        let alertController = UIAlertController(title: nil, message: "Do you want to delete this recipe?", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Delete", style: .Destructive)
        {
            (action) in
            recipe.deleteInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                if (success) {
                    self.recipeTimelineComponent.removeObject(recipe)
                } else {
                    // restore old state
                    self.recipeTimelineComponent.refresh(self)
                }
            })
        }
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showFlagActionSheetForRecipe(recipe: Recipe)
    {
        let alertController = UIAlertController(title: nil, message: "Do you want to flag this recipe?", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Flag", style: .Destructive) { (action) in
            recipe.flagRecipe(PFUser.currentUser()!)
        }
        
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}


// MARK: TableViewDataSource
extension RecipeViewController: UITableViewDataSource
{
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int
//    {
//        return self.recipeTimelineComponent.content.count
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.recipeTimelineComponent.content.count == 0
        {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            messageLabel.text = "You don't have any recipes! Create one!"
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .Center
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel
        }
        else
        {
            self.tableView.backgroundView = nil
        }
        return self.recipeTimelineComponent.content.count
        //self.recipeTimelineComponent.content[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell") as! RecipeTableViewCell
        
        let recipe = recipeTimelineComponent.content[indexPath.row]
        recipe.downloadImage()
        cell.recipe = recipe
//        cell.timeline = self
        
        return cell
    }
    
}


// MARK: Table View Delegate
extension RecipeViewController: UITableViewDelegate
{
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        recipeTimelineComponent.targetWillDisplayEntry(indexPath.row)

    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selected = indexPath.row
        performSegueWithIdentifier(recipeSegueIdentifier, sender: nil)
    }
    
}

// MARK: Style

extension RecipeViewController
{
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
    }
}

