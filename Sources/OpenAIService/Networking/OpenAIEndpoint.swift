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
    case imageEdits
    case imageVariation
    case audioTranscriptions
    case audioTranslations
    
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
        case .imageEdits:
            return "/v1/images/edits"
        case .imageVariation:
            return "/v1/images/variations"
        case .audioTranscriptions:
            return "/v1/audio/transcriptions"
        case .audioTranslations:
            return "/v1/audio/translations"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .completions, .edits, .chatCompletions, .imagesGenerations, .imageEdits, .imageVariation, .audioTranscriptions, .audioTranslations:
            return .post
        }
    }
    
    func baseURL() -> String {
        switch self {
        case .completions, .edits, .chatCompletions, .imagesGenerations, .imageEdits, .imageVariation, .audioTranscriptions, .audioTranslations:
            return "https://api.openai.com"
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
