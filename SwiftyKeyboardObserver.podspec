
Pod::Spec.new do |spec|
  spec.name             = 'SwiftyKeyboardObserver'
  spec.version          = '2.0.0'
  spec.summary          = 'A codeless library that helps adjusting your views when a keyboard appears, moves and disappears'

  spec.description      = <<-DESC
    SwiftyKeyboardObserver adjusting your views when a keyboard appears, moves and disappears
      * Zero lines of your code
      * Supporting Storyboard configuration
      * Supporting `UIScrollView` and scroll to active field
      * Supporting orientation changes
      * Supporting modal and pop-over
      * Changing the length of a bottom Auto Layout constraint
                       DESC

  spec.homepage         = 'https://github.com/Decybel07/SwiftyKeyboardObserver'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'Adrian Bobrowski' => 'adrian071993@gmail.com' }
  spec.source           = { :git => "https://github.com/Decybel07/SwiftyKeyboardObserver.git", :tag => spec.version }

  spec.ios.deployment_target = '8.0'
  spec.ios.framework  = 'UIKit'
  spec.source_files = 'Source/Core/**/*.swift'
end
