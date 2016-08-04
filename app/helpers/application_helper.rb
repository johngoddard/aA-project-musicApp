module ApplicationHelper
  include ERB::Util
  def auth_token
    "<input type='hidden'
            name='authenticity_token'
            value='#{form_authenticity_token}'>".html_safe
  end

  def form_helper(url, method)
    "<form  action='#{url}' method='post'>
      #{auth_token}
      <input type='hidden' name='_method' value='#{method}'>".html_safe
  end

  def nice_time(time)
    "#{time.in_time_zone('Pacific Time (US & Canada)')
           .strftime("%m/%d/%Y at %I:%M%p")}"
  end

  def ugly_lryics(lyrics)
    formatted_lyrics = "<br>"
    lyrics.lines.each do |line|
      formatted_lyrics << "&#9835;" if line.size > 2
      formatted_lyrics << " #{h(line)}<br>"
    end

    formatted_lyrics.html_safe
  end

end
