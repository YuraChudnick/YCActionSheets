
Pod::Spec.new do |s|

  s.name         = "YCActionSheets"
  s.version      = "1.0.1"
  s.summary      = "Collection of custom action sheets"

  s.description  = "Collection of custom action sheets.  Instructions for installation
  are in [the README](https://github.com/YuraChudnick/YCActionSheets)."

  s.homepage      = "https://github.com/YuraChudnick/YCActionSheets"

  s.license       = { :type => "MIT", :file => "License.md" }

  s.author        = { "Y.Chudnick" => "y.chudnovets@temabit.com" }

  s.platform      = :ios, "10.0"

  s.source        = { :git => "https://github.com/YuraChudnick/YCActionSheets.git", :tag => s.version }

  s.source_files  = "YCActionSheets", "YCActionSheets/*.swift", "YCActionSheets/**/*.swift"

  s.resources = ["YCActionSheets/Resources/*.png"]

  s.swift_version = '4.2'

end
