//
//  VideoCallViewController2.swift
//  ChristmasSwapFace
//
//
//  VideoCallViewController2.swift
//  SantaCallingApp
//
//  Created by tran the quan on 07/12/2021.
//

import UIKit
import AVFoundation
import AVKit
class VideoCallViewController2: UIViewController {
    private var imageVC: UIImagePickerController?
    var player: AVAudioPlayer?
    @IBOutlet weak var cameraUIview: UIView!
    @IBOutlet weak var cancelBut: UIButton!
    @IBOutlet weak var santaView: UIView!
    @IBAction func back(){
        avPlayer.pause()
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SantaCallVideoViewController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    var dataVideo: [String] = ["hotsanta", "santahalloween", "santa", "original", "noel"]
    let avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!

    override func viewDidLoad() {
        super.viewDidLoad()


        let randNumber = Int.random(in: 0..<5)
        santaView.backgroundColor = .clear
        guard let path = Bundle.main.path(forResource: dataVideo[randNumber], ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))

        avPlayer.replaceCurrentItem(with: playerItem)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)

        santaView.layer.insertSublayer(avPlayerLayer, at: 0)
        // bat am thanh trong slient mode
        do {
           
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
          
        } catch let error {
            print(error.localizedDescription)
        }
        avPlayerLayer.videoGravity =  .resize
        avPlayerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        avPlayer.play()
        showCameraVC()
//        quangcao
//        AdmobManager.shared.logEvent()
//        DispatchQueue.main.async {
//            self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))
//        }
        
    }
    
    func showCameraVC() {
        self.imageVC = UIImagePickerController()

        if UIImagePickerController.isCameraDeviceAvailable(.front) {
            self.imageVC?.sourceType = .camera
            // tuy chon camera truoc hoac sau
            self.imageVC?.cameraDevice = .front
            self.imageVC?.showsCameraControls = false
            let screenSize = UIScreen.main.bounds.size
            let cameraAspectRatio = CGFloat(4.0 / 3.0)
            let cameraImageHeight = screenSize.height
            let scale = screenSize.height / cameraImageHeight
            self.imageVC?.cameraViewTransform = CGAffineTransform(translationX: 0, y: (screenSize.height - cameraImageHeight)/2)
            self.imageVC?.cameraViewTransform = self.imageVC!.cameraViewTransform.scaledBy(x: scale, y: scale)
            self.imageVC?.view.frame = CGRect(x: 0, y: 0, width: cameraUIview.frame.width, height: cameraUIview.frame.height)
            self.cameraUIview.addSubview(self.imageVC!.view)
            self.cameraUIview.sendSubviewToBack(self.imageVC!.view)
        }
    }
}


// lietkefiletrongthumuc
//        let fm = FileManager.default
//        let path3 = "/Users/quansao/Desktop/PRJ/SantaCallingApp/VideoSanta"
//
//        do {
//            let items = try fm.contentsOfDirectory(atPath: path3)
//
//            for item in items {
//                print("Found \(item)")
//            }
//        } catch {
//            // failed to read directory – bad permissions, perhaps?
//        }
