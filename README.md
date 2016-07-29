Expat
=====
This gem adds a mountable web application to your Rails app to allow editing of
yml files. The files are saved in the same location, so your version control
system will pick up the changes like normal.

## Usage
After adding this gem to your Gemfile, add the following line in your
`config/routes.rb`:
```
  mount(Expat::Engine => '/expat') if Rails.env.development?
```

Now restart your server and use the application at http://localhost:3000/expat
