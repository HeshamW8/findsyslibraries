var http = require('http');

var express = require('express');
var mongoose = require('mongoose');
var bodyParser = require('body-parser');

var app = express();
var server = http.createServer(app);

app.set('port', process.env.PORT || 3000);

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())

mongoose.connect('mongodb://localhost/gemLookup', function (err) {
    var status = (err) ? 'connection to database failed' : 'connection to database successful';
    console.log(status);
});

server.listen(app.get('port'), function () {
    console.log('Express server listening on port ' + app.get('port'));
});