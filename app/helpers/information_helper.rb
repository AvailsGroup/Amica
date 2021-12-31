module InformationHelper
  require 'uri'

  def link(content)
    URI.extract(content, %w[http https]).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      content.gsub!(url, sub_text)
    end
    content
  end
end
