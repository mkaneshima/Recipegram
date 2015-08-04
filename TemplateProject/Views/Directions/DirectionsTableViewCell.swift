//
//  DirectionsTableViewCell.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/20/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

typealias photoTakingHelperCallBack = UIImage? -> Void

class DirectionsTableViewCell: UITableViewCell
{
    // MARK: Directions TextView
    @IBOutlet weak var directionsTextView: UITextView!
    
    // MARK: Directions ImageView
    @IBOutlet weak var directionsImageView: UIImageView!
    
    // MARK: Directions Camera button
    @IBOutlet weak var directionsCameraButton: UIButton!
    
    // MARK: PhotoTakingHelper
    var photoTakingHelper: PhotoTakingHelper?
//    var directions: [String]?
    
//    var directionImage: UIImage?
//    var directionText: String = ""
    let directionViewController = DirectionsViewController()
    
    
    @IBAction func directionsCameraButtonPressed(sender: AnyObject)
    {
//        photoTakingHelper = PhotoTakingHelper(viewController: directionViewController, callback: self.photoTakingHelperCallBack)
//        {
//            
//        }
        
    }
    
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
    
    
    
}
