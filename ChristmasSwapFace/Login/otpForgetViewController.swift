//
//  otpForgetViewController.swift
//  ChristmasSwapFace
//
//  Created by quocanhppp on 21/12/2023.
//

import UIKit

class otpForgetViewController: UIViewController {
    @IBOutlet weak var buttonback:UIButton!
    @IBAction func tapBackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
     }
    @IBAction func buttonback3configForgetGmail(){
//        let vc = UIViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ConfigdForgetViewController") as! ConfigdForgetViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)



        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonback.setTitle("", for: .normal)
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
