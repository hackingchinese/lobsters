class StoryFetcher
  attr_reader :url
  def initialize(url)
    @url = url.strip
  end

  def result(validate: true)
    (validate && valid_url || already_submitted)  || fetch_content  ||  parse_content
  end

  def fetch_preview
    valid_url || screenshot
  end

  def screenshot
    file = Tempfile.new(['screenshot','.jpg'])
    file.binmode
    Headless.ly do
      `wkhtmltoimage  --transparent --use-xserver --width 1200 --height 900 #{Shellwords.escape(url)} #{file.path}`
    end
    if $?.to_i  == 0
      file
    end
  end

  private

  def valid_url
    if url.blank? or !url[/^https?:\/\//]
      {
        status: 'error',
        message: 'This is not a valid url.'
      }
    end
  end

  def parse_content
    doc = Nokogiri::HTML.parse(@content.to_s)
    text = doc.css(' meta[property="og:description"], meta[itemprop=description],meta[name=description], meta[name="twitter:description"]'  ).map{|i|i['content']}.uniq.compact.max{|i| i.length }
    image = doc.css(' meta[property="og:image"],meta[name="twitter:image:src"],meta[name="image"]').map{|i|i['content']}.uniq.compact.first
    {
      title: doc.at('title, h1').try(:text).try(:strip),
      image: image,
      snippet: text.try(:strip),
      url: filtered_url
    }
  end

  def fetch_content
    story = Story.new(url: url)
    @content = story.fetched_content
    if !@content
      {
        status: 'error',
        message: 'This page could not be reached from the server. Please make sure that the link is typed correctly.'
      }
    end
  end

  def already_submitted
    if story = Story.where(url: url).first and story != @story
      {
        status: 'error',
        message: "This story was already submitted. Please check out the link <a href='#{story.comments_url}'>here</a>."
      }
    end
  end

  def filtered_url
    @url.gsub(/\??utm_source.*/,'')
  end
end
