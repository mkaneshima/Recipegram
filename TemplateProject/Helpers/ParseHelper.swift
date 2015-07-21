//
//  ParseHelper.swift
//  TemplateProject
//
//  Created by Mari Kaneshima on 7/18/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Foundation
import Parse


class ParseHelper
{
    // Following Relation
    static let ParseFollowClass       = "Follow"
    static let ParseFollowFromUser    = "fromUser"
    static let ParseFollowToUser      = "toUser"
    
    // Like Relation
    static let ParseLikeClass         = "Like"
    static let ParseLikeToRecipe        = "toRecipe"
    static let ParseLikeFromUser      = "fromUser"
    
    // Recipe Relation
    static let ParseRecipeUser          = "user"
    static let ParseRecipeCreatedAt     = "createdAt"
    
    // Flagged Content Relation
    static let ParseFlaggedContentClass    = "FlaggedContent"
    static let ParseFlaggedContentFromUser = "fromUser"
    static let ParseFlaggedContentToRecipe   = "toRecipe"
    
    // User Relation
    static let ParseUserUsername = "username"
    
    // MARK: Recipe Timeline
    static func timelineRequestforCurrentUser(range: Range<Int>, completionBlock: PFArrayResultBlock)
    {
        let followingQuery = PFQuery(className: ParseFollowClass)
        followingQuery.whereKey(ParseLikeFromUser, equalTo:PFUser.currentUser()!)
        
        let recipesFromFollowedUsers = Recipe.query()
        recipesFromFollowedUsers!.whereKey(ParseRecipeUser, matchesKey: ParseFollowToUser, inQuery: followingQuery)
        
        let recipesFromThisUser = Recipe.query()
        recipesFromThisUser!.whereKey(ParseRecipeUser, equalTo: PFUser.currentUser()!)
        
        let query = PFQuery.orQueryWithSubqueries([recipesFromFollowedUsers!, recipesFromThisUser!])
        query.includeKey(ParseRecipeUser)
        query.orderByDescending(ParseRecipeCreatedAt)
        
        query.skip = range.startIndex
        query.limit = range.endIndex - range.startIndex
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    // MARK: Likes
    static func likeRecipe(user: PFUser, recipe: Recipe)
    {
        let likeObject = PFObject(className: ParseLikeClass)
        likeObject[ParseLikeFromUser] = user
        likeObject[ParseLikeToRecipe] = recipe
        
        likeObject.saveInBackgroundWithBlock(nil)
    }
    
    static func unlikeRecipe(user: PFUser, recipe: Recipe)
    {
        let query = PFQuery(className: ParseLikeClass)
        query.whereKey(ParseLikeFromUser, equalTo: user)
        query.whereKey(ParseLikeToRecipe, equalTo: recipe)
        
        query.findObjectsInBackgroundWithBlock
        {
            (results: [AnyObject]?, error: NSError?) -> Void in
            if let error = error
            {
                ErrorHandling.defaultErrorHandler(error)
            }
            
            if let results = results as? [PFObject]
            {
                for likes in results
                {
                    likes.deleteInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
                }
            }
        }
    }
    
    static func likesForRecipe(recipe: Recipe, completionBlock: PFArrayResultBlock)
    {
        let query = PFQuery(className: ParseLikeClass)
        query.whereKey(ParseLikeToRecipe, equalTo: recipe)
        query.includeKey(ParseLikeFromUser)
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
}
extension PFObject : Equatable
{
    
}

public func ==(lhs: PFObject, rhs: PFObject) -> Bool
{
    return lhs.objectId == rhs.objectId
}

