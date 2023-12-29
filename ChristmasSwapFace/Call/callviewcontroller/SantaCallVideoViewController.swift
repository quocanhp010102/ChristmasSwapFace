//
//  SantaCallVideoViewController.swift
//  ChristmasSwapFace
//
//
//  VideoCallViewController.swift
//  SantaCallingApp
//
//  Created by tran the quan on 28/11/2021.
//

import UIKit
import AVFoundation
class SantaCallVideoViewController: UIViewController {
    var player: AVAudioPlayer?
    @IBOutlet weak var snow: UIImageView!
    @IBOutlet weak var santagif: UIImageView!
    
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var cntLable: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBAction func back(){
       
        player?.stop()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SanTacall2ViewController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func call(){
        cntLable.isHidden = false
        UIView.animate( withDuration: 0, delay: 3, animations: { () -> Void in
            self.cntLable.alpha = 0
            self.playSound()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.player?.stop()
            let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "VideoCallViewController2")
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(vc, animated: true, completion: nil)
        }
        self.callBtn.isHidden = true
    
    }
    func playSound() {
           guard let url = Bundle.main.url(forResource: "ringring", withExtension: "mp3") else { return }
        
           do {
               try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
               try AVAudioSession.sharedInstance().setActive(true)
               player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
               guard let player = player else { return }
               player.numberOfLoops = 1
               player.play()
           } catch let error {
               print(error.localizedDescription)
           }
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.setTitle("", for: .normal)
//        snow.loadGif(name: "snoww")
        santagif.loadGif(name: "santa")
        santagif.layer.borderWidth = 1
        santagif.layer.masksToBounds = true
        santagif.layer.borderColor = UIColor.black.cgColor
        santagif.layer.cornerRadius = self.view!.bounds.height*0.2/2
        print(santagif.frame.height/2)
        print(self.view!.bounds.height*0.2)
        //print(self.view.height*0.135417)
        print(UIScreen.main.bounds.size.height)
        santagif.clipsToBounds = true
        cntLable.isHidden = true
//        AdmobManager.shared.logEvent()
//        DispatchQueue.main.async {
//            self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))
//        }
    }

}
