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
    let recipe = Recipe()
    
    var ingredientsArray: [String] = []
    var directionsArray: [Direction] = []
//    var directionsImagesArray: [UIImage] = []
//    var directionsBond:Bond<String>!
//    var imagesBond: Bond<UIImage>!
    var levels = ["Easy", "Intermediate", "Hard"]
    var selectedLevel: String = ""
    
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
        //scrollView.contentSize = CGSizeMake(600, 3000)
        levelPickerView.delegate = self
        levelPickerView.dataSource = self
        
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
    
    // MARK: Table View Delegate
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return Int(directionsArray.count ?? 0) // Create 1 row as an example
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("DirectionsCell") as! DirectionsTableViewCell
        
        let directions = directionsArray[indexPath.row]
        cell.directionsTextView.text = directions.directionsText
        
        if let directionsImage = directions.valueForKey("directionsImages") as? PFFile
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
            
        
        }
//        cell.directionsImageView.image = directions.directionsImage
        
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
                let imageData = UIImageJPEGRepresentation(image, 0.8)
                let imageFile = PFFile(data: imageData)
                self.recipe["imageFile"] = imageFile
                self.recipe.save()
            
                self.ingredientsImageView?.image = image!

        }
    
       
    }
    
    
    @IBOutlet weak var postRecipeButton: UIButton!
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue)
    {
        if(segue.identifier == "postRecipeSegue")
        {
            let destViewController = segue.sourceViewController as! RecipeViewController
            
            recipe.recipeTitles = self.titleTextField.text
            recipe.servings = self.newServingsTextField.text
            recipe.prepTimes = self.newPrepTimeTextField.text
            recipe.cookTimes = self.newCookTimeTextField.text
            recipe.skillLevel = levels[levelPickerView.selectedRowInComponent(0)]
            
            let ingredientsImageData = UIImageJPEGRepresentation(ingredientsImageView.image, 0.8)
            let ingredientsImageFile = PFFile(data: ingredientsImageData)
            recipe.ingredientsImages = ingredientsImageFile

            recipe.ingredients = self.ingredientsTextView.text
            recipe.directions = self.directionsArray
            
            recipe.uploadRecipe()
        }
    
    }
    
    
}

//extension NewRecipeViewController: UITableViewDataSource
//{
//    
//}
