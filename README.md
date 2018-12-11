# Flymyshortner
[![Build Status](https://travis-ci.org/fly49/flymyshortner.svg?branch=master)](https://travis-ci.org/fly49/flymyshortner)

Flymyshortner is URL-shortner application built using Redis and Sidekiq. Here are some of the key features:

* __Shortening__. App shortens your link into 8-lettered string.

* __Validation__. App validates your link and show up fancy message if it's now valid.

* __Title scraping__. When link is getting processed the sidekiq worker starts to scrap your link's title. If you refresh the page (or come back to page after being absent for a while) you will see that the link's title is scrapped.

* __Doesn't make duplicates__. App stores shortened links in cookie files and don't make duplicates if you try to shorten same link twice.

[Link to deployed app](https://flymyshortner.herokuapp.com/)
