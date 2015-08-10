//
//  LoginViewController.swift
//  Recipegram
//
//  Created by Mari Kaneshima on 8/7/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

//import UIKit
//import Parse
//import ParseUI
//
//class LoginViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate
//{
//
//    var loginHelper: ParseLoginHelper!
//
//    var loginViewController: PFLogInViewController! = PFLogInViewController()
//    var signupViewController: PFSignUpViewController! = PFSignUpViewController()
//    
//    
//    
//    
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    override func viewDidAppear(animated: Bool)
//    {
//        if(PFUser.currentUser() == nil)
//        {
//            // Login
//            self.loginViewController.fields = .UsernameAndPassword | .LogInButton | .SignUpButton | .PasswordForgotten |  .Facebook
//            
//            let logo = UIImage(named: "Utensils")
//            let logoView = UIImageView(image: logo)
//            self.loginViewController.logInView?.logo = logoView
//            self.loginViewController.delegate = self
//            
//            // Sign up
//            let signUpLogoImage = UIImage(named: "Utensils")
//            let signUpView = UIImageView(image: signUpLogoImage)
//            self.signupViewController.signUpView?.logo = signUpView
//            self.signupViewController.delegate = self
//            
//            self.loginViewController.signUpController = self.signupViewController
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    // MARK: Parse Login
//    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool
//    {
//        if(!username.isEmpty || !password.isEmpty)
//        {
//            return true
//        }
//        else
//        {
//            return false
//        }
//    }
//    
//    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser)
//    {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?)
//    {
//        println("Failed to Log In.")
//    }
//    
//    // MARK: Parse Signup
//    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser)
//    {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?)
//    {
//        println("Failed to sign up.")
//    }
//    
//    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController)
//    {
//        println("User dismissed sign up.")
//    }
//    
//    
//    // MARK: Actions
//    
//    @IBAction func simpleLoginAction(sender: AnyObject)
//    {
//        self.presentViewController(self.loginViewController, animated: true, completion: nil)
//    }
//    
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
