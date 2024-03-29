
![](https://img.shields.io/github/license/sgusakovsky/OpenAIService) [![](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/) ![CocoaPods](https://img.shields.io/cocoapods/v/OpenAIService.svg)
# OpenAI API Client Library in Swift

This is a community-maintained library to access OpenAI HTTP API's. The full API docs can be found here:
https://platform.openai.com/docs

## Installation 

### Manual
Copy source files into your own project

### Swift Package Manager

You can use Swift Package Manager to integrate the library by adding the following dependency in your Package.swift file or by adding directly within Xcode

`.Package(url: "https://github.com/sgusakovsky/OpenAIService.git", majorVersion: 1)`

### CocoaPods

You can use CocoaPods to integrate the library by adding the following dependency.

`pod 'OpenAIService'`

## Example Usage

Import the module in your application.
`import OpenAIService`

Set your API token from creating one [here](https://platform.openai.com/account/api-keys).

```swift
let config = OpenAIConfiguration(organizationId: "ORG", apiKey: "API_KEY")
let service = OpenAIService(config: config)
```

Create a call to the completions API, passing in a text prompt.

```swift
let body = OpenAICompletionBody(prompt: "How are you doing?", maxTokens: 100)
service?.sendCompletion(with: body, completionHandler: { result in
    switch result {
    case .success(let response):
        if let text = response.choices.first?.text {
             print(text)
        }
    case .failure(let error):
        print(error.localizedDescription)
    }
})
```
The API will return an `OpenAICompletionResponse` object containing the corresponding text items.

Create a call to the chat API, passing in a text prompt.

```swift
let message = OpenAIChatMessage(role: .user, content: "How are you doing?")
let body = OpenAIChatBody(messages: [message], maxTokens: 100)
service?.sendChat(with: body, completionHandler: { result in
    switch result {
    case .success(let response):
        if let text = response.choices.first?.message.content {
             print(text)
        }
    case .failure(let error):
        print(error.localizedDescription)
    }
})
```
The API will return an `OpenAIChatResponse` object containing the corresponding text items.

Create a call to the test edits API, passing in a text prompt.

```swift
let body = OpenAIEditsBody(input: "What day of the wek is it?", instruction: "Fix the spelling mistakes")
service?.sendEdits(with: body, completionHandler: { result in
    switch result {
    case .success(let response):
        if let text = response.choices.first?.text {
             print(text)
        }
    case .failure(let error):
        print(error.localizedDescription)
    }
})
```
The API will return an `OpenAIEditsResponse` object containing the corresponding text items.

Create a call to the image generation API, passing in a text prompt.

```swift
let body = OpenAIGenerationImageBody(prompt: "Good weekend", size: .small, responseFormat: .base64)
service?.sendImageGeneration(with: body, completionHandler: { result in
    switch result {
    case .success(let response):
        if let image = response.data.first?.image {
            print(image)
        } else if let url = response.data.first?.url {
            print(url)
        }
    case .failure(let error):
        print(error.localizedDescription)
    }
})
```
The API will return an `OpenAIImageResponse` object containing the corresponding image url items.

Create a call to the image edit API, passing in a text prompt.

```swift
guard let body = OpenAIImageEditsBody(image: UIImage(named: "image")!, mask: UIImage(named: "mask")!, prompt: "A cute baby sea otter wearing a beret", size: .small, responseFormat: .base64) else {
    return
}
service?.sendImageEdits(with: body, completionHandler: { result in
    switch result {
    case .success(let response):
        if let image = response.data.first?.image {
            print(image)
        } else if let url = response.data.first?.url {
            print(url)
        }
    case .failure(let error):
        print(error.localizedDescription)
    }
})
```
The API will return an `OpenAIImageResponse` object containing the corresponding image url items.

Create a call to the image edit API, passing in a text prompt.

```swift
guard let body = OpenAIImageVariationBody(image: UIImage(named: "image")!, size: .small, responseFormat: .base64) else {
    return
}
service?.sendImageVariation(with: body, completionHandler: { result in
    switch result {
    case .success(let response):
        if let image = response.data.first?.image {
            print(image)
        } else if let url = response.data.first?.url {
            print(url)
        }
    case .failure(let error):
        print(error.localizedDescription)
    }
})
```
The API will return an `OpenAIImageResponse` object containing the corresponding image url items.

Create a call to the audio transcription API.

```swift
let urlPath = Bundle.main.url(forResource: "audio", withExtension: "mp3")!
let data = try? Data(contentsOf: urlPath)!
let body = OpenAIAudioTranscriptionBody(file: data, fileFormat: .mp3)
service?.sendAudioTranscription(with: body, completionHandler: { result in
    switch result {
    case .success(let response):
        print(response.text)
    case .failure(let error):
        print(error.localizedDescription)
    }
})
```
The API will return an `OpenAIAudioResponse` object containing the corresponding image url items.

Create a call to the audio translation into English API.

```swift
let urlPath = Bundle.main.url(forResource: "audio", withExtension: "mp3")!
let data = try? Data(contentsOf: urlPath)!
let body = OpenAIAudioTranslationBody(file: data, fileFormat: .mp3)
service?.sendAudioTranslation(with: body, completionHandler: { result in
    switch result {
    case .success(let response):
        print(response.text)
    case .failure(let error):
        print(error.localizedDescription)
    }
})
```
The API will return an `OpenAIAudioResponse` object containing the corresponding image url items.

For a full list of the supported models see [OpenAICompletionModelType.swift](https://github.com/sgusakovsky/OpenAIService/blob/main/Sources/OpenAIService/Models/Completion/OpenAICompletionModelType.swift), [OpenAIChatModelType.swift](https://github.com/sgusakovsky/OpenAIService/blob/main/Sources/OpenAIService/Models/Chat/OpenAIChatModelType.swift), [OpenAIEditsModelType.swift](https://github.com/sgusakovsky/OpenAIService/blob/main/Sources/OpenAIService/Models/Edits/OpenAIEditsModelType.swift). For more information on the models see the [OpenAI API Documentation](https://platform.openai.com/docs/models).

OpenAIService also supports Swift concurrency so you can use Swift’s async/await syntax to fetch completions.

```swift
do {
    let body = OpenAICompletionBody(prompt: "How are you doing?", maxTokens: 100)
    let result = try await service.sendCompletion(with: body)
} catch {
    print(error.localizedDescription)
}
```
```swift
do {
    let message = OpenAIChatMessage(role: .user, content: "How are you doing?")
    let body = OpenAIChatBody(messages: [message], maxTokens: 100)
    let result = try await service.sendChat(with: body)
} catch {
    print(error.localizedDescription)
}
```

```swift
do {
    let body = OpenAIEditsBody(input: "What day of the wek is it?", instruction: "Fix the spelling mistakes")
    let result = try await service.sendEdits(with: body)
} catch {
    print(error.localizedDescription)
}
```

```swift
do {
    let body = OpenAIGenerationImageBody(prompt: "Good weekend")
    let result = try await service.sendImageGeneration(with: body)
} catch {
    print(error.localizedDescription)
}
```

## Licence 

The MIT License (MIT)

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
