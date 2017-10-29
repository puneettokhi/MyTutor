//
//  AppDelegate.swift
//  My Tutor
//
//  Created by PUNEET TOKHI on 11/19/16.
//  Copyright © 2016 Appmart. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{
    
    var window: UIWindow?
    var signInCallback: (()->())?
    
    
    
    
    
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
       
        if let err = error {
            print("ERROR: Cannot log into Google!", err)
            return
        }
        
        print("Successfully logged into Google.", user)
        
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credentials = FIRGoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if let err = error {
                print("ERROR: Failed to create a Firebase Account!", err)
                return
            }
            
            guard let uid = user?.uid else { return }
            print("Successfully logged into Firebase.", uid)
        })
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        PayPalMobile .initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "AY1fGbzTF3Pf95VwFN97wGQf0eNaAnS1exw5I2LPPouMpLPi0VKpHIP4xo2EemYktasEKucEFKhkg6J2",
                                                                PayPalEnvironmentSandbox: "PUNEETTOKHI25-facilitator@GMAIL.COM"])
    

        
        FIRApp.configure()
        
        var configureError: NSError?
        
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        
        
        GIDSignIn.sharedInstance().delegate = self
        
        // Override point for customization after application launch.
        return true
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            print("Looks like we have a signing error")
        }
        else{
            print("Congratulations, \(user) you signed in!!")
        }
    }
    
    
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [ : ]) -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
    }
    /* func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: AnyObject?) -> Bool{
     
     return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
     }
     */
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

