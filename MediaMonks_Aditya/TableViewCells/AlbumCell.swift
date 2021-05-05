//
//  AlbumCell.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 02/05/21.
//

import UIKit

class AlbumCell: UITableViewCell {

    @IBOutlet weak var albumName: UILabel!

    var albumData: AlbumModel? {
        didSet {
            albumName.text = albumData?.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
