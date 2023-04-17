# HearthStoneAPIExample
This project contains an implementation example of:
- native Decoding and URL sessions
- Alamofire and SwiftyJSON

The purpose was to learn alamoFire and SwiftyJSON and see the main differences when compared to the native versions.

### How I did it

I declared multiple protocols that gave different habilities thought protocol composition, so the AlamoFireService & Native service, since I used Viper I could declare the interactorProtocol to recieve custom instances like: var dataService: (SimpleCardsService & CommonDataService) doing this enabled to reduce coupling by abstracting the implementations.
This strategy was also applied to the Decoding of the app.

### Warning
The latency of the heartstoneApi is pretty high so it can take a lot of time to load the card search, but not the card backs.

### How to compile
Access [Hearthstone API on RapidAPI](https://rapidapi.com/omgvamp/api/hearthstone) and register to get your host, api key and endpoint.
After retrieving this information go to [APIKeys Swift File](HearthStoneAPIExample/HearthStoneAPI/API/APIKeys.swift) and input the informations there.

## How to improve
1 - Implementation of the error alerts the backbone is there but the alerts aren't showing the the errors are very generic.
2 - Manual Caching by getting the info of the server and seeing if the current pathc is the same as the stored.
