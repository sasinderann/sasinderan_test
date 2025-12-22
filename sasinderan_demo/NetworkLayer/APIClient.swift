//
//  APIClient.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 22/12/25.
//

import Foundation


final class APIClient {

    func executeRequest<T: Decodable>(endpoint: EndPoints, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = endpoint.url else {
            return completion(.failure(NetworkError.invalidURL))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                return completion(.failure(error))
            }
            guard let data else {
                return completion(.failure(NetworkError.invalidResponse))
            }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(NetworkError.decodeFailed))
            }
        }.resume()
    }
}
