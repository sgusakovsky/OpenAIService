//
//  OpenAIImageVariationBody.swift
//  OpenAIDemo
//
//  Created by Gusakovsky, Sergey on 5.03.23.
//

import Foundation
#if os(iOS)
import UIKit
#endif

/// https://platform.openai.com/docs/api-reference/images/create-variation
public struct OpenAIImageVariationBody {
    public let image: FormData
    public let numberOfImages: Int
    public let size: OpenAIGenerationImageSize
    public let responseFormat: OpenAIGenerationImageResponseFormat
    public let user: String?
    
    public init(
        image: Data,
        numberOfImages: Int = 1,
        size: OpenAIGenerationImageSize = .large,
        responseFormat: OpenAIGenerationImageResponseFormat = .url,
        user: String? = nil
    ) {
        self.image = FormData(data: image, mimeType: "image/png", fileName: "image.png")
        self.numberOfImages = numberOfImages
        self.size = size
        self.responseFormat = responseFormat
        self.user = user
    }
    
    #if os(iOS)
    public init?(
        image: UIImage,
        numberOfImages: Int = 1,
        size: OpenAIGenerationImageSize = .large,
        responseFormat: OpenAIGenerationImageResponseFormat = .url,
        user: String? = nil
    ) {
        guard let imageData = image.pngData() else { return nil }
        self.image = FormData(data: imageData, mimeType: "image/png", fileName: "image.png")
        self.numberOfImages = numberOfImages
        self.size = size
        self.responseFormat = responseFormat
        self.user = user
    }
    #endif
    
    public var body: [String: Any] {
        var result: [String: Any] = [
            "image": self.image,
            "n": self.numberOfImages,
            "size": self.size.rawValue,
            "response_format": self.responseFormat.rawValue
        ]
        if let user = self.user {
            result["user"] = user
        }

        return result
    }
}
