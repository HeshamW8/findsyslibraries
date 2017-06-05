#API

This is an API written in nodejs that returns a list of system dependencies that a 

certain ruby gem uses on a certain platform.

#INSTRUCTIONS

1. Run the following command in the terminal to populate the database with gem dependencies from the gemdataset.json

mongoimport --db gemLookup --collection gems --drop --file gemdataset.json

2. To make an API call visit localhost:3000 and send two parameters, the gem name and the platform name

example API call : http://localhost:3000/?name=sqlite3&&platform=apt