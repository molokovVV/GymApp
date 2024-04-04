//
//  NetworkService.swift
//  GymApp
//
//  Created by Виталик Молоков on 04.04.2024.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init() {}

    func fetchExercises(completion: @escaping ([Exercise]?, Error?) -> Void) {
        let urlString = "https://api-ninjas.com/api/exercises"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue("YOUR_API_KEY", forHTTPHeaderField: "X-Api-Key")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "DataError", code: -1, userInfo: nil))
                }
                return
            }

            do {
                let exercises = try JSONDecoder().decode([Exercise].self, from: data)
                DispatchQueue.main.async {
                    completion(exercises, nil)
                }
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(nil, jsonError)
                }
            }
        }.resume()
    }
}

