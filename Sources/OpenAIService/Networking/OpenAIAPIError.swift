//
//  OpenAIAPIError.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

enum OpenAIAPIError: Error {
    case internalError(error: InternalError)
    case genericError(error: Error)
    case decodingError(error: Error)
    case noDataError
}

struct RequestError: LocalizedError {
    var errorDescription: String {
        "Error creating the url"
    }
}

struct InternalError: LocalizedError, Decodable {
    let message: String
    let type: String
    let param: String?
    let code: String?
    
    var errorDescription: String {
        message
    }
}

struct ResponseError: Decodable {
    let error: InternalError
}
