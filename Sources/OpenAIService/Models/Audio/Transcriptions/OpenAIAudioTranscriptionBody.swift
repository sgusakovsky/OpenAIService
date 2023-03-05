//
//  OpenAIAudioTranscriptionBody.swift
//  OpenAIDemo
//
//  Created by Gusakovsky, Sergey on 5.03.23.
//

import Foundation

/// https://platform.openai.com/docs/api-reference/audio/create
public struct OpenAIAudioTranscriptionBody {
    public let file: FormData
    public let model: OpenAIAudioModelType
    public let prompt: String?
    public let temperature: Double
    public let language: String?
    
    public init(
        file: Data,
        fileFormat: AudioFileFormat,
        model: OpenAIAudioModelType = .whisper,
        prompt: String? = nil,
        temperature: Double = 0,
        language: String? = nil
    ) {
        self.file = FormData(data: file, mimeType: fileFormat.mimeType, fileName: "aiduo.\(fileFormat.rawValue)")
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
        self.language = language
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
        
        if let language = self.language {
            result["language"] = language
        }

        return result
    }
}
