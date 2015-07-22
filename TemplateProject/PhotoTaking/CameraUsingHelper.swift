//
//  CameraUsing.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import MobileCoreServices

typealias CameraUsingHelperCallback = UIImage? -> Void

class CameraUsingHelper: NSObject
{
    weak var viewController: UIViewController!
    var callback: CameraUsingHelperCallback
    var imagePickerController: UIImagePickerController?
    var newMedia: Bool?
    
    init(viewController: UIViewController, callback: CameraUsingHelperCallback)
    {
        self.viewController = viewController
        self.callback = callback
        
        super.init()
        
        showCamera()
    }
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType)
    {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
    
    func showCamera()
    {
        // Only show camera option if rear camera is available
        if (UIImagePickerController.isCameraDeviceAvailable(.Rear))
        {
            let cameraAction = UIAlertAction(title: "Camera", style: .Default)
            {
                    (action) in self.showImagePickerController(.Camera)
            }
            
//            alertController.addAction(cameraAction)
        }

    }

}
extension CameraUsingHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        viewController.dismissViewControllerAnimated(false, completion: nil)
        callback(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

