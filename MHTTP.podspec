Pod::Spec.new do |s|

s.platform = :ios
s.name = "MHTTP"
s.summary = "My first framework."
s.requires_arc = true
s.version = "1.0.8"
s.license = { :type => "MIT", :file => "LICENSE" }
s.authors = { "Marian" => 'mariansamy17@gmail.com' }
s.homepage = "https://github.com/marian19/MHTTP"
s.source = { :git => "https://github.com/marian19/MHTTP.git", :tag => "#{s.version}"}
s.dependency 'AFNetworking', '~> 3.0'
s.source_files = 'MHTTP/**/*.{h,m}'
s.resources = "MHTTP/**/*"

end

