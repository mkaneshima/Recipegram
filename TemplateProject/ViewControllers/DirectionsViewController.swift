//
//  DirectionsViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class DirectionsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate
{
    var direction: Direction = Direction()

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
                self.direction.directionsImages = imageFile
                self.directionsImageView?.image = image!
                self.direction["directionsImages"] = imageFile
                
        }
 
    }
    
    // Done button
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func doneButtonPressed(sender: AnyObject)
    {
        direction.directionsText = self.directionsTextField.text
        let directionsImageData = UIImageJPEGRepresentation(directionsImageView.image, 0.8)
        let directionsImageFile = PFFile(data: directionsImageData)
        direction.directionsImages = directionsImageFile
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
    

}
