//
//  OpenAICompletionResponse.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

public struct OpenAICompletionResponse: Codable {
    public let id: String
    public let object: String
    public let model: String
    public let created: Int
    public let choices: [OpenAICompletionChoice]
}

public struct OpenAICompletionChoice: Codable {
    public let text: String
    public let index: Int
    public let finishReason: String
    
    
    enum CodingKeys: String, CodingKey {
        case text
        case index
        case finishReason = "finish_reason"
    }
}
