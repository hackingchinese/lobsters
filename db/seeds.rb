if User.count < 2
  u = User.new(:username => "hackingchinese", :email => "editor@hackingchinese.com", :password =>ENV['DEFAULT_PASSWORD'], :password_confirmation =>ENV['DEFAULT_PASSWORD'])
  u.is_admin = true
  u.is_moderator = true
  u.save!
  u = User.new(:username => "stefanwienert", :email => "info@stefanwienert.de", :password =>ENV['DEFAULT_PASSWORD'], :password_confirmation =>ENV['DEFAULT_PASSWORD'])
  u.is_admin = true
  u.is_moderator = true
  u.save!
  User.update_all :created_at => 10.days.ago # fake new users
end

[ [
  %w[ Beginner  Intermediate  Advanced  ], 0
], [
  %w[ Listening Speaking Reading Writing Vocabulary Grammar Culture Productivity], 1
], [
  %w[ Blog-post Audio Video Book Website Software Music Game Paid Dictionary Textbook News VPN-required ] ,2
]].each do |tag_group,tier|
  tag_group.each do |tag_name|
    tag = Tag.where(tag: tag_name).first_or_initialize
    tag.tier = tier
    tag.save!
  end
end
Tag.where(tag: 'Software/app').destroy_all
Tag.where(tag: 'App').update_all tag: 'Mobile'
Tag.where(tag: 'Strategy').update_all tag: 'How-to-learn'

