# SQLite

[![CI Status](https://img.shields.io/travis/ervivek40/SQLite.svg?style=flat)](https://travis-ci.org/ervivek40/SQLite)
[![Version](https://img.shields.io/cocoapods/v/SQLite.svg?style=flat)](https://cocoapods.org/pods/SQLite)
[![License](https://img.shields.io/cocoapods/l/SQLite.svg?style=flat)](https://cocoapods.org/pods/SQLite)
[![Platform](https://img.shields.io/cocoapods/p/SQLite.svg?style=flat)](https://cocoapods.org/pods/SQLite)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<!--## Requirements-->

## Installation

SQLite is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SQLite'
```
## USAGE
 ```swift
 
 //Create or switch new database
 SQLite.shared.databaseName = "NewDatabaseName"
 
 //Get new pointer to current database
 let databasePointer = SQLite.shared.getDB()
 
 //Get current pointer to working database
 let currentDatabasePointer = SQLite.shared.db
 
 //Get Current database name
 let currentDatabaseName = SQLite.shared.databaseName
 
 //Execute raw SQL Query 
 SQLite.shared.execute(query: "Your_Raw_SQL_Query")
 
 //Execute and know executed successfully or error occured
 let flag = SQLite.shared.execute(queryString: "Your_Raw_SQL_Query")
 
 //Get rows with column name
 SQLite.shared.getRowsWithCol(query: "Your_select_query")

 //Insert a Row in Table
 let entry : = ["Key1":Value1,"Key2":Value2]
 let replaceExisting = true
 SQLite.shared.insertTable(entry, TableName, replaceExisting)
 
 //Update Row in Table
 let entry : = ["Key1":Value1,"Key2":Value2]
 let where = "columnName = 'MyColumn'"
 SQLite.shared.insertTable(entry, TableName, where)
 ```


## Author

Vivek Kumar, ervivek40@gmail.com

## License

SQLite is available under the MIT license. See the LICENSE file for more info.
