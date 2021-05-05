//
//  WebManager.swift
//  MediaMonks_Aditya
//
//  Created by aditya.raj.gupta on 02/05/21.
//
//

import UIKit
import Foundation

enum Result<T> {
    case success(T)
    case failure(String)
}

enum NetworkError: Error {
    case network
    case response
    case decoding

    var reason: String {
        switch self {
        case .network:
            return "No Internet connection, \n Please check connectivity"
        case .response:
            return "An error occurred while fetching data"
        case .decoding:
            return "An error occurred while decoding data \n Please try again"
        }
    }
}


class APIWebManager {

    private let session: URLSession
    private var _dataTask: URLSessionDataTask?

    init(session: URLSession = URLSession(configuration: .default)) {
          self.session = session
    }

    // Album Data Api
    func getAlbumData(completion: @escaping (Result<[AlbumModel]>) -> Void) {

        guard let url = URL(string: (Constants.baseURL + Constants.albums)) else { return }
        _dataTask?.cancel()

        let request = URLRequest(url: url)
        _dataTask = session.dataTask(with: request) { data, response, error in
            defer { self._dataTask = nil }

            guard let httpResponse = response as? HTTPURLResponse  else {
                completion(Result.failure(NetworkError.network.reason))
                return
            }
            guard
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(NetworkError.response.reason))
                    return
            }
            guard
                let decodedResponse = try? JSONDecoder().decode([AlbumModel].self, from: data) else {
                    completion(Result.failure(NetworkError.decoding.reason))
                    return
            }
            completion(Result.success(decodedResponse))
        }
        _dataTask?.resume()
      }

    // Photo Data API
    func getPhotoData(albumId: Int, completion: @escaping (Result<[PhotoModel]>) -> Void) {
        guard let url = URL(string: (Constants.baseURL + Constants.photos + "?albumId=\(albumId)")) else { return }
        _dataTask?.cancel()

        let request = URLRequest(url: url)
        _dataTask = session.dataTask(with: request) { data, response, error in
            defer { self._dataTask = nil }

            guard let httpResponse = response as? HTTPURLResponse  else {
                completion(Result.failure(NetworkError.network.reason))
                return
            }
            guard
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(NetworkError.response.reason))
                    return
            }
            guard
                let decodedResponse = try? JSONDecoder().decode([PhotoModel].self, from: data) else {
                    completion(Result.failure(NetworkError.decoding.reason))
                    return
            }
            completion(Result.success(decodedResponse))
        }
        _dataTask?.resume()
    }


}

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}

