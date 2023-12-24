//
//  MainViewController.swift
//  ChristmasSwapFace
//
//  Created by quocanhppp on 20/12/2023.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var buttonback:UIButton!
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
//        let vc = UIViewController()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainCallViewController")
        self.present(vc, animated: true)

        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonback.setTitle("", for: .normal)
       
    }


}

