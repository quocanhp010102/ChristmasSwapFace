//
//  SanTacall2ViewController.swift
//  ChristmasSwapFace
//
//
//  MainViewController.swift
//  SantaCallingApp
//
//  Created by tran the quan on 28/11/2021.
//

import UIKit
import AVFoundation
import AppTrackingTransparency

var mainViewController = MainViewController()
class SanTacall2ViewController: UIViewController {
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var snow: UIImageView!
    
    var player: AVAudioPlayer?
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var backBTN:UIButton!
    @IBOutlet weak var videoBtn: UIButton!
    
    @IBOutlet weak var hangtram: UILabel!
    @IBOutlet weak var hangchuc: UILabel!
    @IBOutlet weak var hangdv: UILabel!
    @IBOutlet weak var coolkid: UIImageView!
    @IBAction func call(){
        player?.stop()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Santall3CallViewController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func video(){
        player?.stop()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SantaCallVideoViewController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func back(){
        //player2?.stop()
        player?.stop()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainCallViewController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func chat(){
        player?.stop()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChatViewController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func listImage(){
        //player?.stop()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainSwapface2testViewController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "BACKGROUND NOEL FREE", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        backBTN.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
//        gifView.loadGif(name: "santa")
//        snow.loadGif(name: "snoww")
        playSound()
       // gifView.layer.borderWidth = 1
       // gifView.layer.masksToBounds = true
      //  gifView.layer.borderColor = UIColor.black.cgColor
      //  gifView.layer.cornerRadius = self.view!.bounds.height*0.135417/2
       // print(gifView.frame.height/2)
//        print(self.view!.bounds.height*0.135417)
//        //print(self.view.height*0.135417)
//        print(UIScreen.main.bounds.size.height)
//        gifView.clipsToBounds = true
        // xu li day count down
//        let calendar = NSCalendar.current
//        var chrisDate = DateComponents()
//        let day2 = Date()
//        chrisDate.day = 25;
//        chrisDate.month=12;
//        chrisDate.year=2021
//        let date = Calendar.current.date(from: chrisDate)! // <2>
//        let numberOfDays = calendar.dateComponents([.day], from: day2, to: date)
//        var n : Int = numberOfDays.day ?? 0
//        n += 1
//        print(numberOfDays.day)
//      //  hangtram.text = String(n / 100)
//        n = n % 100;
//        hangchuc.text = String(n / 10)
//        n = n % 10
//        hangdv.text = String(n )
//        AdmobManager.shared.fullRootViewController = self
        
      //  quang cao
//        if #available(iOS 14, *) {
//            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//                                                            AdmobManager.shared.createAndLoadInterstitial()
//                                                            AdmobManager.shared.logEvent()
//            DispatchQueue.main.async {
//                 self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))
//                                                            }            })
//        } else {
//            AdmobManager.shared.createAndLoadInterstitial()
//            AdmobManager.shared.logEvent()
//            DispatchQueue.main.async {
//                self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))
//            }        }
    }
}
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get{
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
