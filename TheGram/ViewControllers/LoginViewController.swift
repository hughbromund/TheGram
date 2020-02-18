//
//  LoginViewController.swift
//  TheGram
//
//  Created by Hugh Bromund on 2/17/20.
//  Copyright © 2020 Hugh Bromund. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
//    Color Pallet: https://colorhunt.co/palette/165293
    
    let orange = UIColor(red:1.00, green:0.45, blue:0.08, alpha:1.0)
    let white = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    let grey = UIColor(red:0.23, green:0.21, blue:0.21, alpha:1.0)
    let darkGrey = UIColor(red:0.14, green:0.13, blue:0.13, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signinButton.backgroundColor = orange
        signinButton.tintColor = orange
        signinButton.setTitleColor(white, for: UIControl.State.normal)
        
        self.view.backgroundColor = darkGrey
        
        titleLabel.textColor = white
        textLabel.textColor = white
        usernameLabel.textColor = white
        passwordLabel.textColor = white
        
        usernameTextfield.backgroundColor = white
        passwordTextfield.backgroundColor = white
        
        signupButton.setTitleColor(orange, for: UIControl.State.normal)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
