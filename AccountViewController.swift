//
//  AccountViewController.swift
//  MY TUTOR
//
//  Created by PUNEET TOKHI on 12/11/16.
//  Copyright © 2016 Appmart. All rights reserved.
//

import UIKit
import GoogleSignIn

class AccountViewController: UIViewController, GIDSignInUIDelegate {

    @IBAction func logOutAction(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signOut()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
