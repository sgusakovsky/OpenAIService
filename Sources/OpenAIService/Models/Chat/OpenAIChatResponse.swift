//
//  OpenAIChatCompletionResponse.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

public struct OpenAIChatResponse: Codable {
    public let id: String
    public let object: String
    public let created: Int
    public let choices: [OpenAIChatChoice]
}

public struct OpenAIChatChoice: Codable {
    public let index: Int
    public let message: OpenAIChatMessage
    public let finishReason: String
    
    enum CodingKeys: String, CodingKey {
        case index
        case message
        case finishReason = "finish_reason"
    }
}
