//
//  AlbumViewModel.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 02/05/21.
//

import Foundation

class AlbumViewModel {

    var albumData: [AlbumModel]?

    func numberOfRows() -> Int {
        return albumData?.count ?? 0
    }

    // MARK: Album API call
    func getAlbumData(_ completion: (([AlbumModel]?, _ errorString: String?) -> Void)? = nil) {
        APIWebManager().getAlbumData {[weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
                completion?(nil, error)
            case .success(let results):
                self?.albumData = results
                completion?(results, nil)
            }
        }
    }
}
