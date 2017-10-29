//
//  ClassesViewController.swift
//  MY TUTOR
//
//  Created by PUNEET TOKHI on 12/2/16.
//  Copyright © 2016 Appmart. All rights reserved.
//

import UIKit
import GoogleSignIn

class ClassesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GIDSignInUIDelegate {
    
    
    @IBAction func logOutAction(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signOut()
    }
    
    let classes = ["Anthropology", "Biology", "Chemistry","Math 30", "Math 31", "Math 32", "Math 42", "Math 123", "Physics 50", "Physics 51"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return classes.count
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let class_cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        
        class_cell.textLabel?.text = classes[indexPath.row]
        
        
        return class_cell
        
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
