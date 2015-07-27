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

    // PhotoTakingHelper
    var photoTakingHelper: PhotoTakingHelper?
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBAction func cameraButtonPressed(sender: AnyObject)
    {
        println("Hello!")
    }
    
    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var newServingsTextField: UITextField!
    @IBOutlet weak var newPrepTimeTextField: UITextField!
    
    @IBOutlet weak var newCookTimeTextField: UITextField!
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//    }
    

}
