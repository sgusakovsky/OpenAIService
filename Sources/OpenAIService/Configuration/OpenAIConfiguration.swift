//
//  OpenAIConfiguration.swift
//  OpenAIDemo
//
//  Created by Gusakovsky, Sergey on 4.03.23.
//

import Foundation

public struct OpenAIConfiguration {
    /// The organization ID of the user.
    public let organizationId: String

    /// The API key associated with the user.
    let apiKey: String

    public init(organizationId: String, apiKey: String) {
        self.organizationId = organizationId
        self.apiKey = apiKey
    }
}
