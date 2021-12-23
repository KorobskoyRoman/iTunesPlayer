//
//  NetworkManager.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 23.12.2021.
//

import UIKit
import Alamofire

class NetworkManager {
    
    func fetchTracks(searchText: String, completion: @escaping (TrackModel?) -> Void) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term":"\(searchText)", "limit":"10", "media":"music"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { dataResponse in
            
            if let error = dataResponse.error {
                print("Ошибка получения данных: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(TrackModel.self, from: data)
                
                print("objects: \(objects)")
                completion(objects)
                
            } catch let jsonError {
                
                print("Ошибка декодирования JSON", jsonError)
                completion(nil)
            }
        }
    }
}
