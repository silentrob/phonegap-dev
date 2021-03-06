%w(ftools FileUtils devices/android devices/iphone devices/blackberry).each { |x| require x  }
#
# Provides utilities for generating a PhoneGap application and unifies the build process for each of the supported mobile platforms.
#
class PhoneGap
  
  include Iphone
  include Android
  include Blackberry
  
  # outputs the current version of PhoneGap 
  # FIXME needs to pull from sauce repo found at install path
  def version
    '0.7.0'
  end 
  
  # helper for getting the install path of phonegap 
  def install_path
    File.expand_path('~/.phonegap')
  end 
  
  # creates an app skeleton
  def generate(path)
    `cp -rf generate #{path}`   
    e=<<-E
    
    Generated a fresh PhoneGap application! 
    
    #{ path }/
    |
    |- config/
    |  |- bootstrap.js
    |  |- iphone-dev-cert.txt
    |  |- android-dev-cert.txt
    |  '- blackberry-dev-cert.txt
    |
    '- www/
       |- assets/
       |  |- css/
       |  |- js/
       |  '- images/
       |
       '- index.html
       
    For more information, tutorials, documentation and quickstarts go to http://phonegap.com
    
    E
    trim(e)
  end
  
  # builds a phonegap web application to all supported platforms
  def build(path)
    build_iphone(path)
    build_android(path)
    build_blackberry(path)
  end 
  
  # outputs a tidy report of which PhoneGap supported SDK's are installed
  def report
    report =<<-E
    
    PhoneGap 0.7.0
    -------------------
    
    Supported Platforms
    -------------------
    iPhone ............ #{ iphone_supported? ? 'yes' : 'no!' } .... #{ iphone_supported? ? '3.0' : 'Download and install from http://developer.apple.com' }
    Android  .......... #{ android_supported? ? 'yes' : 'no!' } .... #{ android_supported? ? '???' : 'Download and install from http://code.google.com/p/android' }
    BlackBerry ........ #{ blackberry_supported? ? 'yes' : 'no!' } .... #{ blackberry_supported? ? '???' : 'Download and install from http://developer.rim.com' }
    
    E
    trim(report)
  end  
  
  # helper for removing code indentation whitespace
  def trim(str)
    str.gsub('    ','')
  end 
end 