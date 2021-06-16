//
//  BaconIpsumServiceEndpoint.swift
//  TextPlayground
//
//  Created by Jonas Simkus on 15/06/2021.
//

import Foundation
import Combine

enum BaconIpsumServiceEndpoint {

    case getBaconIpsum

    static let baseUrl: URL = URL(string: "https://baconipsum.com/api")!

    var path: String {
        switch self {
        case .getBaconIpsum: return "/"
        }
    }

    func queryItems(_ customQueries: [String: String]? = nil) -> [URLQueryItem] {
        switch self {
        case .getBaconIpsum:
            // Default values: "/?type=all-meat&paras=1&start-with-lorem=1"
            var queries: [String: String] = ["type": "all-meat", "paras": "1", "start-with-lorem": "1"]
            customQueries?.forEach({ queries[$0.key] = $0.value })
            return queries.map({ URLQueryItem(name: $0.key, value: $0.value) })
        }
    }

    func getURLRequest() throws -> URLRequest {
        guard var components = URLComponents(url: Self.baseUrl.appendingPathComponent(self.path), resolvingAgainstBaseURL: true) else {
            throw DataServiceError.unableToCreateURLComponents
        }
        components.queryItems = self.queryItems()
        guard let url = components.url else {
            throw DataServiceError.unableToCreateURL
        }
        return URLRequest(url: url)
    }
}
