
'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;


var PharmacySchema = new Schema({
  name: {
    type: String,
    required: 'Enter the name of the product'
  },
  address: {
    type: String,
    required: 'Enter the name of the product'
  },
  phone: {
    type: String,
    required: 'Enter the name of the product'
  },
  latitude: {
    type: Number,
    required: 'Enter the name of the product'
  },
  longitude: {
    type: Number,
    required: 'Enter the name of the product'
  },
  user: {
    type: String,
    required: 'Enter the name of the product'
  },
  password: {
    type: String,
    required: 'Enter the name of the product'
  }
});

module.exports = mongoose.model('Pharmacies', PharmacySchema);

