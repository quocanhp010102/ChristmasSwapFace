//
//  Santall3CallViewController.swift
//  ChristmasSwapFace
//
///
//  CallingViewController.swift
//  SantaCallingApp
//
//  Created by tran the quan on 28/11/2021.
//

import UIKit
import AVFoundation
class Santall3CallViewController: UIViewController {

    @IBOutlet weak var snow: UIImageView!
    var player: AVAudioPlayer?
    var player2: AVAudioPlayer?
    var x: Int = 6
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var cancelCall: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cntLable: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var santagif: UIImageView!
    var timer:Timer = Timer()
    var count:Int = -3
    @IBAction func back(){
        player2?.stop()
        player?.stop()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainCallViewController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    // press call button
    @IBAction func call(){
        cntLable.isHidden = false
        UIView.animate( withDuration: 0, delay: 3, animations: { () -> Void in
            self.cntLable.alpha = 0
            self.playSound()
            self.cancelCall.isEnabled = false
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            self.timeLable.isHidden = false
            self.player?.stop()
            self.cancelCall.isEnabled = true
            self.playSoundSanta()
        }
        self.callBtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        self.cancelCall.isHidden = false
    }

    @objc func timerCounter() -> Void
    {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        timeLable.text = timeString
    }
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int)
    {
        return (((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    func makeTimeString(minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    @IBAction func cancleCall(){
        self.count = -3;
        timer.invalidate()
         player2?.pause()
         timeLable.isHidden = true
         player?.stop()
         cancelCall.isHidden = true
         callBtn.isHidden = false
        cntLable.alpha = 1
        cntLable.isHidden = true
       //  iscall = true
    }
    
    // play ringring sound
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
    func playSoundSanta() {
        guard let url = Bundle.main.url(forResource: "british_dontfight_sister", withExtension: "mp3") else { return }
           do {
               try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
               try AVAudioSession.sharedInstance().setActive(true)
               player2 = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
               guard let player2 = player2 else { return }
               player2.numberOfLoops = 1
              player2.play()
                  
               
           } catch let error {
               print(error.localizedDescription)
           }
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.setTitle("", for: .normal)
        timeLable.isHidden = true
        //self.setupToHideKeyboardOnTapOnView()
        snow.loadGif(name: "snoww")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

