//
//  MainCallViewController.swift
//  ChristmasSwapFace
//
//  Created by quocanhppp on 21/12/2023.
//

import UIKit

class MainCallViewController: UIViewController {
   
    @IBAction func ButtonSwapfaceAC(){
        
//        let vc = UIViewController()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainSwapfaceViewController") as! MainSwapfaceViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)



        
    }
    @IBAction func ButtonCallMain(){
        
//        let vc = UIViewController()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SanTacall2ViewController") as! SanTacall2ViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)



        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
