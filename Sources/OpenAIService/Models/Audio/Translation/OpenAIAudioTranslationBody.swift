//
//  OpenAIAudioTranslationBody.swift
//  OpenAIDemo
//
//  Created by Gusakovsky, Sergey on 5.03.23.
//

import Foundation

/// https://platform.openai.com/docs/api-reference/audio/create
/// Translates audio into English.
public struct OpenAIAudioTranslationBody {
    public let file: FormData
    public let model: OpenAIAudioModelType
    public let prompt: String?
    public let temperature: Double
    
    public init(
        file: Data,
        fileFormat: AudioFileFormat,
        model: OpenAIAudioModelType = .whisper,
        prompt: String? = nil,
        temperature: Double = 0
    ) {
        self.file = FormData(data: file, mimeType: fileFormat.mimeType, fileName: "audio.\(fileFormat.rawValue)")
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
    }
    
    public var body: [String: Any] {
        var result: [String: Any] = [
            "file": self.file,
            "model": self.model.rawValue,
            "temperature": self.temperature
        ]
        
        if let prompt = self.prompt {
            result["prompt"] = prompt
        }

        return result
    }
}
