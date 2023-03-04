//
//  OpenAICompletionModelType.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

/// A set of models that can understand and generate natural language
enum OpenAICompletionModelType: String, Encodable {
    
    /// Most capable GPT-3 model. Can do any task the other models can do, often with higher quality, longer output and better instruction-following. Also supports inserting completions within text.
    ///
    /// > Model Name: text-davinci-003
    case davinci = "text-davinci-003"
    
    /// Very capable, but faster and lower cost than GPT3 ``davinci``.
    ///
    /// > Model Name: text-curie-001
    case curie = "text-curie-001"
    
    /// Capable of straightforward tasks, very fast, and lower cost.
    ///
    /// > Model Name: text-babbage-001
    case babbage = "text-babbage-001"
    
    /// Capable of very simple tasks, usually the fastest model in the GPT-3 series, and lowest cost.
    ///
    /// > Model Name: text-ada-001
    case ada = "text-ada-001"    
}
