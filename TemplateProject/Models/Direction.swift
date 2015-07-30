//
//  Direction.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/29/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import Bond

class Direction: PFObject, PFSubclassing
{
    @NSManaged var directionsText: String?
    @NSManaged var directionsImage: PFFile
    var image: Dynamic<UIImage?> = Dynamic(nil)
    
    //MARK: PFSubclassing Protocol
    static func parseClassName() -> String
    {
        return "Direction"
    }
    
    override init ()
    {
        super.init()
//        self.directionsText = directionsText
//        self.directionsImage = directionsImage
    }
    
    override class func initialize()
    {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken)
        {
                // inform Parse about this subclass
                self.registerSubclass()
//                Direction.imageCache = NSCacheSwift<String, UIImage>()
        }
    }

}
