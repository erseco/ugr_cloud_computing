
'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;


var ProductSchema = new Schema({
  name: {
    type: String,
    required: 'Enter the name of the product'
  },
  creation_date: {
    type: Date,
    default: Date.now
  },
  price: {
    type: Number,
    required: 'Enter the price of the product'
  },
  manufacturer: {
    type: [{
      type: String,
      enum: ['generic', 'rovi', 'cinfa', 'normon', 'pfizer', 'bayer', 'alconcusi']
    }],
    default: ['generic']
  },
  status: {
    type: [{
      type: String,
      enum: ['pending', 'ongoing', 'completed']
    }],
    default: ['pending']
  }
});

module.exports = mongoose.model('Products', ProductSchema);

