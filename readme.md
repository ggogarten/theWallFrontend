# README

This is a swift frontend to be used in conjunction with the rails api backend developed for theWall app.


Server settings:

Please modify the following files to point to your api endpoints:

SignupViewController.swift

In func signUpToApi let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/users")!
Change https://gentle-shelf-67593.herokuapp.com/ to your yourApiEndpoint/users.

In func loginToApi let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/token")!
Change https://gentle-shelf-67593.herokuapp.com/ to your yourApiEndpoint/token.


LoginViewController.swift

In func loginToApi let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/token")!
Change https://gentle-shelf-67593.herokuapp.com/ to your yourapiEndpoint/token.



TesterViewController.swift

In func postToApi let link = URL(string: "https://gentle-shelf-67593.herokuapp.com/wall_posts")!
Change https://gentle-shelf-67593.herokuapp.com/ to your yourApiEndpoint/wall_posts.



TesterTableViewController.swift

In func getDataFromUrl("https://gentle-shelf-67593.herokuapp.com/wall_posts")

Change https://gentle-shelf-67593.herokuapp.com/ to your yourApiEndpoint/wall_posts.
