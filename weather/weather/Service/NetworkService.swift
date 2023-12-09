//
//  NetworkService.swift
//  weather
//
//  Created by Kr Qqq on 09.12.2023.
//

import Foundation

//struct NetworkService {
//
//    static func requestJSONDecoder(appConfiguration: AppConfiguration, completion: @escaping (Result<Any, Error>) -> Void) {
//        
//        let url = appConfiguration.url!
//        let session = URLSession.shared
//        
//        let task = session.dataTask(with: url) { data, response, error in
//            
//            if let error {
//                completion(.failure(NetworkError.error(error.localizedDescription)))
//                return
//            }
//            
//            if let httpResponse = response as? HTTPURLResponse {
//                if httpResponse.statusCode != 200 {
//                    completion(.failure(NetworkError.error(String(httpResponse.statusCode))))
//                    return
//                }
//            }
//            
//            guard let data else {
//                completion(.failure(NetworkError.emptyData))
//                return
//            }
//        
//            let decoder = JSONDecoder()
//            do {
//                switch appConfiguration {
//                case .chucknorrisRandom:
//                    let dataDecode = try decoder.decode(Quote.self, from: data)
//                    completion(.success(dataDecode))
//                }
//                
//            } catch {
//                completion(.failure(NetworkError.parseError))
//            }
//        }
//        task.resume()
//    }
//
//}
//
//enum AppConfiguration: String, CaseIterable {
//    case chucknorrisRandom = "https://api.chucknorris.io/jokes/random"
//    var url: URL? {
//        URL(string: self.rawValue)
//    }
//}
