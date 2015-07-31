//
//  PhotoTakingHelper.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/18/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

typealias PhotoTakingHelperCallback = UIImage? -> Void

class PhotoTakingHelper : NSObject
{
    /** View controller on which AlertViewController and UIImagePickerController are presented */
    weak var viewController: UIViewController!
    var callback: PhotoTakingHelperCallback
    var imagePickerController: UIImagePickerController?
    
    init(viewController: UIViewController, callback: PhotoTakingHelperCallback)
    {
        self.viewController = viewController
        self.callback = callback
        
        super.init()
        
        showPhotoSourceSelection()
    }
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType)
    {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
    
    func showPhotoSourceSelection()
    {
        // Allow user to choose between photo library and camera
        let alertController = UIAlertController(title: nil, message: "Uploading a photo by:", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Only show camera option if rear camera is available
        if (UIImagePickerController.isCameraDeviceAvailable(.Rear))
        {
            let cameraAction = UIAlertAction(title: "Camera", style: .Default)
            {
                (action) in self.showImagePickerController(.Camera)
            }
            
            alertController.addAction(cameraAction)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Library", style: .Default)
        {
            (action) in self.showImagePickerController(.PhotoLibrary)
        }
        
        alertController.addAction(photoLibraryAction)
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

extension PhotoTakingHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate
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

//extension PhotoTakingHelper: FilterViewControllerDelegate
//{
//    func filterViewController(controller: FilterViewController, selectedImage: UIImage)
//    {
//        successCallback(selectedImage)
//        // pop all view controllers
//        viewController.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func filterViewControllerCancelled(controller: FilterViewController)
//    {
//        popModalViewController()
//    }
//}
