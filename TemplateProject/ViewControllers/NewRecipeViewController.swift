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

class NewRecipeViewController: UIViewController
{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextField: UITextField!
    
    // PhotoTakingHelper
    var photoTakingHelper: PhotoTakingHelper?
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad()
    {
        // The onCustomTap: method will be defined in Step 3 below.
//        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onCustomTap:")
//        
//        // Optionally set the number of required taps, e.g., 2 for a double click
//        tapGestureRecognizer.numberOfTapsRequired = 2;
//        
//        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
//        view.userInteractionEnabled = true
//        view.addGestureRecognizer(tapGestureRecognizer)
    }
//    func onCustomTap(tapGestureRecognizer: UITapGestureRecognizer)
//    {
//        var point = tapGestureRecognizer.locationInView(view)
//        
//        // User tapped at the point above. Do something with that if you want.
//    }
    
//    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer!, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer!) -> Bool {
//        return true
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
