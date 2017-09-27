# babylon-plus-ios
Babylon Demo Project ++

## Project Description
Basically this demo app is made based on the requirements from <a href= "https://github.com/Babylonpartners/iOS-Interview-Demo/blob/master/demo.md#1-the-babylon-demo-project">here</a>. This app is chosen as iOS learning media because for me it has minimum features to train a mobile app developer: layouting, item listing, connection to web API, and data persistence. The project has ++ on its title because it has additional features:
<ol>
	<li>Simple login-logout mechanism</li>
	<li>Search post functionality on local storage</li>
	<li>Show author details on different screen</li>
	<li>Show comments of the post instead of showing only its number</li>
</ol>

## Application Architecture
This project is built following <a href="https://www.objc.io/issues/13-architecture/viper/">VIPER</a> architecture, popular Clean Architecture in iOS development.
Local storage feature is implemented using Core Data framework because the stored data isn't kind of simple data and Core Data support Entity-Relationship modeling. Data for simple login-logout mechanism is stored using Keychain instead of UserDefaults. The storage alternative shows example for storing user data (such as email and credential on common apps) in more secure way.
These libraries are used in this project:
<ol>
  <li><a href="https://github.com/Alamofire/Alamofire">Alamofire</a>: Elegant HTTP Networking library for Swift</li>
  <li><a href="https://github.com/SwiftyJSON/SwiftyJSON">SwiftyJSON</a>: The better way to deal with JSON data in Swift</li>
  <li><a href="https://github.com/TTTAttributedLabel/TTTAttributedLabel">TTTAttributedLabel</a>: A drop-in replacement for UILabel that supports attributes, data detectors, links, and more</li>
  <li><a href="https://github.com/evgenyneu/keychain-swift">KeychainSwift</a>: Helper functions for saving text in Keychain securely for iOS, OS X, tvOS and watchOS</li>
</ol>

## Disclaimer
This project is made to learn and explore various features of iOS and Swift 3. Therefore, it isn't for applying any position at Babylon Partners.
