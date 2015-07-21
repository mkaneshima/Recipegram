//
//  PhotoViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/18/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import Bond

class PhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource
{
    // MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBAction func uploadButton(sender: AnyObject)
    {
        
    }
    
    let recipe = Recipe()

    // MARK: Arrays for ingredients and directions
    var ingredientsArray: [String] = []
    var ingredientsBond: Bond<String>!
    var directionsArray: [String] = []
    var directionsBond: Bond<String>!
    
    
    // MARK: PhotoTakingHelper
    var photoTakingHelper: PhotoTakingHelper?
    
    // MARK: Button Actions
    
    // Back Button
    @IBAction func backButton(sender: AnyObject)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let recipeViewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        self.dismissViewControllerAnimated(false, completion: nil)
        self.presentViewController(recipeViewController, animated: true, completion: nil)
    }

    // Share Button
    @IBAction func shareButtonPressed(sender: AnyObject)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let recipeViewController = storyboard.instantiateViewControllerWithIdentifier("RecipeViewController") as! RecipeViewController
        
        
        self.dismissViewControllerAnimated(false, completion: nil)
        self.presentViewController(recipeViewController, animated: true, completion: nil)
    }
    
    // Camera Button
    @IBAction func cameraButtonPressed(sender: AnyObject)
    {
        photoTakingHelper = PhotoTakingHelper(viewController: self)
        {
            (image: UIImage?) in
            self.recipe.image.value = image!
            self.imageView?.image = image!
            
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            let imageFile = PFFile(data: imageData)
            
            self.recipe["imageFile"] = imageFile
            self.recipe.save()
        }
        
    }
    
    // MARK: TableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == ingredientsTableView
        {
            return self.ingredientsArray.count
        }
        else
        {
            return 1
        }
        
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if tableView == ingredientsTableView
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("IngredientsCell") as! IngredientsTableViewCell
//            cell.ingredient.map {$0} ->> ingredientsBond
//            cell.configure(text: "", placeholder: "Example: 1 cup of water.")
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("DirectionsCell") as! DirectionsTableViewCell
//            cell.direction.map {$0} ->> directionsBond
//            cell.configure(text: "", placeholder: "Example: Preheat the oven to 350 degrees Celsius.")
            return cell
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        ingredientsBond = Bond<String>()
//        {
//            ingredient in
//            var contains = contains(self.ingredientsArray, ingredient)
//            
//            if contains == false && ingredient != ""
//            {
//                self.ingredientsArray.append(ingredient)
//            }
//        }
//        
//        directionsBond = Bond<String>()
//        {
//            direction in
//            var contains = contains(self.directionsArray, direction)
//            
//            if contains == false && ingredient != ""
//            {
//                self.directionsArray.append(direction)
//            }
//
//        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createRecipe()
    {
//        recipe.RecipeTitle = titleTextField.text
//        recipe.Ingredients = self.ingredientsArray
//        recipe.Directions = self.directionsArray
        
        recipe.uploadRecipe()
    }
    
    /* This ViewController is not actually used, it's a dummy that exists to enable
    taking photos upon tab bar button press */
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        // the following line ensures that the camera icon is rendered white instead of the typical gray of a deactivated tab bar item
        self.tabBarItem.image = UIImage(named: "Camera")?.imageWithRenderingMode(.AlwaysOriginal)
    }

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

