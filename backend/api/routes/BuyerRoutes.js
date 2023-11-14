module.exports = function(app) {
    const { Auth } = require("../middleware/auth");

    const BuyerController = require("../controllers/BuyerController");
    
    app.post("/getBuyer", Auth, BuyerController.getBuyer);
    app.post("/editBuyer", Auth, BuyerController.editBuyer);
    
};