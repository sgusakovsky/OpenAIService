//
//  OpenAIApiClient.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

class OpenAIApiClient {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func makeRequest<ResponseModel: Codable>(
        request: URLRequest,
        networkQueue: DispatchQueue,
        responseQueue: DispatchQueue,
        completionHandler: @escaping (Result<ResponseModel, OpenAIAPIError>) -> Void
    ) {
        networkQueue.async { [weak self] in
            let task = self?.urlSession.dataTask(with: request) { (data, response, error) in
                responseQueue.async {
                    if let error = error {
                        completionHandler(.failure(.genericError(error: error)))
                    } else if let data = data {
                        do {
                            let response = try JSONDecoder().decode(ResponseModel.self, from: data)
                            completionHandler(.success(response))
                        } catch {
                            if let errorResponse = try? JSONDecoder().decode(ResponseError.self, from: data) {
                                completionHandler(.failure(.internalError(error: errorResponse.error)))
                            } else {
                                completionHandler(.failure(.decodingError(error: error)))
                            }
                        }
                    } else {
                        completionHandler(.failure(.noDataError))
                    }
                }
            }
            
            task?.resume()
        }
        
    }
    
    func prepareRequest<BodyType: Encodable>(
        _ endpoint: OpenAIEndpoint,
        body: BodyType,
        config: OpenAIConfiguration
    ) -> URLRequest? {
        guard let baseUrl = URL(string: endpoint.baseURL()) else {
            return nil
        }
        
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let organizationId = config.organizationId {
            request.setValue(organizationId, forHTTPHeaderField: "OpenAI-Organization")
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(body) {
            request.httpBody = encoded
        }
        
        return request
    }
    
    func prepareMultipartFormDataRequest(
        _ endpoint: OpenAIEndpoint,
        body: [String: Any],
        config: OpenAIConfiguration
    ) -> URLRequest? {
        
        let multipartRequest = MultipartFormDataRequest(endpoint: endpoint)
        
        for (key, value) in body {
            if let dataValue = value as? FormData {
                multipartRequest.addDataField(named: key, formData: dataValue)
            } else {
                multipartRequest.addTextField(named: key, value: "\(value)")
            }
        }
        
        guard var request = multipartRequest.asURLRequest() else {
            return nil
        }
        
        request.setValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        if let organizationId = config.organizationId {
            request.setValue(organizationId, forHTTPHeaderField: "OpenAI-Organization")
        }
        return request
    }
    
}
