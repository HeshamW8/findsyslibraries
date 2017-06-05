var http = require('http');
var assert = require('assert');

var express = require('express');
var mongoose = require('mongoose');
var bodyParser = require('body-parser');
var MongoClient = require('mongodb').MongoClient;

var app = express();
var server = http.createServer(app);

app.set('port', process.env.PORT || 3000);

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())



// Connection URL
var dbURL = 'mongodb://localhost:27017/gemLookup';

// db instance
var mongodb;

// Use connect method to connect to the server
MongoClient.connect(dbURL, function (err, db) {
    assert.equal(null, err);
    console.log("Connected successfully to database");

    mongodb = db;
});


server.listen(app.get('port'), function () {
    console.log('Express server listening on port ' + app.get('port'));
});