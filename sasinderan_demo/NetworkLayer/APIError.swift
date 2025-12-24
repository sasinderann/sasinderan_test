//
//  APIError.swift
//  sasinderan_demo
//
//  Created by SASINDERAN N on 22/12/25.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodeFailed
    case internetUnAvailable
    case customError(String)
}
