Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "MHTTP"
s.summary = "My first framework."
s.requires_arc = true
s.version = "1.0.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.authors = { "Marian" => 'mariansamy17@gmail.com' }
s.homepage = "https://github.com/marian19/MHTTP"
s.source = { :git => "[Your RWPickFlavor Git URL Goes Here]", :tag => "#{s.version}"}
s.dependency 'AFNetworking', '~> 3.0'
s.source_files = "MHTTP/**/*"

end
