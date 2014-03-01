class StoryFetcher
  attr_reader :url
  def initialize(url)
    @url = url.strip
  end

  def result
    valid_url || already_submitted || fetch_content  ||  parse_content
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
    text = doc.css(' meta[property="og:description"], meta[itemprop=description],meta[name=description]').map{|i|i['content']}.uniq.compact.max{|i| i.length }
    image = doc.css(' meta[property="og:description"], meta[itemprop=description]').map{|i|i['content']}.uniq.compact.first
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
    if story = Story.where(url: url).first
      {
        status: 'error',
        message: "This story was already submitted. Please check out the link <a href='#{story.comments_url}'>here</a>."
      }
    end
    def filtered_url
      @url.gsub(/\??utm_source.*/,'')
    end
  end
end
