//
//  MultipartFormDataRequest.swift
//  OpenAIDemo
//
//  Created by Gusakovsky, Sergey on 5.03.23.
//

import Foundation

struct MultipartFormDataRequest {
    private let boundary: String = UUID().uuidString
    private let body = NSMutableData()
    let endpoint: OpenAIEndpoint
    
    init(endpoint: OpenAIEndpoint) {
        self.endpoint = endpoint
    }
    
    func asURLRequest() -> URLRequest? {
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
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        self.body.append("--\(boundary)--")
        request.httpBody = self.body as Data

        return request
    }
    
    func addTextField(named name: String, value: String) {
        self.body.append(textFormField(named: name, value: value))
    }
    
    func addDataField(named name: String, formData: FormData) {
        self.body.append(dataFormField(named: name, formData: formData))
    }
    
    private func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }

    private func dataFormField(named name: String, formData: FormData) -> Data {
        let fieldData = NSMutableData()

        fieldData.append("--\(boundary)\r\n")
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(formData.fileName)\"\r\n")
        fieldData.append("Content-Type: \(formData.mimeType)\r\n")
        fieldData.append("\r\n")
        fieldData.append(formData.data)
        fieldData.append("\r\n")

        return fieldData as Data
    }
}

extension NSMutableData {
  func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
