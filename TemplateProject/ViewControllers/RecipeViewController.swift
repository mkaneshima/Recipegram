//
//  RecipeViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/18/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit

class RecipeViewController: UIViewController, TimelineComponentTarget
{
    @IBOutlet weak var tableView: UITableView!
    
    var selected: Int!
    
    // Segue Identifier
    let recipeSegueIdentifier = "ShowRecipeSegue"
    
    // PhotoTakingHelper
    var photoTakingHelper: PhotoTakingHelper?
    
    // Timeline Component Protocol
    let defaultRange = 0...4
    let additionalRangeSize = 5
    var recipeTimelineComponent: TimelineComponent<Recipe, RecipeViewController>!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        recipeTimelineComponent = TimelineComponent(target: self)
        self.tabBarController?.delegate = self
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        recipeTimelineComponent.loadInitialIfRequired()
        
    }
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
        if(segue.identifier == recipeSegueIdentifier)
        {
            let destViewController = segue.destinationViewController as! ChosenRecipeViewController
            destViewController.recipe = self.recipeTimelineComponent.content[selected]
        }
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

            let recipes = result as? [Recipe] ?? []
            completionBlock(recipes)
        }
    }
    
    // MARK: View callbacks
    func takePhoto()
    {
        // instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper =
            PhotoTakingHelper(viewController: self.tabBarController!)
        {
            (image: UIImage?) in
            let recipe = Recipe()
            recipe.image.value = image!
            recipe.uploadRecipe()
        }
    }
   
}

// MARK: Tab Bar Delegate
extension RecipeViewController: UITabBarControllerDelegate
{
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool
    {
        if (viewController is PhotoViewController)
        {
            takePhoto()
            return false
        }
        else
        {
            return true
        }
    }
}

// MARK: TableViewDataSource
extension RecipeViewController: UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return self.recipeTimelineComponent.content.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell") as! RecipeTableViewCell
        
        // let recipe = recipeTimelineComponent.content[indexPath.row]
        let recipe = recipeTimelineComponent.content[indexPath.section]
        recipe.downloadImage()
        recipe.fetchLikes()
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
//        recipeTimelineComponent.targetWillDisplayEntry(indexPath.row)
        recipeTimelineComponent.targetWillDisplayEntry(indexPath.section)

    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selected = indexPath.row
        performSegueWithIdentifier(recipeSegueIdentifier, sender: nil)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("RecipeHeader") as! RecipeSectionHeaderView
        
        let recipe = self.recipeTimelineComponent.content[section]
        headerCell.recipe = recipe
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40
    }
    
}

// MARK: Style

extension RecipeViewController
{
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

