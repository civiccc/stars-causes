module ApplicationHelper
  def create_a_team_button(text="Make a new team")
    link_to "&#9733; " + text, new_team_url, :class => 'button'
  end

  def second_button(star)
    if current_user.can_second?(star)
      link_to "Second", star_seconds_url(star), :class => "second",
        'data-remote' => true, 'data-replace-id' => "star_#{star.id}",
        'data-method' => 'post'
    end
  end

  FRIENDLY_TIME_FORMAT = '%b %d at %I:%M%p'
  def friendly_time(time)
    time.getlocal.strftime(FRIENDLY_TIME_FORMAT).
         gsub(/(\s|^)0/, '\\1').
         sub('AM', 'am').
         sub('PM', 'pm')
  end

  PHOTO_SIZE = 50
  def photo(subject)
    type = subject.class.name.downcase
    image_url = case type
    when 'user'
      "http://graph.facebook.com/#{subject.facebook_uid.to_i}/picture?type=normal"
    else
      "#{type}.png"
    end
    link_to(image_tag(image_url, :height => PHOTO_SIZE, :width => PHOTO_SIZE,
                      :class => "user_photo"),
            send("#{type}_path", subject))
  end

  def stylesheet(path)
    @stylesheets << path
  end
end
