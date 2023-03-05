//
//  AudioFileFormat.swift
//  OpenAIDemo
//
//  Created by Gusakovsky, Sergey on 5.03.23.
//

import Foundation

public enum AudioFileFormat: String {
    case mp3, mp4, mpeg, mpga, m4a, wav, webm
    
    public var mimeType: String {
        switch self {
        case .mp3, .mpeg, .mpga:
            return "audio/mpeg"
        case .mp4, .m4a:
            return "audio/mp4"
        case .wav:
            return "audio/x-wav"
        case .webm:
            return "audio/webm"
        }
    }
}
