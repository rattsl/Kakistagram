//
//  SignUpViewController.swift
//  Kakistagram
//
//  Created by 垣内勇人 on 2019/05/23.
//  Copyright © 2019 Hayatokakiuchi. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextfield: UITextField!
    
    override func viewDidLoad() {
        
        userIdTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextfield.delegate = self
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func SignUp () {
        
        //ユーザー情報の取得
        let user = NCMBUser()
        
        //userIdが４文字以内の条件分岐
        if userIdTextField.text!.count <= 3 {
            print("文字数が足りません")
            return
        }
        user.userName = userIdTextField.text
        user.mailAddress = emailTextField.text
        
        if passwordTextField.text == confirmTextfield.text {
        user.password = passwordTextField.text
        } else {
            print("パスワードの不一致")
        }
        
        //サインアップ
        user.signUpInBackground { (error) in
            if error != nil {
                //エラーがあった場合
                print(error!)
            } else {
                //サインアップに成功した場合
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






