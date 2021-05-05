//
//  PhotoDetailViewController.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 04/05/21.
//

import UIKit
import SDWebImage

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoImgView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    var photoData: PhotoModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Details"
        showPhotoDetails()
    }

    //MARK: Show photo on UIView
    private func showPhotoDetails() {
        self.view.startActivityIndicator()
        photoImgView.sd_setImage(with: URL(string: photoData?.url ?? ""), placeholderImage: UIImage(named: Constants.placeholderImage))
        descLabel.text = photoData?.title
        self.view.stopActivityIndicator()
    }
    

}
