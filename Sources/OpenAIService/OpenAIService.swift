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
    private let config: OpenAIConfiguration
    private let apiClient: OpenAIApiClient
    
    
    public init(config: OpenAIConfiguration, urlSession: URLSession = .shared) {
        self.config = config
        self.apiClient = OpenAIApiClient(urlSession: urlSession)
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
        guard let request = apiClient.prepareRequest(endpoint, body: body, config: config) else {
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
        guard let request = apiClient.prepareRequest(endpoint, body: body, config: config) else {
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
    ///   - body: Body of chat completion request
    ///   - completionHandler: Returns an OpenAIEditsResponse Data Model
    public func sendEdits(
        with body: OpenAIEditsBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<OpenAIEditsResponse, OpenAIAPIError>) -> Void
    ) {
        let endpoint = OpenAIEndpoint.edits
        guard let request = apiClient.prepareRequest(endpoint, body: body, config: config) else {
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
    ///   - body: Body of chat completion request
    ///   - completionHandler: Returns an OpenAIGenerationImageResponse Data Model
    public func sendImageGeneration(
        with body: OpenAIGenerationImageBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<OpenAIGenerationImageResponse, OpenAIAPIError>) -> Void
    ) {
        let endpoint = OpenAIEndpoint.imagesGenerations
        guard let request = apiClient.prepareRequest(endpoint, body: body, config: config) else {
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
    
    /// Send a Image edits request to the OpenAI API
    /// - Parameters:
    ///   - body: Body of chat completion request
    ///   - completionHandler: Returns an OpenAIGenerationImageResponse Data Model
    public func sendImageEdits(
        with body: OpenAIImageEditsBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<OpenAIGenerationImageResponse, OpenAIAPIError>) -> Void
    ) {
        let endpoint = OpenAIEndpoint.imageEdits
        guard let request = apiClient.prepareMultipartFormDataRequest(endpoint, body: body.body, config: config) else {
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
    ///   - body: Body of chat completion request
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
    ///   - body: Body of chat completion request
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
    ///   - body: Body of chat completion request
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
    
    /// Send a Image edits request to the OpenAI API
    /// - Parameters:
    ///   - body: Body of chat completion request
    /// - Returns: Returns an OpenAIGenerationImageResponse Data Model
    @available(swift 5.5)
    @available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
    public func sendImageEdits(
        with body: OpenAIImageEditsBody,
        networkQueue: DispatchQueue = .global(qos: .background),
        responseQueue: DispatchQueue = .main
    ) async throws -> OpenAIGenerationImageResponse {
        return try await withCheckedThrowingContinuation { continuation in
            sendImageEdits(
                with: body,
                networkQueue: networkQueue,
                responseQueue: responseQueue
            ) { result in
                continuation.resume(with: result)
            }
        }
    }
}
