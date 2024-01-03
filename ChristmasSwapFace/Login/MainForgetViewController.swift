//
//  FogotPassViewController.swift
//  FutureLove
//
//  Created by TTH on 26/07/2023.
//

import UIKit
import Toast_Swift

class MainForgetViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func loadNext(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "otpForgetViewController") as! otpForgetViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        hideKeyboardWhenTappedAround()
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func resetPasswordBtn(_ sender: Any) {
        guard emailTextField.text != "" else {
             self.view.makeToast("Email cannot be blank")
          
            return
        }
        showCustomeIndicator()
        var paramSend:[String: String] = ["email":(emailTextField.text ?? "")]
        APIService.shared.resetPassword(param: paramSend) { response,error  in
            if let response = response{
                print(response)
                self.showAlert(message: response.message ?? "")
                self.view.makeToast("check mail")
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "otpForgetViewController") as! otpForgetViewController
//                vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency self.present(vc, animated: true, completion: nil)
                self.navigationController?.setRootViewController(viewController:LoginViewController(),
                                                                 controllerType: LoginViewController.self)
            }
        }
        
        
    }
    
   
}
