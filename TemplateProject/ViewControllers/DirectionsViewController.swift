//
//  DirectionsViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit

class DirectionsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate
{
    var selectedImage: UIImage?
    
    // PhotoTakingHelper
    var photoTakingHelper: PhotoTakingHelper?
    
    // Photo Upload Task
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    // Directions textfield and image
    @IBOutlet weak var directionsTextField: UITextField!
    @IBOutlet weak var directionsImageView: UIImageView!
    
    // First camera button
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBAction func cameraButtonPressed(sender: AnyObject)
    {
        photoTakingHelper = PhotoTakingHelper(viewController: self)
        {
                (image: UIImage?) in
            
                let imageData = UIImageJPEGRepresentation(image, 0.8)
                let imageFile = PFFile(data: imageData)
//                self.direction.directionsImages = imageFile
                self.selectedImage = image
                self.directionsImageView?.image = image!
//                self.direction["directionsImages"] = imageFile
            
        }
 
    }
    
    // MARK: viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: didReceiveMemoryWarning
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Done button
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
     {
  
//        let destViewController = segue.destinationViewController as! NewRecipeViewController
//        var test = destViewController.recipe["directionsImages"] as! [UIImage]
//        println(test.description)
//        test.append(selectedImage!)
//        destViewController.recipe["directionsImages"] = [selectedImage!]
//        destViewController.recipe.directionsText.append(directionsTextField.text)
      
    }
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func doneButtonPressed(sender: AnyObject)
    {
         println("hello there!")
//            direction.directionsText = self.directionsTextField.text
//            println(self.directionsTextField.text)
//            println(direction.directionsText)
//            let directionsImageData = UIImageJPEGRepresentation(directionsImageView.image, 0.8)
//            let directionsImageFile = PFFile(data: directionsImageData)
//            direction.directionsImages = directionsImageFile
    
//            performSegueWithIdentifier("selectDoneButtonSegue", sender: nil)
        
    }
    
    //    @IBAction func selectDoneButtonPressed(sender: AnyObject)
    //    {
    //        println("hello")
    //        let destViewController = sender.destinationViewController as! NewRecipeViewController
    //        destViewController.recipe.directionsImages.append(selectedImage!)
    //        destViewController.recipe.directionsText.append(directionsTextField.text)
    //        performSegueWithIdentifier("selectDoneButtonSegue", sender: self)
    //        
    //
    //    }


}


extension DirectionsViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if (textField == directionsTextField)
        {
            directionsImageView.becomeFirstResponder()
            directionsImageView.designatedBond
        }
        
        return false
    }
}
