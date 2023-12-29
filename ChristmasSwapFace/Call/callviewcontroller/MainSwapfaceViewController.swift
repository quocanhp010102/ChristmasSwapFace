//
//  MainSwapfaceViewController.swift
//  ChristmasSwapFace
//
//  Created by quocanhppp on 25/12/2023.
//

import UIKit
import Kingfisher
import AVKit
class MainSwapfaceViewController: UIViewController {
    @IBOutlet weak var ButtonSwapfaceOUT:UIButton!
    @IBOutlet weak var CollectViewListVD:UICollectionView!
    //var listData:[ListVideoModal] = [ListVideoModal]()
    @IBAction func playWebVideo(_ sender: Any) {

          guard let url = URL(string: "https://github.com/sonnh7289/funnyvideo_faceFunny/raw/main/Snaptik.app_7190233876864961838.mov") else {
              return
          }
          // Create an AVPlayer, passing it the HTTP Live Streaming URL.
          let player = AVPlayer(url: url)
          let controller = AVPlayerViewController()
          controller.player = player
          present(controller, animated: true) {
              player.play()
          }
      }
    var listData:[ListVideoModal] = [ListVideoModal]()
    
    func getHomeNimeManga(andCompletion completion:@escaping (_ moviesResponse: [ListVideoModal], _ error: Error?) -> ()) {
        APIService.shared.GetMangaAll(albuum:"2") { (response, error) in
            if let listData = response{
                self.listData = listData
                DispatchQueue.main.async {
                    self.CollectViewListVD.reloadData()
                }
            }
            completion(self.listData, error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonSwapfaceOUT.setTitle("", for: .normal)
        CollectViewListVD.backgroundColor=UIColor.clear
        CollectViewListVD.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCollectionViewCell")
        self.getHomeNimeManga(){_,_ in
               }
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
//func videoUrl(){
//    guard let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4") else {return}
//    self.playerView = AVPlayer(url: url)
//    playerView?.play()
//    avPlayerCintroller.player = playerView
//    present(avPlayerCintroller, animated: true, completion: nil)
//            
//}
extension MainSwapfaceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: "https://github.com/sonnh7289/funnyvideo_faceFunny/raw/main/Snaptik.app_7190233876864961838.mov") else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true) {
            player.play()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        cell.label1.text = String(listData[indexPath.row].thongtin)
        cell.label2.text = listData[indexPath.row].mask
        cell.label3.text = String(listData[indexPath.row].dotuoi)
        //ell.labelEmail.text=listData[indexPath.row].email
        let url = URL(string: listData[indexPath.row].image)
        cell.imageavt.kf.setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    
}

extension MainSwapfaceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: (UIScreen.main.bounds.width)/3-10, height: 250)
        }
        return CGSize(width: (UIScreen.main.bounds.width)/2.1-10, height: 250)
    }
}



