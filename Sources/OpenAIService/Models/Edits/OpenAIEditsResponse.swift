//
//  OpenAIEditsResponse.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

public struct OpenAIEditsResponse: Codable {
    public let object: String
    public let created: Int
    public let choices: [OpenAIEditsChoice]
}

public struct OpenAIEditsChoice: Codable {
    public let text: String
    public let index: Int
}
