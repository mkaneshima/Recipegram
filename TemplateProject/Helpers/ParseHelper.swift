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
//    // Following Relation
//    static let ParseFollowClass       = "Follow"
//    static let ParseFollowFromUser    = "fromUser"
//    static let ParseFollowToUser      = "toUser"
//    
//    // Like Relation
//    static let ParseLikeClass         = "Like"
//    static let ParseLikeToRecipe        = "toRecipe"
//    static let ParseLikeFromUser      = "fromUser"
    
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
//        let followingQuery = PFQuery(className: ParseFollowClass)
//        followingQuery.whereKey(ParseLikeFromUser, equalTo:PFUser.currentUser()!)
        
//        let recipesFromFollowedUsers = Recipe.query()
//        recipesFromFollowedUsers!.whereKey(ParseRecipeUser, matchesKey: ParseFollowToUser, inQuery: followingQuery)
        
        let recipesFromThisUser = Recipe.query()
        recipesFromThisUser!.whereKey(ParseRecipeUser, equalTo: PFUser.currentUser()!)
        
        
        
//        let query = PFQuery.orQueryWithSubqueries([recipesFromFollowedUsers!, recipesFromThisUser!])
//        query.includeKey(ParseRecipeUser)
//        query.orderByDescending(ParseRecipeCreatedAt)
//        
//        query.skip = range.startIndex
//        query.limit = range.endIndex - range.startIndex
//        
//        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        
    }
    
    // MARK: Likes
//    static func likeRecipe(user: PFUser, recipe: Recipe)
//    {
//        let likeObject = PFObject(className: ParseLikeClass)
//        likeObject[ParseLikeFromUser] = user
//        likeObject[ParseLikeToRecipe] = recipe
//        
//        likeObject.saveInBackgroundWithBlock(nil)
//    }
//    
//    static func unlikeRecipe(user: PFUser, recipe: Recipe)
//    {
//        let query = PFQuery(className: ParseLikeClass)
//        query.whereKey(ParseLikeFromUser, equalTo: user)
//        query.whereKey(ParseLikeToRecipe, equalTo: recipe)
//        
//        query.findObjectsInBackgroundWithBlock
//        {
//            (results: [AnyObject]?, error: NSError?) -> Void in
//            if let error = error
//            {
//                ErrorHandling.defaultErrorHandler(error)
//            }
//            
//            if let results = results as? [PFObject]
//            {
//                for likes in results
//                {
//                    likes.deleteInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
//                }
//            }
//        }
//    }
//    
//    static func likesForRecipe(recipe: Recipe, completionBlock: PFArrayResultBlock)
//    {
//        let query = PFQuery(className: ParseLikeClass)
//        query.whereKey(ParseLikeToRecipe, equalTo: recipe)
//        query.includeKey(ParseLikeFromUser)
//        
//        query.findObjectsInBackgroundWithBlock(completionBlock)
//    }
    
    // MARK: Flagging
    static func flagPost(user: PFUser, recipe: Recipe)
    {
        let flagObject = PFObject(className: ParseFlaggedContentClass)
        flagObject.setObject(user, forKey: ParseFlaggedContentFromUser)
        flagObject.setObject(recipe, forKey: ParseFlaggedContentToRecipe)
        
        let ACL = PFACL(user: PFUser.currentUser()!)
        ACL.setPublicReadAccess(true)
        flagObject.ACL = ACL
        
        //TODO: add error handling
        flagObject.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
    }
    
    // MARK: Following
    
    /**
    Fetches all users that the provided user is following.
    
    :param: user The user who's followees you want to retrive
    :param: completionBlock The completion block that is called when the query completes
    */
//    static func getFollowingUsersForUser(user: PFUser, completionBlock: PFArrayResultBlock)
//    {
//        let query = PFQuery(className: ParseFollowClass)
//        
//        query.whereKey(ParseFollowFromUser, equalTo:user)
//        query.findObjectsInBackgroundWithBlock(completionBlock)
//    }
    
    /**
    Establishes a follow relationship between two users.
    
    :param: user    The user that is following
    :param: toUser  The user that is being followed
//    */
//    static func addFollowRelationshipFromUser(user: PFUser, toUser: PFUser)
//    {
//        let followObject = PFObject(className: ParseFollowClass)
//        followObject.setObject(user, forKey: ParseFollowFromUser)
//        followObject.setObject(toUser, forKey: ParseFollowToUser)
//        
//        followObject.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
//    }
    
    /**
    Deletes a follow relationship between two users.
    
    :param: user    The user that is following
    :param: toUser  The user that is being followed
    */
//    static func removeFollowRelationshipFromUser(user: PFUser, toUser: PFUser)
//    {
//        let query = PFQuery(className: ParseFollowClass)
//        query.whereKey(ParseFollowFromUser, equalTo:user)
//        query.whereKey(ParseFollowToUser, equalTo: toUser)
//        
//        query.findObjectsInBackgroundWithBlock
//        {
//            (results: [AnyObject]?, error: NSError?) -> Void in
//            if let error = error
//            {
//                ErrorHandling.defaultErrorHandler(error)
//            }
//            
//            let results = results as? [PFObject] ?? []
//            
//            for followRelationship in results
//            {
//                followRelationship.deleteInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
//            }
//        }
//    }
    
    // MARK: Users
    
    /**
    Fetch all users, except the one that's currently signed in.
    Limits the amount of users returned to 20.
    
    :param: completionBlock The completion block that is called when the query completes
    
    :returns: The generated PFQuery
    */
    static func allUsers(completionBlock:PFArrayResultBlock) -> PFQuery
    {
        let query = PFUser.query()!
        // exclude the current user
        query.whereKey(ParseHelper.ParseUserUsername,
            notEqualTo: PFUser.currentUser()!.username!)
        query.orderByAscending(ParseHelper.ParseUserUsername)
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        return query
    }
    
    /**
    Fetch users who's username matches the provided search term.
    
    :param: searchText The text that should be used to search for users
    :param: completionBlock The completion block that is called when the query completes
    
    :returns: The generated PFQuery
    */
    static func searchUsers(searchText: String, completionBlock: PFArrayResultBlock) -> PFQuery
    {
            /*
            NOTE: We are using a Regex to allow for a case insensetive compare of usernames.
            Regex can be slow on large datasets. For large amount of data it's better to store
            lowercased username in a separate column and perform a regular string compare.
            */
            let query = PFUser.query()!.whereKey(ParseHelper.ParseUserUsername, matchesRegex: searchText, modifiers: "i")
            
            query.whereKey(ParseHelper.ParseUserUsername, notEqualTo: PFUser.currentUser()!.username!)
            
            query.orderByAscending(ParseHelper.ParseUserUsername)
            query.limit = 20
            
            query.findObjectsInBackgroundWithBlock(completionBlock)
            
            return query
    }

}
extension PFObject : Equatable
{
    
}

public func ==(lhs: PFObject, rhs: PFObject) -> Bool
{
    return lhs.objectId == rhs.objectId
}

