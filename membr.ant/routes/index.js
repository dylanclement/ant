
/*
 * GET home page.
 */
user = require('./user');

module.exports = function(app, db){

  app.get('/users', user.list);

  app.get('/', function(req, res,next) {
    res.render('index', { title: 'Hallo mom'});
  });

  app.get('/input/*', function(req, res, next) {
    res.json({ name: req.params[0] });
  });

  app.post('/input/:from/:rel/:to', function(req, res, next) {
    var from = req.params[0];
    var rel = req.params[1];
    var to = req.params[2];
    res.json({ name: rel });
  });

  app.get('/object/:name', function(req, res, next) {
    var name = req.params['name'];
    var obj = { name: name };
    console.log(obj);
    var node = db.createNode(obj);
    node.save(function(err, results) {
      if (results) {
        res.json({ name1: "Test" });
      }
    });    
  });


};