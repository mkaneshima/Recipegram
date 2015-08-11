//
//  AppDelegate.swift
//  Template Project
//
//  Created by Benjamin Encz on 5/15/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseUI
import Mixpanel


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var parseLoginHelper: ParseLoginHelper!
    override init()
    {
        super.init()
        
        // MARK: Parse Login
        parseLoginHelper = ParseLoginHelper
        {
            [unowned self] user, error in
            // Initialize the ParseLoginHelper with a callback
            if let error = error
            {
                ErrorHandling.defaultErrorHandler(error)
            }
            else if let user = user
            {
                // if login was successful, display the NavigationController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyboard.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
            
                self.window?.rootViewController!.dismissViewControllerAnimated(true, completion: nil)
                self.window?.rootViewController!.presentViewController(mainViewController, animated:true, completion:nil)
            }
        }
    }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
  {
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    
    // Override point for customization after application launch.
    
    Mixpanel.sharedInstanceWithToken("401068b56d236e5403ba8ee996d0208c")
    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
    mixpanel.track("App launched")
    
    // Set up the Parse SDK
    Parse.setApplicationId("LGHDw7YSM4F1OBuBQwSZzKFcPvlZhl5brqVr27nv", clientKey: "jxEQqoFEaGI2iqRcATk3ri8PwAXtlyxYYLFeZwgx")
    
    // Set default ACL
    let acl = PFACL()
    acl.setPublicReadAccess(true)
    PFACL.setDefaultACL(acl, withAccessForCurrentUser: true)
    
    // Initialize Facebook
    PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
    
    // check if we have logged in user
    let user = PFUser.currentUser()
    
    let startViewController: UIViewController;
    
    if (user != nil)
    {
        // if we have a user, set the RecipeViewController to be the initial View Controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        startViewController = storyboard.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
    }
    else
    {
        // Otherwise set the LoginViewController to be the first
        let loginViewController = PFLogInViewController()
        
        let logoTitle = UILabel()
        logoTitle.textColor = UIColor.blackColor()
        logoTitle.text = "Recipegram"
        logoTitle.font = UIFont(name: "Helvetica", size: 40.0)
        
        let signInLogoTitle = UILabel()
        signInLogoTitle.textColor = UIColor.blackColor()
        signInLogoTitle.text = "Recipegram"
        signInLogoTitle.font = UIFont(name: "Helvetica", size: 40.0)

        loginViewController.logInView?.logo = logoTitle
        loginViewController.logInView?.showsVerticalScrollIndicator = true
        loginViewController.logInView?.dismissButton?.hidden = true
        
        loginViewController.fields = .UsernameAndPassword | .LogInButton | .SignUpButton | .PasswordForgotten
        loginViewController.delegate = parseLoginHelper
        loginViewController.signUpController?.delegate = parseLoginHelper
        
        loginViewController.signUpController?.signUpView?.logo = signInLogoTitle
        loginViewController.signUpController?.signUpView?.dismissButton?.hidden = true
//        loginViewController.signUpController?.signUpView?.emailField?.hidden = true
        
        
        startViewController = loginViewController
    }
   
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window?.rootViewController = startViewController;
    self.window?.makeKeyAndVisible()
    
    return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: Facebook Integration
  func applicationDidBecomeActive(application: UIApplication)
  {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    FBSDKAppEvents.activateApp()
  }
  
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool
  {
     return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
  }
  
    
  // MARK: Other AppDelegateMethods
  func applicationWillResignActive(application: UIApplication)
  {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication)
  {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication)
  {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationWillTerminate(application: UIApplication)
  {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
   }
    
    func logOut()
    {
        
        let loginViewController = PFLogInViewController()

        
        let logoTitle = UILabel()
        logoTitle.textColor = UIColor.blackColor()
        logoTitle.text = "Recipegram"
        logoTitle.font = UIFont(name: "Helvetica", size: 40.0)
        
        let signInLogoTitle = UILabel()
        signInLogoTitle.textColor = UIColor.blackColor()
        signInLogoTitle.text = "Recipegram"
        signInLogoTitle.font = UIFont(name: "Helvetica", size: 40.0)
        
        
        loginViewController.logInView?.logo = logoTitle
        loginViewController.logInView?.showsVerticalScrollIndicator = true
        loginViewController.logInView?.dismissButton?.hidden = true
        
        loginViewController.fields = .UsernameAndPassword | .LogInButton | .SignUpButton | .PasswordForgotten
        loginViewController.delegate = parseLoginHelper
        loginViewController.signUpController?.delegate = parseLoginHelper
        
        
        loginViewController.signUpController?.signUpView?.logo = signInLogoTitle
        loginViewController.signUpController?.signUpView?.dismissButton?.hidden = true
//        loginViewController.signUpController?.signUpView?.emailField?.hidden = true

        self.window?.rootViewController = loginViewController
    }
    
  
}

