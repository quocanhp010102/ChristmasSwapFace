//
//  ConfigdForgetViewController.swift
//  ChristmasSwapFace
//
//  Created by quocanhppp on 21/12/2023.
//

import UIKit

class ConfigdForgetViewController: UIViewController {
    @IBOutlet weak var buttonback:UIButton!
    @IBAction func tapBackBtn(_ sender: Any) {
         self.dismiss(animated: true)
        
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
