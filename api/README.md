#API

This is an API written in nodejs that returns a list of system dependencies that a 

certain ruby gem uses on a certain platform.

#INSTRUCTIONS

1. Run the following command in the terminal to populate the database with gem dependencies from the gemdataset.json

mongoimport --db gemLookup --collection gems --drop --file gemdataset.json
