//
//  DirectionsTableViewCell.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/20/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import Mixpanel

typealias photoTakingHelperCallBack = UIImage? -> Void

class DirectionsTableViewCell: UITableViewCell
{
    // MARK: Directions TextView
    @IBOutlet weak var directionsTextView: UITextView!
    
    // MARK: Directions ImageView
    @IBOutlet weak var directionsImageView: UIImageView!
    
    let directionViewController = DirectionsViewController()
    
    // MARK: How to save the directions content (text and image objects) from NewRecipeViewController and update them in DirectionsTableViewCell
    func saveDirection()
    {
        if let directionsTextView = directionsTextView, directionsImageView = directionsImageView
        {
            if(directionsImageView.image != self.directionViewController.directionsImageView.image || directionsTextView.text != self.directionsTextView.text)
            {
                self.directionViewController.directionsTextField.text = directionsTextView.text
                self.directionViewController.directionsImageView.image = directionsImageView.image
            }
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    

    
    
    // MARK: PhotoTakingHelper
//    var photoTakingHelper: PhotoTakingHelper?
//    var directions: [String]?
    
//    var directionImage: UIImage?
//    var directionText: String = ""
    
}
