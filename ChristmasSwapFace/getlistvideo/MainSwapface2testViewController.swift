//
//  MainSwapface2testViewController.swift
//  ChristmasSwapFace
//
//  Created by quocanhppp on 29/12/2023.
//

import UIKit
import Kingfisher

class MainSwapface2testViewController: UIViewController {
    @IBOutlet weak var collectionViewGood: UICollectionView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var profile: UIButton!
    @IBOutlet weak var collectionViewPage: UICollectionView!
    @IBAction func actionNextProfile(_ sender: Any) {
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        vc.userId = AppConstant.userId ?? 0
        vc.callAPIRecentComment()
        vc.callApiProfile()
        vc.callAPIUserEvent()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    var indexSelectPage = 0
    @IBAction func MenuActionPro(){
        let vc = ListSwapResultVC(nibName: "ListSwapResultVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBOutlet weak var buttonBack: UIButton!
    var indexSelectedPage=0
//    @IBAction func buttonAction(_ sender: UIButton) {
//      if let buttonTitle = sender.title(for: .normal) {
//         getHomeNimeManga(album: buttonTitle, andCompletion: <#T##([ListVideoModal], Error?) -> ()##([ListVideoModal], Error?) -> ()##(_ moviesResponse: [ListVideoModal], _ error: Error?) -> ()#>)
//      }
//    }
    var listTemplateVideo : [Temple2VideoModel] = [Temple2VideoModel]()
    var listData:[ListVideoModal] = [ListVideoModal]()
//    func loadListVideoTemp(){
//        APIService.shared.GetMangaAll(albuum:"1") { (response, error) in
//            if let listData = response{
//                self.listData = listData
//                DispatchQueue.main.async {
//                    self.CollectViewListVD.reloadData()
//                }
//            }
//            completion(self.listData, error)
//        }
//    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSearch.setTitle("", for: .normal)
        profile.setTitle("", for: .normal)
//        colecttiondanhmuc.register(UINib(nibName: "getlistimageclvCell", bundle: nil), forCellWithReuseIdentifier: "getlistimageclvCell")
//        CollectViewListVD.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCollectionViewCell")
        collectionViewGood.register(UINib(nibName: VideoTemplateCLVCell.className, bundle: nil), forCellWithReuseIdentifier: VideoTemplateCLVCell.className)
        collectionViewPage.register(UINib(nibName: "getlistimageclvCell", bundle: nil), forCellWithReuseIdentifier: "getlistimageclvCell")
        loadListVideoTemp()
       // buttonBack.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
     //   buttonBack.tag = 1
       // self.buttonBack.setTitle("", for: UIControl.State.normal)
      //  self.userProfileButton.setTitle("", for: UIControl.State.normal)
//        self.getHomeNimeManga(){_,_ in
//               }
        // Do any additional setup after loading the view.
    }
    func loadListVideoTemp(){
        APIService.shared.listAllTemplateVideoSwap(page:0,categories:0){response,error in
            self.listTemplateVideo = response
            self.collectionViewGood.reloadData()
        }
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
extension MainSwapface2testViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewPage{
            indexSelectPage = indexPath.row
            APIService.shared.listAllTemplateVideoSwap(page:indexSelectPage,categories:0){response,error in
                self.listTemplateVideo = response
                self.collectionViewGood.reloadData()
            }
            self.collectionViewPage.reloadData()
        }else{
            let vc = SwapVideoDetailVC(nibName: "SwapVideoDetailVC", bundle: nil)
            vc.itemLink = self.listTemplateVideo[indexPath.row]
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(vc, animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewPage{
            return 100
        }
        return self.listTemplateVideo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewPage {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "getlistimageclvCell", for: indexPath) as! getlistimageclvCell
           // cell.labelID.text = String(listData[indexPath.row].id_user)
            cell.buttonDanhMuc.text=String(indexPath.row+1)
            cell.buttonDanhMuc.textColor = UIColor.white
            cell.buttonDanhMuc.font = UIFont.boldSystemFont(ofSize: 18.0)
            cell.buttonDanhMuc.textAlignment = .center
            cell.buttonDanhMuc.backgroundColor = UIColor.blue
            cell.buttonDanhMuc.layer.cornerRadius = 15
            cell.buttonDanhMuc.layer.masksToBounds = true
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoTemplateCLVCell.className, for: indexPath) as! VideoTemplateCLVCell
        cell.imageVideo.layer.cornerRadius = 10
       // cell.imageVideo.layer.masksToBounds = true
        cell.labelName.text = self.listTemplateVideo[indexPath.row].noi_dung ?? ""
        let url = URL(string: self.listTemplateVideo[indexPath.row].thumbnail ?? "")
        let processor = DownsamplingImageProcessor(size: cell.imageVideo.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 10)
        cell.imageVideo.kf.indicatorType = .activity
        cell.imageVideo.kf.setImage(
            with: url,
            placeholder: UIImage(named: "hoapro"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        return cell
       
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
    
}

extension MainSwapface2testViewController: UICollectionViewDelegateFlowLayout {
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
        if collectionView == collectionViewPage{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 150)
            }
            return CGSize(width: (UIScreen.main.bounds.width)/10-10, height: 150)
        }else{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: (UIScreen.main.bounds.width)/3-10, height: 250)
            }
            return CGSize(width: (UIScreen.main.bounds.width)/2.1-10, height: 250)
        }
        
    }
}

