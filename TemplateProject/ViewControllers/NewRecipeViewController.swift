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

class NewRecipeViewController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate
{
    var ingredientsArray: [String] = [""]
    
    // Pickerview values
    var levels = ["Easy", "Intermediate", "Hard"]
    var selectedLevel: String = ""
    var textViewValue = "Enter your ingredients..."
    
    let recipe = Recipe()
    
    // MARK: Directions TableView
    @IBOutlet weak var directionsTableView: UITableView!
    
    // MARK: Initialization
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        recipe.directionsImages = []
    }
    
    // MARK: didReceiveMemoryWarning
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Adding dataSources and delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        levelPickerView.delegate = self
        levelPickerView.dataSource = self
        
        directionsTableView.dataSource = self
        directionsTableView.delegate = self
        
        titleTextField.delegate = self
        newServingsTextField.delegate = self
        newPrepTimeTextField.delegate = self
        newCookTimeTextField.delegate = self
        
        ingredientsTextView.delegate = self
        ingredientsTextView.editable = true
        if(ingredientsTextView.text == "")
        {
            textViewDidEndEditing(ingredientsTextView)
        }
        var tapDismiss = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapDismiss)
    }
    
    
    // MARK: Reloads direction table view data
    override func viewDidAppear(animated: Bool)
    {
        directionsTableView.reloadData()
    }
    
    // MARK: UITextField delegates
    func textFieldShouldEndEditing(textField: UITextField) -> Bool
    {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        titleTextField.resignFirstResponder()
        newServingsTextField.resignFirstResponder()
        newPrepTimeTextField.resignFirstResponder()
        newCookTimeTextField.resignFirstResponder()
        return true
    }
    
    // MARK: UITextView delegates
    func dismissKeyboard()
    {
        ingredientsTextView.resignFirstResponder()
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
        if (ingredientsTextView.text == "")
        {
            ingredientsTextView.text = textViewValue
            ingredientsTextView.textColor = UIColor.lightGrayColor()
        }
        
        ingredientsTextView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(textView: UITextView)
    {
        if(ingredientsTextView.text == textViewValue)
        {
            ingredientsTextView.text = ""
            ingredientsTextView.textColor = UIColor.blackColor()
        }
        ingredientsTextView.becomeFirstResponder()
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
        return recipe.directionsText.count
    }
    
    // Cell for Row at Index Path
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("DirectionsCell") as! DirectionsTableViewCell
        
        if recipe.directionsText.count > 0 
        {
            let directionsText = recipe.directionsText[indexPath.row]
            let directionsImage = recipe.directionsImages[indexPath.row]
            cell.directionsTextView.text = directionsText
            cell.directionsImageView.image = UIImage(data:directionsImage.getData()!)
            
        }
        else
        {
            cell.directionsTextView.text = ""
        }
        
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
            
            let ingredientsImageData = UIImageJPEGRepresentation(image, 0.8)
            let ingredientsImageFile = PFFile(data: ingredientsImageData)

            self.recipe.ingredientsImages = ingredientsImageFile
            self.ingredientsImageView?.image = image!
            
            
        }

    }
    
    // MARK: Post My Recipe button
    @IBOutlet weak var postRecipeButton: UIButton!
    
    @IBAction func postRecipe(sender: UIButton)
    {
       if(self.dishImageView.image == nil || self.ingredientsImageView.image == nil || self.titleTextField.text == "" || self.newServingsTextField.text == "" || self.newPrepTimeTextField.text == "" || self.newCookTimeTextField.text == "" || ingredientsTextView.text == textViewValue || self.recipe.directionsText.count == 0)
       {
            let alertController = UIAlertController(title: "Hold on...", message: "Please fill in the missing fields.", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
       }
        else
        {
            recipe.recipeTitles = self.titleTextField.text
            recipe.servings = self.newServingsTextField.text
            recipe.prepTimes = self.newPrepTimeTextField.text
            recipe.cookTimes = self.newCookTimeTextField.text
            recipe.skillLevel = levels[levelPickerView.selectedRowInComponent(0)]
            
            recipe.ingredients = self.ingredientsTextView.text
            
            recipe.uploadRecipe()
            performSegueWithIdentifier("postRecipeSegue", sender: self)

        }
    }
    
    
    
    
    // MARK: UnwindtoSegue Function
    @IBAction func unwindToSegue(segue: UIStoryboardSegue)
    {
        // "Post My Recipe" button pressed and goes back to reloads the RecipeViewController to reload the image
        if(segue.identifier == "postRecipeSegue")
        {
            let destViewController = segue.destinationViewController as! RecipeViewController
        }
        
        // Selecting the "Done" button
        if(segue.identifier == "selectDoneButtonPressed")
        {
            let sourceViewController = segue.sourceViewController as! DirectionsViewController
            recipe.directionsText.append(sourceViewController.directionsTextField.text)
            
            // Add/append the image in the imageview of the tableviewcell
            recipe.directionsImages.append(PFFile(data: UIImageJPEGRepresentation(sourceViewController.selectedImage!, 0.8)))
            
        }

    }
}




