# release-notifier

With this project you are able to setup notifications for software releases.

Just setup a notification for a specific GitHub project or for
other software just like MySQL which will scrape the webpage for a new software
release.

## Configuration

To be able to send notifications, you need to configure a SMTP server in this project.
Just open the development.rb and production.rb and change the following lines:
```
config.action_mailer.smtp_settings = {
    :address => "XXX.XXX.com",
    :port => 465,
    :user_name => "XXX",
    :password => "XXX",
    :ssl => true,
    :authentication => "login"
  }
```

Set the correct database configuration in `config/database.yml`.

## Setup

Install Ruby on Rails via [rbenv](https://github.com/rbenv/rbenv).

After you installed Ruby, then install the necessary gems via

```
bundle install
```

Then create and migrate the database via 

```
rails db:create
rails db:migrate
```

## How to use
Via `rails s` you can run the rails server and on 127.0.0.1:3000 you can setup your release checks.

To check for new releases and send notifications execute the following command in an interval:
```
rails release:check
```

## Project is archived

This project is not in active development.

## License

GPLv3