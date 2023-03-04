//
//  OpenAIEndpoint.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

enum OpenAIEndpoint {
    case completions
    case edits
    case chatCompletions
    case imagesGenerations
    
    var path: String {
        switch self {
        case .completions:
            return "/v1/completions"
        case .edits:
            return "/v1/edits"
        case .chatCompletions:
            return "/v1/chat/completions"
        case .imagesGenerations:
            return "/v1/images/generations"
        }
    }
    
    var method: String {
        switch self {
        case .completions, .edits, .chatCompletions, .imagesGenerations:
            return "POST"
        }
    }
    
    func baseURL() -> String {
        switch self {
        case .completions, .edits, .chatCompletions, .imagesGenerations:
            return "https://api.openai.com"
        }
    }
}
