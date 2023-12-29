//
//  ChatViewController.swift
//  SantaCallingApp
//
//  Created by tran the quan on 28/11/2021.
//

import UIKit
extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

//    @objc func dismissKeyboard()
//    {
//        view.endEditing(true)
//    }
}
class ChatViewController: UIViewController {
    let eliza = Eliza()
    var dataPro:[String] = [String]()
    @IBOutlet weak var santagif: UIImageView!
    @IBOutlet weak var txtfield: UITextField!
    @IBOutlet weak var collectionViewMain: UICollectionView!
    
    @IBOutlet weak var snow: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatTBV: UITableView!
    var messege: String = ""
    var dataChat: [ChatModel] = []
    var chatSanta = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.setTitle("", for: .normal)
        backBtn.setTitle("", for: .normal)
        self.setupToHideKeyboardOnTapOnView()
        snow.loadGif(name: "snoww")
        dataPro.append("hi")
        dataPro.append("How are you")
        dataPro.append("Hello")
        dataPro.append("I'm glad to meet you")
        dataPro.append("Can you send me a gift?r")
        santagif.loadGif(name: "santa")
        
        santagif.layer.borderWidth = 1
        santagif.layer.cornerRadius = santagif.frame.height/2
        //santagif.clipsToBounds = true
        txtfield.cornerRadius=15
        collectionViewMain.register(UINib(nibName: CellCon.className, bundle: nil), forCellWithReuseIdentifier: CellCon.className)
        collectionViewMain.backgroundColor = UIColor.clear
        collectionViewMain.showsHorizontalScrollIndicator = false
        // xu ly chat
        chatTBV.register(UINib(nibName: YouChatTBV.className, bundle: nil), forCellReuseIdentifier: YouChatTBV.className)
        chatTBV.register(UINib(nibName: SantaChatTBV.className, bundle: nil), forCellReuseIdentifier: SantaChatTBV.className)
        let answer = self.eliza.elizaHi()
        chatSanta = answer
        let contentChatSanta = ChatModel()
        contentChatSanta.id = dataChat.count
        contentChatSanta.check = 1
        contentChatSanta.content = chatSanta
        dataChat.append(contentChatSanta)
        chatTBV.reloadData()
        
//        quangcao
//        AdmobManager.shared.logEvent()
//        DispatchQueue.main.async {
//            self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))
//        }
    }
    @IBAction func back(){
        let storyboard = UIStoryboard(name: "CallStabord", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SanTacall2ViewController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func sendMessage(){
        let contentChatYou = ChatModel()
        contentChatYou.id = dataChat.count
        contentChatYou.check = 0
        contentChatYou.content = txtfield.text
        dataChat.append(contentChatYou)
        print(dataChat[0].content)
        print(dataChat.count)
        chatTBV.reloadData()
        if dataChat.count > 0 {
            scrollToBottomOfChat()
        }
        let answer = self.eliza.replyTo(txtfield.text ?? "")
        chatSanta = answer
        let contentChatSanta = ChatModel()
        contentChatSanta.id = dataChat.count
        contentChatSanta.check = 1
        contentChatSanta.content = chatSanta
        dataChat.append(contentChatSanta)
        chatTBV.reloadData()
        scrollToBottomOfChat()
        messege = ""
        txtfield.text = ""
      
    }
    func scrollToBottomOfChat(){
        let indexPath = IndexPath(row: dataChat.count - 1, section: 0)
        chatTBV.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
}
//  ___________chatTBV
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataChat[indexPath.row].check == 0 {
            print(indexPath.row)
            let cell = chatTBV.dequeueReusableCell(withIdentifier: YouChatTBV.className, for: indexPath as IndexPath) as! YouChatTBV
            cell.contentLB.text = dataChat[indexPath.row].content
            cell.focusStyle = UITableViewCell.FocusStyle.custom
          
            cell.contentLB.layer.masksToBounds = true
            
            cell.contentLB.layer.cornerRadius = 10
            //cell.contentLB.backgroundColor = UIColor.white
            cell.contentLB.layer.masksToBounds = true
            cell.contentLB.layer.cornerRadius = 10
            cell.lable.layer.masksToBounds = true
            cell.lable.backgroundColor = UIColor.init(white: 0.8, alpha: 0.9)
            cell.lable.layer.cornerRadius = 10
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = false
            return cell
        }
        let cell = chatTBV.dequeueReusableCell(withIdentifier: SantaChatTBV.className, for: indexPath as IndexPath) as! SantaChatTBV
        // off style tableViewcell
        cell.contentLB.text = dataChat[indexPath.row].content
        cell.focusStyle = UITableViewCell.FocusStyle.custom
       
        cell.contentLB.layer.masksToBounds = true
        cell.lable.layer.masksToBounds = true
        cell.lable.backgroundColor = UIColor.init(white: 0.8, alpha: 0.9)
        cell.lable.layer.cornerRadius = 10
        cell.contentLB.layer.cornerRadius = 10
        cell.contentLB.backgroundColor = UIColor.clear
        cell.contentLB.layer.masksToBounds = true
        cell.contentLB.layer.cornerRadius = 10
        cell.backgroundColor = UIColor.clear
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataChat.count
    }
}
//extension ChatViewController : UItable
//  ___________goi y chat
extension ChatViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPro.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellCon.className, for: indexPath) as! CellCon
        cell.labletext.text = dataPro[indexPath.row]
        cell.labletext.cornerRadius=10
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewMain.isHidden = true
        let contentChatYou = ChatModel()
        contentChatYou.id = dataChat.count
        contentChatYou.check = 0
        contentChatYou.content = dataPro[indexPath.row]
        dataChat.append(contentChatYou)
        sendMessage()
        chatTBV.reloadData()
        
    }
}
extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: self.collectionViewMain.frame.height))
                    if dataPro.count > 0 {
                        label.text = dataPro[indexPath.row]
                    }
                    label.sizeToFit()
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
            return CGSize(width: label.frame.width+10, height: self.collectionViewMain.frame.height-8)
        }else{

            return CGSize(width: label.frame.width+10, height: self.collectionViewMain.frame.height-8)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

