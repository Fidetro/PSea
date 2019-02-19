Pod::Spec.new do |s|

  s.name         = "PSea+RxSwift"
  s.version      = "1.2.0"
  s.summary      = "PSea"
  s.homepage     = "https://github.com/Fidetro/PSea"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "fidetro" => "zykzzzz@hotmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Fidetro/PSea.git", :tag => "#{s.version}" }
  s.source_files  = "Source/Rx/*.{h,m,swift}"

  s.dependency "PSea"
  s.dependency "RxSwift", "~> 4.3.1"

end
