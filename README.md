# README

Web-Crawler is a web crawler built to check Github's weekly trending repositories page and ouput a terminal-friendly response.

Web-Crawler features `create_data`, `clear_data`, `javascript`, `no_language`, and `trending` Ruby class methods within the Crawler class housed in the `crawler.rb` file.

Web-Crawler is run using Ruby on Rails and exists entirely within a Plain old Ruby Object. To access the application, open up your directory housing this application and run your rails console to begin.

# Methods:
<h2>create_data</h2>
Run ` Crawler.create_data` within the rails console in order to initiate the crawl and to temporarily create a workable dataset for the duration of the console session.

<h2>clear_data</h2>
Run `Crawler.clear_data` to clear the cache of data that has been created after running `Crawler.create_data`.

<h2>javascript</h2>
`.javascript` is a class method that checks the existing data set and totals the amount of trending repositories that were written primarily in Javascript. 

<b>IMPORTANT</b>
Only run `Crawler.javascript` after your have populated the dataset using `Crawler.create_data`, otherwise you will not get back an accurate result.

<h2>no_language</h2>
Similar to the `.javascript` method, `.no_language` checks the existing dataset for any repositories that do not specify a primary programming language an provides the user with a total of non-specified languages.

<h2>trending</h2>
The `.trending` method is used to output the crawled repository data in a readable, terminal-friendly environment. Run `Crawler.trending` to view all of the repositories in the terminal after you have run `Crawler.create_data` to create the data for your session.

# Web-Crawler
