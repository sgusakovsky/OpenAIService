//
//  DataDecoder.swift
//  OpenAIDemo
//
//  Created by Gusakovsky, Sergey on 4.03.23.
//

#if os(iOS)
import UIKit


public final class DataDecoder {
    
    public func decodeBase64Image(_ b64Data: String) -> UIImage? {
        if let data = Data(base64Encoded: b64Data),
            let image = UIImage(data: data) {
            return image
        }
        
        return nil
    }
    
}
#endif
