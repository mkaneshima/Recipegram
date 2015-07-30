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
    
    @IBOutlet weak var cameraButton: UIButton!
    
    
    @IBAction func cameraButtonPressed(sender: AnyObject)
    {
        photoTakingHelper = PhotoTakingHelper(viewController: self)
        {
                (image: UIImage?) in
            
                let imageData = UIImageJPEGRepresentation(image, 0.8)
                let imageFile = PFFile(data: imageData)
                self.direction.directionsImage = imageFile
                self.directionsImageView?.image = image!
                self.direction["directionsImages"] = imageFile
//                self.direction
            
        }
 
    }
    
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonPressed(sender: AnyObject)
    {
//        var direction = Direction(directionsText: <#String#>, directionsImage: <#UIImage#>)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
