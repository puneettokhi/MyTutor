//
//  GoogleViewController.swift
//  MY TUTOR
//
//  Created by PUNEET TOKHI on 12/2/16.
//  Copyright © 2016 Appmart. All rights reserved.
//

import UIKit
import GoogleSignIn

class GoogleViewController: UIViewController, GIDSignInUIDelegate  {

    @IBOutlet var nextButton: UIButton!
    
    @IBAction func signOutOfScreen(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signOut()
    }
    @IBOutlet var userProfilePicImage: UIImageView!
    @IBOutlet var userProfileNameLabel: UILabel!
    @IBOutlet var welcomeUserLabel: UILabel!
    
    
    func refreshInterface(){
        
        if let tempUser = GIDSignIn.sharedInstance().currentUser {
            
             self.welcomeUserLabel.text = "Welcome to My Tutor!"
            self.userProfileNameLabel.text = "\(tempUser.profile.name!)"
            
            
            
            let profilePicURL = tempUser.profile.imageURL(withDimension: 175)
            userProfilePicImage.image = UIImage(data: NSData(contentsOf: profilePicURL!)! as Data)
            userProfilePicImage.isHidden = false
            
        }
        
        
        else{
            
            
            self.nextButton.alpha = 0.0
        }
            
       
        
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshInterface()
        
        (UIApplication.shared.delegate as! AppDelegate).signInCallback = refreshInterface

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
