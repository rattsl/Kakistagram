//
//  SignInViewController.swift
//  Kakistagram
//
//  Created by 垣内勇人 on 2019/05/23.
//  Copyright © 2019 Hayatokakiuchi. All rights reserved.
//

import UIKit
import NCMB

class SignInViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        
        userIdTextField.delegate = self
        passwordTextField.delegate = self
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func SignIn () {
        if userIdTextField.text != nil && passwordTextField.text != nil {
            
            NCMBUser.logInWithUsername(inBackground: userIdTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil {
                    print(error)
                } else {
                    //ログイン成功
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //ログイン状態の保持
                    let ud = UserDefaults.standard
                    ud.set( true, forKey: "isLogin")
                    ud.synchronize()
                }
            }
        }
        
    }
    
    @IBAction func forgetPassword () {
        //後から実装
        
    }

}





