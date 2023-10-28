var express = require('express');
var router = express.Router();

router.get('/', function(req, res){    
    res.send("Welcome to API!");
});

require('./AuthRoutes')(router);
// require('./BuyerRoutes')(router);
// require('./FarmerRoutes')(router);
// require('./InvestorRoutes')(router);

module.exports.router = router;