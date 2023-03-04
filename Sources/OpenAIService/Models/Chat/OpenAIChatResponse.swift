//
//  OpenAIChatCompletionResponse.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

public struct OpenAIChatResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let choices: [OpenAIChatChoice]
}

public struct OpenAIChatChoice: Codable {
    let index: Int
    let message: OpenAIChatMessage
    let finishReason: String
    
    enum CodingKeys: String, CodingKey {
        case index
        case message
        case finishReason = "finish_reason"
    }
}
