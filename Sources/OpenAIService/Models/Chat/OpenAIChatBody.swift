//
//  ChatCompletionBody.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

/// https://platform.openai.com/docs/api-reference/chat/create
struct OpenAIChatBody: Encodable {
    
    /// The messages to generate chat completions for, in the chat format.
    let messages: [OpenAIChatMessage]
    
    /// ID of the model to use. Currently, only gpt-3.5-turbo and gpt-3.5-turbo-0301 are supported.
    let model: OpenAIChatModelType
    
    /// What sampling temperature to use, between 0 and 2.
    /// Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic
    let temperature: Double?
    
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass.
    /// So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    let nucleusSampling: Double?
    
    /// How many completions to generate for each prompt.
    /// Note: Because this parameter generates many completions, it can quickly consume your token quota.
    /// Use carefully and ensure that you have reasonable settings for max_tokens and stop.
    let completionsCount: Int?
    
    /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
    let stop: String?
    
    /// The token count of your prompt plus max_tokens cannot exceed the model's context length.
    /// Most models have a context length of 2048 tokens (except for the newest models, which support 4096).
    let maxTokens: Int?
    
    /// Number between -2.0 and 2.0.
    /// Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
    let presencePenalty: Double?
    
    /// Number between -2.0 and 2.0.
    /// Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
    let frequencyPenalty: Double?
    
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse
    let user: String?
    
    init(
        messages: [OpenAIChatMessage],
        model: OpenAIChatModelType = .chatGPTTurbo,
        temperature: Double? = 1,
        nucleusSampling: Double? = 1,
        completionsCount: Int? = 1,
        stop: String? = nil,
        maxTokens: Int? = 16,
        presencePenalty: Double? = 0,
        frequencyPenalty: Double? = 0,
        user: String? = nil
    ) {
        self.messages = messages
        self.model = model
        self.temperature = temperature
        self.nucleusSampling = nucleusSampling
        self.completionsCount = completionsCount
        self.stop = stop
        self.maxTokens = maxTokens
        self.presencePenalty = presencePenalty
        self.frequencyPenalty = frequencyPenalty
        self.user = user
    }
    
    enum CodingKeys: String, CodingKey {
        case messages
        case model
        case temperature
        case nucleusSampling = "top_p"
        case completionsCount = "n"
        case stop
        case maxTokens = "max_tokens"
        case presencePenalty = "presence_penalty"
        case frequencyPenalty = "frequency_penalty"
        case user
    }
}

struct OpenAIChatMessage: Codable {
    var role: OpenAIChatMessageRole
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case role
        case content
    }
}

enum OpenAIChatMessageRole: String, Codable {
    case system
    case user
    case assistant
}
