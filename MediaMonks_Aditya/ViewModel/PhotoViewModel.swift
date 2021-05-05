//
//  PhotoViewModel.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 02/05/21.
//

import Foundation

class PhotoViewModel {

    var photoData: [PhotoModel]?

    func numberOfRows() -> Int {
        return photoData?.count ?? 0
    }

    // MARK: Get photo data list
    func getPhotoDataList(id: Int, _ completion: (([PhotoModel]?, _ errorString: String?) -> Void)? = nil) {
        APIWebManager().getPhotoData(albumId: id) {[weak self] (result) in
            switch result {
            case .failure(let error):
                completion?(nil, error)
            case .success(let results):
                self?.photoData = results
                completion?(results, nil)
            }
        }
    }
}
