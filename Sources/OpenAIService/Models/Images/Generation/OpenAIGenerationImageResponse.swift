//
//  OpenAIGeneratedImagesResponse.swift
//  Passmate
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//  Copyright © 2023 Qulix Systems. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#endif

public struct OpenAIGenerationImageResponse: Codable {
    public let data: [OpenAIGenerationImageData]
}

public enum OpenAIGenerationImageData: Codable {
    case url(String)
    case base64(String)
    
    enum CodingKeys: String, CodingKey {
        case url
        case base64 = "b64_json"
    }
    
    public var imageData: String {
        switch self {
        case let .base64(b64Json): return b64Json
        case let .url(url): return url
        }
    }
    
    #if os(iOS)
    public var image: UIImage? {
        switch self {
        case .base64(let b64Json):
            return DataDecoder().decodeBase64Image(b64Json)
        case .url(_):
            return nil
        }
    }
    #endif
    
    public var url: URL? {
        switch self {
        case .url(let urlString):
            if let url = URL(string: urlString) {
                return url
            }
            return nil
        case .base64(_):
            return nil
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            let urlAssociate = try container.decode(String.self, forKey: .url)
            self = .url(urlAssociate)
        } catch {
            let b64Associate = try container.decode(String.self, forKey: .base64)
            self = .base64(b64Associate)
        }
    }
}
