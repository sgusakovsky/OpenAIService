//
//  OpenAIAPIError.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

public enum OpenAIAPIError: Error {
    case internalError(error: InternalError)
    case genericError(error: Error)
    case decodingError(error: Error)
    case noDataError
}

public struct RequestError: LocalizedError {
    public var errorDescription: String {
        "Error creating the url"
    }
}

public struct InternalError: LocalizedError, Decodable {
    public let message: String
    public let type: String
    public let param: String?
    public let code: String?
    
    public var errorDescription: String {
        message
    }
}

public struct ResponseError: Decodable {
    public let error: InternalError
}
