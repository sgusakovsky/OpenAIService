//
//  OpenAIService.swift
//  OpenAIAPI
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//

import Foundation
#if canImport(FoundationNetworking) && canImport(FoundationXML)
import FoundationNetworking
import FoundationXML
#endif

public final class OpenAIService {
    private let token: String
    private let apiClient: OpenAIApiClient
    
    
    public init(authToken: String, apiClient: OpenAIApiClient = OpenAIApiClient()) {
        self.token = authToken
        self.apiClient = apiClient
    }
    
    /// Send a Completion to the OpenAI API
    /// - Parameters:
    ///   - body: Body of comletion request
    ///   - completionHandler: Returns an OpenAICompletionResponse Data Model
    public func sendCompletion(
        with body: OpenAICompletionBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<OpenAICompletionResponse, OpenAIAPIError>) -> Void
    ) {
        let endpoint = OpenAIEndpoint.completions
        guard let request = apiClient.prepareRequest(endpoint, body: body, token: token) else {
            completionHandler(.failure(.genericError(error: RequestError())))
            return
        }
        
        apiClient.makeRequest(
            request: request,
            networkQueue: networkQueue,
            responseQueue: responseQueue,
            completionHandler: completionHandler
        )
    }
    
    /// Send a Chat Completion to the OpenAI API
    /// - Parameters:
    ///   - body: Body of chat completion request
    ///   - completionHandler: Returns an OpenAIChatResponse Data Model
    public func sendChat(
        with body: OpenAIChatBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<OpenAIChatResponse, OpenAIAPIError>) -> Void
    ) {
        let endpoint = OpenAIEndpoint.chatCompletions
        guard let request = apiClient.prepareRequest(endpoint, body: body, token: token) else {
            completionHandler(.failure(.genericError(error: RequestError())))
            return
        }

        apiClient.makeRequest(
            request: request,
            networkQueue: networkQueue,
            responseQueue: responseQueue,
            completionHandler: completionHandler
        )
    }
    
    /// Send a Edit request to the OpenAI API
    /// - Parameters:
    ///   - input: The input text to use as a starting point for the edit.
    ///   - model: The AI Model to Use. Set to `OpenAIEditsModelType.feature(.davinci)` by default which is the most capable model
    ///   - instruction: The instruction that tells the model how to edit the prompt.
    ///   - completionHandler: Returns an OpenAIEditsResponse Data Model
    public func sendEdits(
        with body: OpenAIEditsBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<OpenAIEditsResponse, OpenAIAPIError>) -> Void
    ) {
        let endpoint = OpenAIEndpoint.edits
        guard let request = apiClient.prepareRequest(endpoint, body: body, token: token) else {
            completionHandler(.failure(.genericError(error: RequestError())))
            return
        }
        apiClient.makeRequest(
            request: request,
            networkQueue: networkQueue,
            responseQueue: responseQueue,
            completionHandler: completionHandler
        )
    }
    
    /// Send a Image generation request to the OpenAI API
    /// - Parameters:
    ///   - prompt: A text description of the desired image(s). The maximum length is 1000 characters.
    ///   - imageSize: Size of expected image to Use. Set to `OpenAIGenerationImageSize.large` by default.
    ///   - user: A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    ///   - completionHandler: Returns an OpenAIGenerationImageResponse Data Model
    public func sendImageGeneration(
        with body: OpenAIGenerationImageBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<OpenAIGenerationImageResponse, OpenAIAPIError>) -> Void
    ) {
        let endpoint = OpenAIEndpoint.imagesGenerations
        guard let request = apiClient.prepareRequest(endpoint, body: body, token: token) else {
            completionHandler(.failure(.genericError(error: RequestError())))
            return
        }
        apiClient.makeRequest(
            request: request,
            networkQueue: networkQueue,
            responseQueue: responseQueue,
            completionHandler: completionHandler
        )
    }
    
    
    /// Send a Completion to the OpenAI API
    /// - Parameters:
    ///   - prompt: The Text Prompt
    ///   - model: The AI Model to Use. Set to `OpenAICompletionModelType.gpt3(.davinci)` by default which is the most capable model
    ///   - maxTokens: The limit character for the returned response, defaults to 16 as per the API
    ///   - temperature: What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    ///   - user: A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    /// - Returns: Returns an OpenAICompletionResponse Data Model
    @available(swift 5.5)
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    public func sendCompletion(
        with body: OpenAICompletionBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main
    ) async throws -> OpenAICompletionResponse {
        return try await withCheckedThrowingContinuation { continuation in
            sendCompletion(
                with: body,
                networkQueue: networkQueue,
                responseQueue: responseQueue
            ) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Send a Chat Completion to the OpenAI API
    /// - Parameters:
    ///   - body: Body of chat completion request
    /// - Returns: Returns an OpenAIChatResponse Data Model
    @available(swift 5.5)
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    public func sendChat(
        with body: OpenAIChatBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main
    ) async throws -> OpenAIChatResponse {
        return try await withCheckedThrowingContinuation { continuation in
            sendChat(
                with: body,
                networkQueue: networkQueue,
                responseQueue: responseQueue
            ) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Send a Edit request to the OpenAI API
    /// - Parameters:
    ///   - input: The input text to use as a starting point for the edit.
    ///   - model: The AI Model to Use. Set to `OpenAIEditsModelType.feature(.davinci)` by default which is the most capable model
    ///   - instruction: The instruction that tells the model how to edit the prompt.
    /// - Returns: Returns an OpenAIEditsResponse Data Model
    @available(swift 5.5)
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    public func sendEdits(
        with body: OpenAIEditsBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main
    ) async throws -> OpenAIEditsResponse {
        return try await withCheckedThrowingContinuation { continuation in
            sendEdits(
                with: body,
                networkQueue: networkQueue,
                responseQueue: responseQueue
            ) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Send a Image generation request to the OpenAI API
    /// - Parameters:
    ///   - prompt: A text description of the desired image(s). The maximum length is 1000 characters.
    ///   - imageSize: Size of expected image to Use. Set to `OpenAIGenerationImageSize.large` by default.
    ///   - user: A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    /// - Returns: Returns an OpenAIGenerationImageResponse Data Model
    @available(swift 5.5)
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    public func sendImageGeneration(
        with body: OpenAIGenerationImageBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main
    ) async throws -> OpenAIGenerationImageResponse {
        return try await withCheckedThrowingContinuation { continuation in
            sendImageGeneration(
                with: body,
                networkQueue: networkQueue,
                responseQueue: responseQueue
            ) { result in
                continuation.resume(with: result)
            }
        }
    }
}
