Pod::Spec.new do |s|
s.name         = 'HyCategoriess'
s.version      = '1.0.0'
s.summary      = 'HyCategories Lib Demo'
s.homepage     = 'https://github.com/hydreamit/HyCategories'
s.license      = 'MIT'
s.authors      = {'Hy' => 'hydreamit@163.com'}
s.platform     = :ios, '9.0'
s.source       = {:git => 'https://github.com/hydreamit/HyCategories.git', :tag => s.version}
s.source_files = 'HyCategories/**/*.{h,m}'
s.framework    = 'UIKit', 'CoreFoundation'
s.requires_arc = true
end
