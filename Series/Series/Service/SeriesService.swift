//
//  SeriesService.swift
//  Series
//
//  Created by Miguel Vicario on 2/17/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class SeriesService {
    
    let baseURLString = "https://api.tvmaze.com"
    let jsonDecoder = JSONDecoder()
    
    func getSeries(query: String, completion: @escaping ([Serie]?) -> Void) {
        getData(endPoint: .search(query: query)) { (data) in
            if let intermediateModel = try? self.jsonDecoder.decode(Array<SerieIntermediate>.self, from: data) {
                let series = intermediateModel.map({$0.serie})
                DispatchQueue.main.async { completion(series) }
            } else {
                print("Error")
                DispatchQueue.main.async {completion (nil) }
            }
        }
    }
    
    func getEpisodes(serieID: String, completion: @escaping ([Episode]?) -> Void) {
        getData(endPoint: .episodes(serieID: serieID)) { (data) in
            if let episodes = try? self.jsonDecoder.decode(Array<Episode>.self, from: data) {
                DispatchQueue.main.async { completion(episodes) }
            } else { DispatchQueue.main.async { completion (nil) } }
        }
    }
    
    func getImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { completion(image) }
            } else {
                print("Error")
                DispatchQueue.main.async{ completion(nil) }
                }
            }
        task.resume()
    }
    
    func getData(endPoint: EndPoint, completion: @escaping (Data) -> Void ) {
        let urlString = baseURLString + endPoint.path()
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {completion(data)}
            }
        }
        task.resume()
    }
}

enum EndPoint{
    case search(query: String)
    case episodes(serieID: String)
    
    func path() -> String {
        switch self {
        case .search (let query):
            return "/search/shows?q=" + query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        case .episodes (let id):
            return "/shows/\(id)/episodes"
        }
    }
}
