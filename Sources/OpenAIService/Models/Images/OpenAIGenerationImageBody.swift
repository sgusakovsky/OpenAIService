//
//  GenerateImageBody.swift
//  Passmate
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//  Copyright © 2023 Qulix Systems. All rights reserved.
//

import Foundation

/// https://platform.openai.com/docs/api-reference/images/create
public struct OpenAIGenerationImageBody: Encodable {
    
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    let prompt: String
    
    /// The number of images to generate. Must be between 1 and 10.
    let imageCount: Int?
    
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024
    let size: OpenAIGenerationImageSize?
    
    /// The format in which the generated images are returned. Must be one of url or b64_json.
    let responseFormat: OpenAIGenerationImageResponseFormat?
    
    let user: String?
    
    public init(
        prompt: String,
        imageCount: Int? = 1,
        size: OpenAIGenerationImageSize? = .large,
        responseFormat: OpenAIGenerationImageResponseFormat? = .url,
        user: String? = nil
    ) {
        self.prompt = prompt
        self.imageCount = imageCount
        self.size = size
        self.responseFormat = responseFormat
        self.user = user
    }
    
    enum CodingKeys: String, CodingKey {
        case prompt
        case imageCount = "n"
        case size
        case responseFormat = "response_format"
        case user
    }
}

public enum OpenAIGenerationImageSize: String, Encodable {
    case small = "256x256"
    case medium = "512x512"
    case large = "1024x1024"
}

public enum OpenAIGenerationImageResponseFormat: String, Encodable {
    case url
    case base64json
    
    enum CodingKeys: String, CodingKey {
        case url
        case base64json = "b64_json"
    }
}
