//
//  OpenAIGeneratedImagesResponse.swift
//  Passmate
//
//  Created by Gusakovsky, Sergey on 3.03.23.
//  Copyright © 2023 Qulix Systems. All rights reserved.
//

import Foundation

public struct OpenAIGenerationImageResponse: Codable {
   let data: [OpenAIGenerationImageData]
}

public struct OpenAIGenerationImageData: Codable {
   let url: String
}
