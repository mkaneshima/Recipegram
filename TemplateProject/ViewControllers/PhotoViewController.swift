//
//  PhotoViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/18/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import Bond

class PhotoViewController: UIViewController
{
    /* This ViewController is not actually used, it's a dummy that exists to enable
    taking photos upon tab bar button press */
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        // the following line ensures that the camera icon is rendered white instead of the typical gray of a deactivated tab bar item
        self.tabBarItem.image = UIImage(named: "Camera")?.imageWithRenderingMode(.AlwaysOriginal)
    }


}

