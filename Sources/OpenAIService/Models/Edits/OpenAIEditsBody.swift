//
//  EditsBody.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

/// https://platform.openai.com/docs/api-reference/edits/create
public struct OpenAIEditsBody: Encodable {
    
    let model: OpenAIEditsModelType
    
    /// The input text to use as a starting point for the edit.
    let input: String?
    
    /// The instruction that tells the model how to edit the prompt.
    let instruction: String
    
    /// How many completions to generate for each prompt.
    /// Note: Because this parameter generates many completions, it can quickly consume your token quota.
    /// Use carefully and ensure that you have reasonable settings for max_tokens and stop.
    let completionsCount: Int?
    
    /// What sampling temperature to use, between 0 and 2.
    /// Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    let temperature: Double?
    
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass.
    /// So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    let nucleusSampling: Double?
    
    public init(
        model: OpenAIEditsModelType = .davinci,
        input: String? = "",
        instruction: String,
        completionsCount: Int? = 1,
        temperature: Double? = 1,
        nucleusSampling: Double? = 1
    ) {
        self.model = model
        self.input = input
        self.instruction = instruction
        self.completionsCount = completionsCount
        self.temperature = temperature
        self.nucleusSampling = nucleusSampling
    }
    
    enum CodingKeys: String, CodingKey {
        case model
        case input
        case instruction
        case completionsCount = "n"
        case temperature
        case nucleusSampling = "top_p"
    }
}
