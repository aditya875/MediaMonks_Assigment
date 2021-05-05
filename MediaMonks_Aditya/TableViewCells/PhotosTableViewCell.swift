//
//  PhotosTableViewCell.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 02/05/21.
//

import UIKit
import SDWebImage

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var photoName: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    var photoData: PhotoModel? {
        didSet {
            photoName.text = photoData?.title
            imgView.sd_setImage(with: URL(string: photoData?.thumbnailURL ?? ""), placeholderImage: UIImage(named: Constants.placeholderImage))
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
