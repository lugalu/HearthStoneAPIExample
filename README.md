# HearthStoneAPIExample
This project contains an implementation example of:
- native Decoding and URL sessions
- Alamofire and SwiftyJSON

The purpose was to learn alamoFire and SwiftyJSON and see the main differences when compared to the native versions.

## How I did it

I declared multiple protocols that gave different habilities thought protocol composition, so the AlamoFireService & Native service, since I used Viper I could declare the interactorProtocol to recieve custom instances like: var dataService: (SimpleCardsService & CommonDataService) doing this enabled to 
