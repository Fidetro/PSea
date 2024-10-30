Pod::Spec.new do |s|

  s.name         = "PSea"
  s.version      = "1.2.2"
  s.summary      = "PSea"
  s.homepage     = "https://github.com/Fidetro/PSea"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "fidetro" => "zykzzzz@hotmail.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/Fidetro/PSea.git", :tag => "#{s.version}" }
  s.source_files  = "Source/PSea/*.{h,m,swift}"
  s.dependency "Alamofire","~> 5.10.1"

end
