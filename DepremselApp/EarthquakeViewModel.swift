//
//  EarthquakeViewModel.swift
//  FayHat
//
//  Created by enes öztürk on 6.04.2023.
//

import Foundation

// protocol EarthQuakeManagerDelegate {
//    func didParseData(_ EarthquakeViewModel: EarthquakeViewModel, earthquake: Result)
// }

enum LoadingState {
    case loading
    case loaded
    case error(String)
}

class EarthquakeViewModel {
    var earthQuakes = [Result]()
    var loadingState: LoadingState = .loading

    func fetchJSON(completion: @escaping ([Result]) -> Void) {
        loadingState = .loading

        let url = URL(string: "https://api.orhanaydogdu.com.tr/deprem/kandilli/live")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let eResult: EarthQuake = try decoder.decode(EarthQuake.self, from: data)
                    for result in eResult.result {
                        let id = result.id
                        let earthquakeID = result.earthquakeID
                        let title = result.title
                        let date = result.date
                        let mag = result.mag
                        let depth = result.depth
                        let geojson = result.geojson
                        let updateArray = Result(id: id, earthquakeID: earthquakeID, title: title, date: date, mag: mag, depth: depth, geojson: geojson)
                        self.earthQuakes.append(updateArray)
                        completion(self.earthQuakes)
                    }

                    self.loadingState = .loaded

                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                self.loadingState = .error("it was an error while getting data")
                print("Error fetching data: \(error)")
            }
        }
        task.resume()
    }
}
