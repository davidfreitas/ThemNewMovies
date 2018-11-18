# Them New Movies
*TNM* is an iOS app that shows the upcoming movie releases and allows you to search and discover new movies.


## Building and running
The app uses CocoaPods managed dependencies, so you have to install them before trying to build the app.

To install the dependencies, just run the following command in the project folder.
```
pod install
```

#### Dependencies
The command above will install the two dependencies used in the development.
1. **[Alamofire](https://github.com/Alamofire/Alamofire)** - Very popular library used to handle network requests. It was used due to familiarity and time constraints. It was also implemented in a manner that it can easily be replaced by other approaches, such as URLSession.

2. **[AlamofireImage](https://github.com/Alamofire/AlamofireImage)** - An extension to Alamofire that provides convenience methods for loading remote images. For this project, it was mainly used due to time constraints, but as the project grows, features like image scaling, inflation and filters can be really useful.

## Notes
Unit and UI tests were in mind for this project. However, early in development it got clear that this was too big a scope for how little free time I had to dedicate to the project.

Nevertheless, I kept the early unit tests in the project for reference.