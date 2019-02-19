Pod::Spec.new do |s|

  s.name         = "PSea"
  s.version      = "1.1.7"
  s.summary      = "PSea"
  s.homepage     = "https://github.com/Fidetro/PSea"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "fidetro" => "zykzzzz@hotmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Fidetro/PSea.git", :tag => "#{s.version}" }
  s.source_files  = "Source/PSea/*.{h,m,swift}"

  s.dependency "Alamofire","~> 4.7.3"

  s.subspec "PSea" do |ss|
  ss.source_files  = "Source/PSea/*.{h,m,swift}"
  ss.dependency "Alamofire","~> 4.7.3"
  ss.dependency "RxSwift", "~> 4.3.1"
  end

  s.subspec "RxSwift" do |ss|
  ss.source_files  = "Source/PSea/*.{h,m,swift}","Source/Rx/*.{h,m,swift}"
  ss.dependency "Alamofire","~> 4.7.3"
  ss.dependency "RxSwift", "~> 4.3.1"
  end
end
