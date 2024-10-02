//
//  MBAPIManager.swift
//  MediBuddy
//
//  Created by Sunny Jha on 29/09/24.
//

import Foundation

enum HttpMethod: String {
    case GET, POST, PUT, DELETE, PATCH
}

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
    case serializationError(Error)
    case parsingFailed
}

class MBAPIManager {
    static let shared = MBAPIManager()
    
        func request(url: String, httpMethod: HttpMethod, queryParams: [String: String]? = nil, customHttpHeaders: [String: Any]? = nil, requestBody: [String: Any]? = nil, completion: @escaping (Result<Data, APIError>) -> Void) {
            
            // Create URLRequest object
            guard let request = createRequest(url: url, httpMethod: httpMethod, queryParams: queryParams, customHttpHeaders: customHttpHeaders, requestBody: requestBody) else {
                completion(.failure(.invalidURL))
                return
            }
            
            // Perform network request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                // Handle error case
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }
                
                // Check for valid HTTP response
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                // Handle data
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                // Success
                completion(.success(data))
            }
            task.resume()
        }
        
        // Private function to create a request
        private func createRequest(url: String, httpMethod: HttpMethod, queryParams: [String: String]? = nil, customHttpHeaders: [String: Any]? = nil, requestBody: [String: Any]? = nil) -> URLRequest? {
            
            // Handle query parameters
            var finalUrl = url
            if let queryParams = queryParams, var urlComponents = URLComponents(string: url) {
                urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
                finalUrl = urlComponents.url?.absoluteString ?? url
            }
            
            // Create the URL and guard against nil values
            guard let requestUrl = URL(string: finalUrl) else {
                return nil
            }
            
            // Create URLRequest object
            var request = URLRequest(url: requestUrl)
            request.httpMethod = httpMethod.rawValue
            
            // Add custom headers
            if let headers = customHttpHeaders {
                for (key, value) in headers {
                    request.setValue("\(value)", forHTTPHeaderField: key)
                }
            }
            
            // Add request body for applicable methods
            if let requestBody = requestBody, [.POST, .PUT, .PATCH].contains(httpMethod) {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                } catch {
                    print("Error serializing request body: \(error)")
                    return nil
                }
            }
            
            return request
        }
    }


