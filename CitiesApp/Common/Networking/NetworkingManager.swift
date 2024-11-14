//
//  NetworkingManager.swift
//  CitiesApp
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import Foundation
import Combine

enum CitiesAppError: Error {
  case badURL
}

final class NetworkingManager {
  static func download(request: URLRequest) -> AnyPublisher<Data, Error> {
    return URLSession.shared.dataTaskPublisher(for: request)
      .subscribe(on: DispatchQueue.global(qos: .default))
      .tryMap({ try handleURLResponse(output: $0)})
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
    guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
      throw URLError(.badServerResponse)
    }
    return output.data
  }
}
