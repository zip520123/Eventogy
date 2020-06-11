# eventogy Eventogy Technical Task

## Install
1. Git clone this repo
2. Install pod
```bash
$ pod install 
```
3. Open Eventogy.xcworkspace
4. Select top left "No Scheme", select "New Scheme"
5. Select target "Eventogy", click OK.
6. Press command + R to run this App
7. Press command + U to Unit Test

## Architecture
- MVVM + Coordinator

# Developement steps
1. Add model test
2. Add network layer, mock network layer for DI.
3. Add ViewModel, test viewModel
4. Add Coordinator
5. Build tableView UI
6. Implement DB, test DB
7. Implement Detail UI.

Alamofire make the url caches for us.
We don’t need to save data into db for offline.
I still write save data to db function in case you want to see. :)