//
//  OpenAIEditsResponse.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

struct OpenAIEditsResponse: Codable {
    let object: String
    let created: Int
    let choices: [OpenAIEditsChoice]
}

struct OpenAIEditsChoice: Codable {
    let text: String
    let index: Int
}
