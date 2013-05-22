# Description
Stars is a Rails 2.3 application where you can publicly thank or praise a friend
by giving them one of several "Stars" (e.g. Teambuilding, Cleaning, Creative,
Detective, etc). Everyone who is signed up for Stars will receive an email about
the star that was just given, and anyone can "+1" a Star by "Seconding" it.

A main goal of Stars is to foster a supportive and appreciative atmosphere.
Stars is commonly deployed in small software start-ups, but could work well in
different organizations of various sizes.

# Installation

## Locally
Stars works on most Ruby versions (1.8.7, 1.9.2, 1.9.3) and Rails 2.3. Ruby 2.0
is currently not supported due to the old Rails dependency. To install locally
(Linux / OS X):

    git clone https://github.com/causes/stars-causes stars
    cd stars
    bundle install
    cp config/database.yml{.example,}
    bundle exec rake db:migrate
    script/server

## Heroku
If you'd like to deploy this to Heroku as well:

    heroku create stars-myorg
    git push heroku master
    heroku run rake db:migrate

## Configuration through Environment Variables
Sensitive information isn't kept in the repository and needs to be passed to the
web server through environment variables. At a bare minimum, this includes:

    STARS_SESSION_KEY=_mycustomdomain_stars
    STARS_SESSION_SECRET=<randomly generated secret>
    GMAIL_SMTP_DOMAIN=mycustomdomain.com
    GMAIL_SMTP_PASSWORD=
    GMAIL_SMTP_USER=stars@mycustomdomain.com
    MAIL_RECIPIENTS=all@mycustomdomain.com

If you're running on Heroku, you can set the environment variables via:

    heroku add:config STARS_SESSION_KEY=_mysite_stars STARS_SESSION_SECRET=...

(as a reminder, you can dump these configs from Heroku with `heroku shell -s`)
