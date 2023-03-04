//
//  OpenAIChatCompletionModelType.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

/// A set of models that can understand and generate natural language
public enum OpenAIChatModelType: String, Encodable {
    
    /// Most capable GPT-3.5 model and optimized for chat at 1/10th the cost of text-davinci-003. Will be updated with our latest model iteration.
    ///
    /// > Model Name: gpt-3.5-turbo
    case chatGPTTurbo = "gpt-3.5-turbo"
}
