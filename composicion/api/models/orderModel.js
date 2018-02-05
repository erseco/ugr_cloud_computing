
'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;


var OrderSchema = new Schema({
  email: {
    type: String,
    required: 'Enter the customer e-mail'
  },
  products: {
    type: String,
    default: '[]'
  },
  total: {
    type: String,
    default: '0'
  },
  pharmacy: {
    type: String,
    required: 'Enter the pharmacy id'
  },
  status: {
    type: [{
      type: String,
      enum: ['pending', 'accepted', 'cancelled', 'completed']
    }],
    default: ['pending']
  }
});

module.exports = mongoose.model('Orders', OrderSchema);

