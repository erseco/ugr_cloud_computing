'use strict';

var mongoose = require('mongoose'),
  Product = mongoose.model('Orders');

exports.list_all_orders = function(req, res) {
  Product.find({}, function(err, order) {
    if (err)
      res.send(err);
    res.json(order);
  });
};

exports.create_a_order = function(req, res) {
  var new_order = new Product(req.body);
  new_order.save(function(err, order) {
    if (err)
      res.send(err);
    res.json(order);
  });
};

exports.read_a_order = function(req, res) {
  Product.findById(req.params.orderId, function(err, order) {
    if (err)
      res.send(err);
    res.json(order);
  });
};

exports.update_a_order = function(req, res) {
  Product.findOneAndUpdate({_id: req.params.orderId}, req.body, {new: true}, function(err, order) {
    if (err)
      res.send(err);
    res.json(order);
  });
};

exports.delete_a_order = function(req, res) {
  Product.remove({
    _id: req.params.orderId
  }, function(err, order) {
    if (err)
      res.send(err);
    res.json({ message: 'Product successfully deleted' });
  });
};

