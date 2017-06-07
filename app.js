var http = require('http');
var assert = require('assert');

var express = require('express');
var bodyParser = require('body-parser');
var MongoClient = require('mongodb').MongoClient;

var app = express();
var server = http.createServer(app);

app.set('port', process.env.PORT || 3000);

// app.use(bodyParser.urlencoded({ extended: true }))
// app.use(bodyParser.json())

// Connection URL
var dbURL = 'mongodb://localhost:27017/gemLookup';

// db instance
var mongodb;
var gemsCollection;

// Use connect method to connect to the server
MongoClient.connect(dbURL, function (err, db) {
    assert.equal(null, err);
    console.log("Connected successfully to database");

    mongodb = db;
    gemsCollection = db.collection('gems');
});

app.get('/', function (req, res) {
    var gemName = req.query.name;
    var platform = req.query.platform;

    console.log('Query Received : ');
    console.log(req.query);

    if (gemName && platform) {
        gemsCollection.findOne({ name: gemName }, function (err, doc) {
            if (doc) {
                console.log(doc);
                var requiredPlatform = doc.platforms[platform];
                if (requiredPlatform) {
                    res.send(requiredPlatform);
                } else {
                    res.send('gem info not available for this platform');
                }
            } else {
                res.send('gem not available in catalog');
            }
        });
    }else{
        res.send('invalid api call');
    }
});

server.listen(app.get('port'), function () {
    console.log('Express server listening on port ' + app.get('port'));
});
