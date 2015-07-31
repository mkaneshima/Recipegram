//
//  Recipe.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/18/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import Bond
import ConvenienceKit

class Recipe: PFObject, PFSubclassing
{
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    @NSManaged var recipeTitles: String?
    @NSManaged var servings:NSNumber?
    @NSManaged var prepTimes: String?
    @NSManaged var cookTimes: String?
    @NSManaged var skillLevel: String?
    @NSManaged var ingredientsImages: PFFile?
    @NSManaged var ingredients: String?
    @NSManaged var directions: NSArray?
//    @NSManaged var directionsImages: PFFile?
//    @NSManaged var directionsText: String?
    
    var image: Dynamic<UIImage?> = Dynamic(nil)
    
    var photoUploadTask: UIBackgroundTaskIdentifier?
    static var imageCache: NSCacheSwift<String, UIImage>!
    
    var title: Dynamic<String?> = Dynamic(nil)

    //MARK: PFSubclassing Protocol
    static func parseClassName() -> String
    {
        return "Recipe"
    }
    
    override init ()
    {
        super.init()
    }
    
    override class func initialize()
    {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken)
        {
            // inform Parse about this subclass
            self.registerSubclass()
            Recipe.imageCache = NSCacheSwift<String, UIImage>()
        }
    }
    // MARK: Parse logic
    func uploadRecipe()
    {
        let imageData = UIImageJPEGRepresentation(image.value, 0.8)
        let imageFile = PFFile(data: imageData)
        
        // any uploaded post should be associated with the current user
        self.user = PFUser.currentUser()
        self.imageFile = imageFile
        
        
        photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler
        {
            () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        
        saveInBackgroundWithBlock
        {
            (success: Bool, error: NSError?) -> Void in
                if let error = error
                {
                    ErrorHandling.defaultErrorHandler(error)
                }
        }

    }
    
    // MARK: Downloads the Chosen Recipe Image
    func downloadImage()
    {
        image.value = Recipe.imageCache[self.imageFile!.name]
        
        // if image is not downloaded yet, get it
        if (image.value == nil)
        {
            imageFile?.getDataInBackgroundWithBlock
            {
                (data: NSData?, error: NSError?) -> Void in
                if let error = error
                {
                    ErrorHandling.defaultErrorHandler(error)
                }
                
                if let data = data
                {
                    let image = UIImage(data: data, scale:1.0)!
                    self.image.value = image
                    Recipe.imageCache[self.imageFile!.name] = image
                }
            }
        }
    }
    
//    func fetchLikes()
//    {
//        if (likes.value != nil)
//        {
//            return
//        }
//        ParseHelper.likesForRecipe(self, completionBlock:
//        {
//            (var likes: [AnyObject]?, error: NSError?) -> Void in
//            if let error = error
//            {
//                ErrorHandling.defaultErrorHandler(error)
//            }
//
//            likes = likes?.filter
//            {
//                like in like[ParseHelper.ParseLikeFromUser] != nil
//            }
//            
//            // 4
//            self.likes.value = likes?.map
//            {
//                like in
//                let like = like as! PFObject
//                let fromUser = like[ParseHelper.ParseLikeFromUser] as! PFUser
//                
//                return fromUser
//            }
//        })
//    }
//    
//    // MARK: Likes
//    func doesUserLikeRecipe(user: PFUser) -> Bool
//    {
//        if let likes = likes.value
//        {
//            return contains(likes, user)
//        }
//        else
//        {
//            return false
//        }
//    }
//    
//    func toggleLikeRecipe(user: PFUser)
//    {
//        if (doesUserLikeRecipe(user))
//        {
//            // if image is liked, unlike it now
//            likes.value = likes.value?.filter
//            {
//                $0 != user
//            }
//            
//            ParseHelper.unlikeRecipe(user, recipe: self)
//        }
//        else
//        {
//            // if this image is not liked yet, like it now
//            likes.value?.append(user)
//            ParseHelper.likeRecipe(user, recipe: self)
//        }
//    }
    
    //MARK: Flagging
//    
//    func flagPost(user: PFUser)
//    {
//        ParseHelper.flagRecipe(user, recipe: self)
//    }
//
    
}
