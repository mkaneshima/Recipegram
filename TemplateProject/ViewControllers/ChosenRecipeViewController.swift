//
//  ChosenRecipeViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class ChosenRecipeViewController: UIViewController
{
    
    @IBOutlet weak var chosenImageView: UIImageView!
    {
        didSet
        {
            if recipe != nil
            {
                chosenImageView.image = recipe?.image.value
            }
        }
    }
    var recipe: Recipe?
        {
        didSet
        {
            if recipe != nil && chosenImageView != nil
            {
                chosenImageView.image = recipe?.image.value
            }
        }
    }

    
    @IBOutlet weak var recipeTitleLabel: UILabel!
        {
        didSet
        {
            if recipe != nil
            {
                //recipeTitleLabel.text = recipe?.title
            }
        }
    }

    
    
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var prepTimeLabel: UILabel!
    
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var ingredientsImageView: UIImageView!
    
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    
    
    
    
    
    
    
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    

}

