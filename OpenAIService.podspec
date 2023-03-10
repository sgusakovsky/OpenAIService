Pod::Spec.new do |spec|
  spec.name         = 'OpenAIService'
  spec.version      = '1.2.0'
  spec.homepage     = 'https://github.com/sgusakovsky/OpenAIService'
  spec.license      = {
    :type => 'MIT',
    :file => 'LICENSE',
    :text => 'MIT License'
  }
  spec.authors      = { 'Sergey Gusakovsky' => 'sgusakovsky@qulix.com' }
  spec.summary      = 'OpenAI API Client Library in Swift'
  spec.description  = <<-DESC
    OpenAI API Client Library in Swift. This is a community-maintained library to access OpenAI HTTP API's. The full API docs can be found in Open AI docs.
  DESC
  spec.source       = { :git => 'https://github.com/sgusakovsky/OpenAIService.git', :tag => spec.version }
  spec.source_files = 'Sources/**/*.swift'
  spec.requires_arc = true
  spec.swift_version = "5.0"
  spec.ios.deployment_target = "13.0"
end
