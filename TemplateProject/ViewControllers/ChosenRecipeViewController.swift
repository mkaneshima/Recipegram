//
//  ChosenRecipeViewController.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class ChosenRecipeViewController: UIViewController, UIPageViewControllerDelegate
{
    
//    var ingredientsArray: [String]?
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    
   
    @IBOutlet weak var pageControl: UIPageControl!
    
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
        // Do any additional setup after loading the view.
        
//        pageImages = [UIImage(coder: self)]
//        
//        let pageCount = pageImages.count
//        
//        // 2
//        pageControl.currentPage = 0
//        pageControl.numberOfPages = pageCount
//        
//        // 3
//        for _ in 0..<pageCount {
//            pageViews.append(nil)
//        }
//        
//        // 4
//        let pagesScrollViewSize = scrollView.frame.size
//        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
//        
//        // 5
//        loadVisiblePages()

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

//extension ChosenRecipeViewController: UIPageViewControllerDataSource
//{
//    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
//    {
//        var vc = viewController as! ContentViewController
//        var index = vc.pageIndex as Int
//    }
//}
