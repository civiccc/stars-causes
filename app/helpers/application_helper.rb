module ApplicationHelper
  def create_a_star_button
    link_to "&#9733; Make someone a star", new_star_url, :class => 'button'
  end

  FRIENDLY_TIME_FORMAT = '%H:%M%p on %b %d'
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

  def name(user, opts={})
    user.name
  end

  def linked_name(user, opts={})
    link_to name(user, opts), user_path(user)
  end

  DEFAULT_PHOTO_OPTIONS = {:linked => false,
                           :size => :square}
  def photo(user, opts={})
    fb_profile_pic(user.facebook_uid, DEFAULT_PHOTO_OPTIONS.merge(opts))
  end

  def linked_photo(user, opts={})
    link_to photo(user, opts), user_path(user)
  end

  def stylesheet(path)
    @stylesheets << path
  end
end
