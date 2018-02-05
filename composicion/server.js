var express = require('express'),
  app = express(),
  port = process.env.PORT || 8080,
  mongoose = require('mongoose'),

  Product = require('./api/models/productModel'), //created model loading here
  Order = require('./api/models/orderModel'), //created model loading here

  bodyParser = require('body-parser');

var cors = require('cors');


// mongoose instance connection url connection
mongoose.Promise = global.Promise;
mongoose.connect('mongodb://mongo/pharmadb', { useMongoClient: true });


app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use(cors({origin: '*'}));


var routes = require('./api/routes/routes'); //importing route
routes(app); //register the route

app.get('/', function(req, res) {
    // res.sendFile('./web/index.html');
     res.redirect("/index.html");
});

app.get('/status/', (req, res) => {
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify({ status: "ok" }));
});

app.use(express.static('web'));

app.use(function(req, res) {
  res.status(404).send({url: req.originalUrl + ' not found'})

  // Website you wish to allow to connect
  res.setHeader('Access-Control-Allow-Origin', '*');

    // Request methods you wish to allow
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

    // Request headers you wish to allow
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

    // Set to true if you need the website to include cookies in the requests sent
    // to the API (e.g. in case you use sessions)
    res.setHeader('Access-Control-Allow-Credentials', true);


});


app.listen(port);


console.log('pharmaserver RESTful API server started on: ' + port);


