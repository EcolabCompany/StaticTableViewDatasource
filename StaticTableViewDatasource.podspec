Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "StaticTableViewDatasource"
  s.version      = "1.2.0"
  swift_version  = "4.2"
  s.summary      = "Create static table views in a declarative style"
  # s.description  = <<-DESC
  #                  DESC
  s.homepage     = "https://github.com/EcolabPestServices/StaticTableViewDatasource"
  s.license      = "MIT"
  s.author             = { "Nate Mann" => "nathan.mann@me.com" }
  s.social_media_url   = "https://twitter.com/NathanMann"
  s.platform     = :ios
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/EcolabPestServices/StaticTableViewDatasource.git", :tag => "#{s.version}" }
  s.source_files  = "StaticTableViewDatasource/StaticTableViewDatasource/*.swift"
end
