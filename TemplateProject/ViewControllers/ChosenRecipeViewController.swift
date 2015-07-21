//
//  ChosenRecipeViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class ChosenRecipeViewController: UIViewController, UIScrollViewDelegate
{
        
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
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
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollView.contentSize.height = 3000
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
