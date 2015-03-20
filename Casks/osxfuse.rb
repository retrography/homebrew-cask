cask :v1 => 'osxfuse' do
  version '2.7.5'
  sha256 '9be5cc9c44c2211aacea6a35aea5d47fea82599e981f051f318201a637b43f72'

  # sourceforge.net is the official download host per the vendor homepage
  url "http://downloads.sourceforge.net/project/osxfuse/osxfuse-#{version}/osxfuse-#{version}.dmg"
  homepage 'https://osxfuse.github.io/'
  license :bsd

  # adds MacFuse compatibility layer by default
  plist = <<-EOT.undent
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
  <array>
          <dict>
                  <key>attributeSetting</key>
                  <integer>1</integer>
                  <key>choiceAttribute</key>
                  <string>selected</string>
                  <key>choiceIdentifier</key>
                  <string>#{MacOS.release}$OSXFUSEMacFUSE</string>
          </dict>
  </array>
  </plist>
  EOT

  plist_file = 'options.plist'

  preflight do
    plist_path = staged_path.join(plist_file)
    IO.binwrite(plist_path, plist)
  end

  pkg "Install OSXFUSE #{version[0..-3]}.pkg", :apply_choice_changes => plist_file

  uninstall :pkgutil => 'com.github.osxfuse.pkg.Core|com.github.osxfuse.pkg.PrefPane|com.github.osxfuse.pkg.MacFUSE',
            :kext => 'com.github.osxfuse.filesystems.osxfusefs'
end
