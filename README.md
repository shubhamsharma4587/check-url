##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [2.4.9](https://github.com/organization/project-name/blob/master/.ruby-version#L1)
- Rails [5.2.4](https://github.com/organization/project-name/blob/master/Gemfile#L12)

##### 1. Check out the repository

```bash
git clone https://github.com/shubhamsharma4587/check-url.git
```

##### 2. Remove Gemfile.lock if present and install bundle

```bash
rm Gemfile.lock
bundle install
```

##### 3. Provide mail credentials in SMTP settings to send mail

Provide `user_name` & `password` in `config/environments/production.rb` & `config/environments/development.rb` in SMTP settings to send mail

```ruby
config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 465,
      user_name: "example@gmail.com",
      password: "PASSWORD",
      authentication: :login,
      ssl: true,
      tls: true,
      enable_starttls_auto: true
  }
```

##### 4. Provide same `user_name` in mailer

Edit `app/mailers/application_mailer.rb`

```ruby
  default from: 'example@gmail.com'
```

##### 5. Start the Rails server

You can start the rails server using the command given below.

```bash
rails s -p 3000
```

And now you can visit the site with the URL http://localhost:3000