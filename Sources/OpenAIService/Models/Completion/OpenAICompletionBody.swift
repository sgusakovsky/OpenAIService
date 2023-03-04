//
//  CompletionBody.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation

/// https://platform.openai.com/docs/api-reference/completions
public struct OpenAICompletionBody: Encodable {
    
    public let model: OpenAICompletionModelType
    
    /// The prompt(s) to generate completions for, encoded as a string, array of strings, array of tokens, or array of token arrays.
    public let prompt: String
    
    /// The suffix that comes after a completion of inserted text.
    public let suffix: String?
    
    /// The token count of your prompt plus max_tokens cannot exceed the model's context length.
    /// Most models have a context length of 2048 tokens (except for the newest models, which support 4096).
    public let maxTokens: Int?
    
    /// What sampling temperature to use, between 0 and 2.
    /// Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    public let temperature: Double?
    
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass.
    /// So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    public let nucleusSampling: Double?
    
    /// How many completions to generate for each prompt.
    /// Note: Because this parameter generates many completions, it can quickly consume your token quota.
    /// Use carefully and ensure that you have reasonable settings for max_tokens and stop.
    public let completionsCount: Int?
    
    /// Include the log probabilities on the logprobs most likely tokens, as well the chosen tokens.
    /// For example, if logprobs is 5, the API will return a list of the 5 most likely tokens.
    /// The API will always return the logprob of the sampled token, so there may be up to logprobs+1 elements in the response.
    public let logprobs: Int?
    
    /// Echo back the prompt in addition to the completion
    public let echo: Bool?
    
    /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
    public let stop: String?
    
    /// Number between -2.0 and 2.0.
    /// Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
    public let presencePenalty: Double?
    
    /// Number between -2.0 and 2.0.
    /// Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
    public let frequencyPenalty: Double?
    
    /// Generates best_of completions server-side and returns the "best" (the one with the highest log probability per token). Results cannot be streamed.
    /// When used with n, best_of controls the number of candidate completions and n specifies how many to return – best_of must be greater than n.
    /// Note: Because this parameter generates many completions, it can quickly consume your token quota.
    /// Use carefully and ensure that you have reasonable settings for max_tokens and stop.
    public let bestOf: Int?
    
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse
    public let user: String?
    
    public init(
        model: OpenAICompletionModelType = .davinci,
        prompt: String,
        suffix: String? = nil,
        maxTokens: Int? = 16,
        temperature: Double? = 1,
        nucleusSampling: Double? = 1,
        completionsCount: Int? = 1,
        logprobs: Int? = nil,
        echo: Bool? = false,
        stop: String? = nil,
        presencePenalty: Double? = 0,
        frequencyPenalty: Double? = 0,
        bestOf: Int? = 1,
        user: String? = nil
    ) {
        self.model = model
        self.prompt = prompt
        self.suffix = suffix
        self.maxTokens = maxTokens
        self.temperature = temperature
        self.nucleusSampling = nucleusSampling
        self.completionsCount = completionsCount
        self.logprobs = logprobs
        self.echo = echo
        self.stop = stop
        self.presencePenalty = presencePenalty
        self.frequencyPenalty = frequencyPenalty
        self.bestOf = bestOf
        self.user = user
    }
    
    enum CodingKeys: String, CodingKey {
        case prompt
        case model
        case maxTokens = "max_tokens"
        case temperature
        case nucleusSampling = "top_p"
        case completionsCount = "n"
        case logprobs
        case echo
        case stop
        case presencePenalty = "presence_penalty"
        case frequencyPenalty = "frequency_penalty"
        case bestOf = "best_of"
        case user
    }
}
