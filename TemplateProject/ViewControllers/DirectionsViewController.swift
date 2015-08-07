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

class DirectionsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate
{
    var selectedImage: UIImage?
    
    // PhotoTakingHelper
    var photoTakingHelper: PhotoTakingHelper?
    
    // Photo Upload Task
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    // Scrollview
    @IBOutlet weak var scrollView: UIScrollView!
    
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

            self.selectedImage = image
            self.directionsImageView?.image = image!
            
            // self.direction.directionsImages = imageFile
            //self.direction["directionsImages"] = imageFile
            
        }
 
    }
    
    // MARK: viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        directionsTextField.delegate = self
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.scrollEnabled = false
        // Do any additional setup after loading the view.
    }
    
    // MARK: didReceiveMemoryWarning
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextField delegates
    func textFieldShouldEndEditing(textField: UITextField) -> Bool
    {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        directionsTextField.resignFirstResponder()
        return true
    }
    
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func doneButtonPressed(sender: AnyObject)
    {
//         println("hello there!")
        
        if(self.directionsTextField.text == "" || self.directionsImageView.image == nil)
        {
            let alertController = UIAlertController(title: "Hold on...", message: "Please include the text and/or photo to create a direction.", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            performSegueWithIdentifier("selectDoneButtonPressed", sender: self)
             println("hello there!")
        }
        
    }
    

}
