module ApplicationHelper
  def create_a_star_button(text="Make someone a star")
    link_to "&#9733; " + text, new_star_url, :class => 'button'
  end

  def create_a_team_button(text="Make a new team")
    link_to "&#9733; " + text, new_team_url, :class => 'button'
  end

  def second_button(star, text="Second")
    if current_user.can_second?(star)
      link_to text, star_seconds_url(star),
        :method => :post, :class => "second"
    end
  end

  FRIENDLY_TIME_FORMAT = '%b %d at %I:%M%p'
  def friendly_time(time)
    time.getlocal.strftime(FRIENDLY_TIME_FORMAT).
         gsub(/(\s|^)0/, '\\1').
         sub('AM', 'am').
         sub('PM', 'pm')
  end

  DEFAULT_NAME_OPTIONS = {:firstnameonly => true,
                          :linked => false,
                          :useyou => false}
  def default_name_options(user)
    DEFAULT_NAME_OPTIONS.merge(:ifcantsee => user.name.split.first)
  end

  GRAVATAR_BASE = "http://gravatar.com/avatar/"
  def gravatar_url(email)
    url = URI.parse(GRAVATAR_BASE)
    url.path += Digest::MD5.hexdigest(email.strip.downcase)
    url.query = "d=#{URI.encode("http://#{ENV['APP_HOST']}#{image_path('user.png')}")}"
    url.to_s

  end

  def name(user, opts={})
    user.name
  end

  def linked_name(user, opts={})
    link_to name(user, opts), user_path(user)
  end

  PHOTO_SIZE = 50
  def photo(subject)
    type = subject.class.name.downcase
    image_url = case type
    when 'user'
      gravatar_url(subject.email)
      "http://graph.facebook.com/#{subject.facebook_uid.to_i}/picture?type=normal"
    else
      "#{type}.png"
    end
    link_to(image_tag(image_url, :height => PHOTO_SIZE, :width => PHOTO_SIZE,
                      :class => "user_photo round"),
            send("#{type}_path", subject))
  end

  def stylesheet(path)
    @stylesheets << path
  end
end
