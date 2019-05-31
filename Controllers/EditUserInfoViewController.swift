//
//  EditUserInfoViewController.swift
//  Kakistagram
//
//  Created by 垣内勇人 on 2019/05/24.
//  Copyright © 2019 Hayatokakiuchi. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit

class EditUserInfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userIdTextfield: UITextField!
    @IBOutlet var introductionTextView: UITextView!

    override func viewDidLoad() {
        
        userNameTextField.delegate = self
        userIdTextfield.delegate = self
        introductionTextView.delegate = self
        
        //ニフティクラウドからデータを取得してテキストフィールドに読み込み
        let userId = NCMBUser.current()?.userName
        userIdTextfield.text = userId
        
        //角を丸く
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2.0
        userImageView.layer.masksToBounds = true
        
         //backgroundからデータを読み込みんだあと表示
        if let user = NCMBUser.current() {
        userNameTextField.text = user.object(forKey: "displayName") as? String
        introductionTextView.text = user.object(forKey: "introduction") as? String
        self.navigationItem.title = user.userName
        
        //画像を読み込んで表示
        let file = NCMBFile.file(withName: user.objectId, data: nil) as! NCMBFile
        file.getDataInBackground { (data, error) in
            if error != nil{
                print(error)
            } else {
                if data != nil {
                    let image = UIImage(data: data!)
                    self.userImageView.image = image
                }
            }
        }
        } else {
            //ログアウト成功
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            //ログイン状態の保持
            let ud = UserDefaults.standard
            ud.set( false, forKey: "isLogin")
            ud.synchronize()
        }
        
        super.viewDidLoad()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[.originalImage] as! UIImage
        let resizedImage = selectedImage.scale(byFactor: 0.2)
        
        picker.dismiss(animated: true, completion: nil)
        
        let data = resizedImage!.pngData()
        let file = NCMBFile.file(withName: NCMBUser.current()?.objectId, data: data) as! NCMBFile
        file.saveInBackground({ (error) in
            if error != nil{
                print(error)
            } else {
                self.userImageView.image = selectedImage
            }
        }) { (progress) in
            print(progress)
        }
    }
    
    
    
    
    
    @IBAction func selectImage() {
        let alertController = UIAlertController(title: "画像の選択", message: "画像を選択してください", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            //カメラの起動
            if UIImagePickerController.isSourceTypeAvailable(.camera){
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            } else {
                print("この端末ではカメラが使えません")
            }
        }
        let albumAction = UIAlertAction(title: "フォトアルバム", style: .default) { (action) in
            //フォトライブラリーの起動
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            } else {
                print("この端末では使用できません")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)
        
        //alertを表示するコード
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func closeEditUserInfoViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //完了が押された時にデータを保存するメソッド
    @IBAction func saveUserInfo() {
        let user = NCMBUser.current()
        user?.setObject(userNameTextField.text, forKey: "displayName")
        user?.setObject(userIdTextfield.text, forKey: "userId")
        user?.setObject(introductionTextView.text, forKey: "introduction")
        
        user?.saveInBackground({ (error) in
            if error != nil {
                print (error)
            } else {
                 self.dismiss(animated: true, completion: nil)
            }
        })
       
        
    }
    
}






