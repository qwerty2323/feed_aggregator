require 'sinatra'
require 'nokogiri'
require 'open-uri'

feed = 'http://api.flickr.com/services/feeds/groups_pool.gne?id=1373979@N22&lang=en-us&format=rss_200'

def parse feed
  doc = Nokogiri::XML(open(feed))
  doc.search('item').map do |doc_item|
    item = {}
    item[:link] = doc_item.at('link').text
    item[:thumbnail] = doc_item.at('media|thumbnail').attr('url')
    item[:title] = doc_item.at('title').text
    item
  end
end

get '/' do
  @pictures = parse feed
  erb :index
end

__END__

@@index
<!DOCTYPE html>
<html>
  <head>
  <meta charset="UTF-8">
  <meta name="viewport" content="user-scalable=yes, width=device-width" />
<title>Lovely Sunsets</title> 
</head>
<body>
  <h1>Lovely Sunsets</h1>
  <dl>
    <% @pictures.each do |picture| %>
      <dt><a href="<%= picture[:link] %>"><%= picture[:title] %></a></dt>
      <dd><img src="<%= picture[:thumbnail] %>" /></dd>
    <% end %>
  </dl>
</body>
</html>