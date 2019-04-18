Usage
=====
* $ hugo new site mysite
* $ cd mysite
* Add a theme
* $ git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
* $ echo 'theme = "ananke"' >> config.toml
* Add a content
* $ hugo new posts/my-first-post.md

Start debug server
=====
* $ cd mysite
* $ hugo server -D --disableFastRender
