//
//  OpenAICompletionResponse.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

struct OpenAICompletionResponse: Codable {
    let id: String
    let object: String
    let model: String
    let created: Int
    let choices: [OpenAICompletionChoice]
}

struct OpenAICompletionChoice: Codable {
    let text: String
    let index: Int
    let finishReason: String
    
    
    enum CodingKeys: String, CodingKey {
        case text
        case index
        case finishReason = "finish_reason"
    }
}
