cask 'menumeters' do
  version :latest
  sha256 :no_check
  url 'http://member.ipmu.jp/yuji.tachikawa/MenuMetersElCapitan/zips/MenuMeters_1.9.2.zip'

  name 'MenuMeters'
  homepage 'http://member.ipmu.jp/yuji.tachikawa/MenuMetersElCapitan/'
  license :gpl

  prefpane 'MenuMeters.prefPane'

  zap delete: '~/Library/Preferences/com.ragingmenace.MenuMeters.plist'
end
