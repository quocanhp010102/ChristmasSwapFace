//
//  MainViewController.swift
//  ChristmasSwapFace
//
//  Created by quocanhppp on 20/12/2023.
//

import UIKit
import SwiftKeychainWrapper
import Toast_Swift
class MainViewController: BaseViewController {
    @IBOutlet weak var buttonback:UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
//    func setDataPro(){
//        if let number_user: Int = KeychainWrapper.standard.integer(forKey: "saved_login_account"){
//            for item in 0..<number_user{
//                let emailUserKey = "email_login_" + String(item + 1)
//                if let emailUser: String = KeychainWrapper.standard.string(forKey: emailUserKey){
//                    self.userNameTextField.text = emailUser
//                }
//                let idPassUser = "pass_login_" + String(item + 1)
//                if let passEmail: String = KeychainWrapper.standard.string(forKey: idPassUser){
//                    self.passWordTextField.text = passEmail
//                }
//            }
//        }
//    }
    @IBAction func buttonback2(){
        
//        let vc = UIViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginupViewController") as! LoginupViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)



        
    }
    @IBAction func buttonback3forgetMain(){
        //        let vc = UIViewController()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MainForgetViewController") as! MainForgetViewController
                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)



        
    }
    
    @IBAction func buttonback3MainCall(){
////        let vc = UIViewController()
//        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "MainCallViewController")
//        self.present(vc, animated: true)
        guard userNameTextField.text != "" && passWordTextField.text != "" else {
            if userNameTextField.text == "" {
                self.view.makeToast("UserName or Email cannot be blank", position: .top)
            } else {
                self.view.makeToast("Password cannot be left blank",position: .top)
            }
             return
        }
        showCustomeIndicator()
        let parameters = ["email_or_username": userNameTextField.text.asStringOrEmpty(), "password": passWordTextField.text.asStringOrEmpty()]
        APIService.shared.LoginAPI(param: parameters){result, error in
            self.hideCustomeIndicator()
            guard result?.id_user != nil else {
                self.view.makeToast(result?.ketqua, position: .top)
                self.errorMessageLabel.text = result?.ketqua
                if let messagePro = result?.ketqua{
                    //self.showAlert(message: messagePro)
                    return
                }
//                self.showAlert(message: (result?.ketqua) ?? "Password Wrong Or Account Not Register Or Account Not Verify Email")
                return
            }
            if let result = result{
                AppConstant.saveUser(model: result)
                if let number_user: Int = KeychainWrapper.standard.integer(forKey: "saved_login_account"){
                    let number_userPro = number_user + 1
                    KeychainWrapper.standard.set(number_userPro, forKey: "saved_login_account")
                    if let resultEmail = (result.email){
                        let idUserNumber = "email_login_" + String(number_userPro)
                        KeychainWrapper.standard.set(resultEmail, forKey: idUserNumber)
                        let idPassUser = "pass_login_" + String(number_userPro)
                        KeychainWrapper.standard.set(self.passWordTextField.text.asStringOrEmpty(), forKey: idPassUser)
                        let idTimeUser = "time_login_" + String(number_userPro)
                        let timeNow = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
                        KeychainWrapper.standard.set(timeNow, forKey: idTimeUser)
                    }
                }else{
                    KeychainWrapper.standard.set(1, forKey: "saved_login_account")
                    if let resultEmail = (result.email){
                        let idUserNumber = "email_login_" + String(1)
                        KeychainWrapper.standard.set(resultEmail, forKey: idUserNumber)
                        let idPassUser = "pass_login_" + String(1)
                        KeychainWrapper.standard.set(self.passWordTextField.text.asStringOrEmpty(), forKey: idPassUser)
                        let timeNow = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
                        let idTimeUser = "time_login_" + String(1)
                        KeychainWrapper.standard.set( timeNow, forKey: idTimeUser)
                    }
                }
            }
          //  let vc = UIViewController()
                  let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: "MainCallViewController")
                  self.present(vc, animated: true)
        }
        
    
    }
    

        
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonback.setTitle("", for: .normal)
       
    }


}

