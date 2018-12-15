# Flymyshortner
[![Build Status](https://travis-ci.org/fly49/flymyshortner.svg?branch=master)](https://travis-ci.org/fly49/flymyshortner)
[![Maintainability](https://api.codeclimate.com/v1/badges/523e76279e5a0cb4976b/maintainability)](https://codeclimate.com/github/fly49/flymyshortner/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/523e76279e5a0cb4976b/test_coverage)](https://codeclimate.com/github/fly49/flymyshortner/test_coverage)

Flymyshortner is URL-shortner application built using Redis and Sidekiq. Here are some of the key features:

* __Shortening__. App shortens your link into 8-lettered string.

<p align="center"><img src ="https://github.com/fly49/flymyshortner/blob/master/gifs/first_g.gif" /></p>

* __Validation__. App validates your link and show up fancy message if it's now valid.

<p align="center"><img src ="https://github.com/fly49/flymyshortner/blob/master/gifs/second_g.gif" /></p>

* __Title scraping__. When link is getting processed the sidekiq worker starts to scrap your link's title. If you refresh the page (or come back to page after being absent for a while) you will see that the link's title is scrapped.

<p align="center"><img src ="https://github.com/fly49/flymyshortner/blob/master/gifs/third_g.gif" /></p>

* __Doesn't make duplicates__. App stores shortened links in cookie files and don't make duplicates if you try to shorten same link twice.

<p align="center"><img src ="https://github.com/fly49/flymyshortner/blob/master/gifs/forth_g.gif" /></p>

[Link to deployed app](https://flymyshortner.herokuapp.com/)
