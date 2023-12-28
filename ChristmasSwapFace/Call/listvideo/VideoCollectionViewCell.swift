//
//  VideoCollectionViewCell.swift
//  ChristmasSwapFace
//
//  Created by quocanhppp on 25/12/2023.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label1:UILabel!
    @IBOutlet weak var label2:UILabel!
    @IBOutlet weak var label3:UILabel!
    @IBOutlet weak var imageavt:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addBorder(to: .bottom, in: .red, width: 2)
        self.layer.cornerRadius=5
        // Initialization code
    }

}
