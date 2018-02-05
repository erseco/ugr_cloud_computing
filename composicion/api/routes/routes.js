'use strict';
module.exports = function(app) {

  var product = require('../controllers/productController');

  // product Routes
  app.route('/products')
    .get(product.list_all_products)
    .post(product.create_a_product);


  app.route('/products/:productId')
    .get(product.read_a_product)
    .put(product.update_a_product)
    .delete(product.delete_a_product);


  var order = require('../controllers/orderController');

  // order Routes
  app.route('/orders')
    .get(order.list_all_orders)
    .post(order.create_a_order);


  app.route('/orders/:orderId')
    .get(order.read_a_order)
    .put(order.update_a_order)
    .delete(order.delete_a_order);


// app.get('/', (req, res) => {
//   res.send('Hello world\n');
// });

// app.get('/status/', (req, res) => {
//   res.send('{"status": "ok"}');
// });


};
