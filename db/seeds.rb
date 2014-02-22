u = User.new(:username => "hackingchinese", :email => "editor@hackingchinese.com", :password =>ENV['DEFAULT_PASSWORD'], :password_confirmation =>ENV['DEFAULT_PASSWORD'])
u.is_admin = true
u.is_moderator = true
u.save!
u = User.new(:username => "stefanwienert", :email => "info@stefanwienert.de", :password =>ENV['DEFAULT_PASSWORD'], :password_confirmation =>ENV['DEFAULT_PASSWORD'])
u.is_admin = true
u.is_moderator = true
u.save!

%w[ Beginner Intermediate Advanced Listening Speaking Reading Writing Book Video Audio Software/app Website Culture Strategy ].each do |tag|
  t = Tag.new
  t.tag = tag
  t.save!
end
