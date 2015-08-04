//
//  NewRecipeViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/21/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import Bond


class NewRecipeViewController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    //    var directionsImagesArray: [UIImage] = []
    //    var directionsBond:Bond<String>!
    //    var imagesBond: Bond<UIImage>!    let recipe = Recipe()
    
    var ingredientsArray: [String] = [""]
    
    // Directions arrays for images and text
//    var directionsTextArray: [String] = []
//    var directionsImagesArray: [UIImage] = []
    
    // Pickerview values
    var levels = ["Easy", "Intermediate", "Hard"]
    var selectedLevel: String = ""
    
    let recipe = Recipe()
    
    // MARK: DirectionsTableView
    @IBOutlet weak var directionsTableView: UITableView!
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        levelPickerView.delegate = self
        levelPickerView.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        directionsTableView.reloadData()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "AddDirectionsSegue")
        {
            let directionsViewController = segue.destinationViewController as! DirectionsViewController
        }
        
    }
    
    // MARK: Table View Delegate for DirectionsTableView
    
    // Number of rows in section
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
//        return Int(recipe.directionsText.count ?? 0) // Create 1 row as an example
        return 3
    }
    
    // Cell for Row at Index Path
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("DirectionsCell") as! DirectionsTableViewCell
        cell.directionsTextView.text = "asfhsef"
         
        
        /*let directionsText = recipe.directionsText[indexPath.row]
        
        let directionsPhoto = recipe.directionsImages[indexPath.row] // Array index out of range
        
        cell.directionsTextView.text = directionsText
        
        // Directions photo
        if let directionsImage = directionsPhoto.valueForKey("directionsImages") as? PFFile
        {
            directionsImage.getDataInBackgroundWithBlock(
            {
                (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil)
                {
                    let image = UIImage(data:imageData!)
                    cell.directionsImageView.image = image
                }
            })
        
        }*/
        return cell
    }
    
        
    
    // MARK: UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return levels.count
    }
    
    // MARK: UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return levels[row]
    }
    
    
    // Scrollview
    @IBOutlet weak var scrollView: UIScrollView!

    // PhotoTakingHelper
    var photoTakingHelper: PhotoTakingHelper?
    
    // Dish image
    @IBOutlet weak var dishImageView: UIImageView!
    
    
    // Camera button
    @IBOutlet weak var cameraButton: UIButton!
    
    // Ingredients camera button
    @IBOutlet weak var secondCameraButton: UIButton!
    
    
    // Textfields for titles, servings, prep and cook times
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var newServingsTextField: UITextField!
    @IBOutlet weak var newPrepTimeTextField: UITextField!
    @IBOutlet weak var newCookTimeTextField: UITextField!
    
    // Skill level pickerview
    @IBOutlet weak var levelPickerView: UIPickerView!
    
    // Upload photo of ingredients
    @IBOutlet weak var ingredientsImageView: UIImageView!
    
   
    // Type in the ingredients in the textview
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    // Camera button pressed
    @IBAction func cameraButtonPressed(sender: AnyObject)
    {
        photoTakingHelper = PhotoTakingHelper(viewController: self)
        {
            (image: UIImage?) in
            
                self.recipe.image.value = image!
                self.dishImageView?.image = image!
//                let imageData = UIImageJPEGRepresentation(image, 0.8)
//                let imageFile = PFFile(data: imageData)
//                self.recipe["imageFile"] = imageFile
//                self.recipe.save()

        }

    }
    
    // Second camera button pressed in Ingredients imageview
    @IBAction func secondCameraButtonPressed(sender: AnyObject)
    {
        photoTakingHelper = PhotoTakingHelper(viewController: self)
        {
            (image: UIImage?) in
            
            self.recipe.image.value = image!
            self.ingredientsImageView?.image = image!
            let ingredientsImageData = UIImageJPEGRepresentation(image, 0.8)
            let ingredientsImageFile = PFFile(data: ingredientsImageData)
            self.recipe["ingredientsImages"] = ingredientsImageFile
            

        }

    }
    
    // Post My Recipe button
    @IBOutlet weak var postRecipeButton: UIButton!
    
    @IBAction func postRecipe(sender: UIButton)
    {
        recipe.recipeTitles = self.titleTextField.text
        recipe.servings = self.newServingsTextField.text
        recipe.prepTimes = self.newPrepTimeTextField.text
        recipe.cookTimes = self.newCookTimeTextField.text
        recipe.skillLevel = levels[levelPickerView.selectedRowInComponent(0)]
        
        recipe.ingredients = self.ingredientsTextView.text
        
//        recipe.directionsImages = self.
//        recipe.directionsText = self.directionsTextArray
        
        recipe.uploadRecipe()
        
        performSegueWithIdentifier("postRecipeSegue", sender: nil)
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue)
    {
        if(segue.identifier == "postRecipeSegue")
        {
            let destViewController = segue.destinationViewController as! RecipeViewController
            
//            recipe.recipeTitles = self.titleTextField.text
//            recipe.servings = self.newServingsTextField.text
//            recipe.prepTimes = self.newPrepTimeTextField.text
//            recipe.cookTimes = self.newCookTimeTextField.text
//            recipe.skillLevel = levels[levelPickerView.selectedRowInComponent(0)]
//            
//            let ingredientsImageData = UIImageJPEGRepresentation(ingredientsImageView.image, 0.8)
//            let ingredientsImageFile = PFFile(data: ingredientsImageData)
//            recipe.ingredientsImages = ingredientsImageFile
//
//            recipe.ingredients = self.ingredientsTextView.text
////            recipe.directions = self.directionsArray
//            recipe.directionsImages = self.directionsImagesArray
//            recipe.directionsText = self.directionsTextArray
            
//            recipe.uploadRecipe()
        }
    
    }
    
    
}

//extension NewRecipeViewController: UITableViewDataSource
//{
//    
//}
