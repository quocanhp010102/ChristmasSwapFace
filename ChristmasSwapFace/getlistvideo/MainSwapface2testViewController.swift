//
//  MainSwapface2testViewController.swift
//  ChristmasSwapFace
//
//  Created by quocanhppp on 29/12/2023.
//

import UIKit

class MainSwapface2testViewController: UIViewController {
    @IBOutlet weak var colecttiondanhmuc:UICollectionView!
    @IBOutlet weak var CollectViewListVD:UICollectionView!
    @IBOutlet weak var buttonDanhMuc:UILabel!
    var indexSelectedPage=0
//    @IBAction func buttonAction(_ sender: UIButton) {
//      if let buttonTitle = sender.title(for: .normal) {
//         getHomeNimeManga(album: buttonTitle, andCompletion: <#T##([ListVideoModal], Error?) -> ()##([ListVideoModal], Error?) -> ()##(_ moviesResponse: [ListVideoModal], _ error: Error?) -> ()#>)
//      }
//    }
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
    func getHomeNimeManga( andCompletion completion:@escaping (_ moviesResponse: [ListVideoModal], _ error: Error?) -> ()) {
        APIService.shared.GetMangaAll(albuum:"1") { (response, error) in
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
        colecttiondanhmuc.register(UINib(nibName: "getlistimageclvCell", bundle: nil), forCellWithReuseIdentifier: "getlistimageclvCell")
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
extension MainSwapface2testViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colecttiondanhmuc{
          //  print("helooodanhuc")
            indexSelectedPage = indexPath.row
            APIService.shared.GetMangaAll(albuum:String(indexSelectedPage)) { (response, error) in
                if let listData = response{
                    self.listData = listData
                    DispatchQueue.main.async {
                        self.CollectViewListVD.reloadData()
                    }
                }
               // completion(self.listData, error)
            }
            self.colecttiondanhmuc.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == colecttiondanhmuc{
            return 100
        }
        return self.listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colecttiondanhmuc {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "getlistimageclvCell", for: indexPath) as! getlistimageclvCell
           // cell.labelID.text = String(listData[indexPath.row].id_user)
            cell.buttonDanhMuc.text=String(indexPath.row)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
            cell.label1.text = String(listData[indexPath.row].thongtin)
            cell.label2.text = listData[indexPath.row].mask
            cell.label3.text = String(listData[indexPath.row].dotuoi)
            //ell.labelEmail.text=listData[indexPath.row].email
            let url = URL(string: listData[indexPath.row].image)
            cell.imageavt.kf.setImage(with: url)
            return cell
        }
       
        
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
        if collectionView == colecttiondanhmuc{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: UIScreen.main.bounds.width, height: 150)
            }
            return CGSize(width: (UIScreen.main.bounds.width)/4-10, height: 150)
        }else{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: (UIScreen.main.bounds.width)/3-10, height: 250)
            }
            return CGSize(width: (UIScreen.main.bounds.width)/2.1-10, height: 250)
        }
        
    }
}

