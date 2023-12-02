module.exports = function(app) {
    const { Auth } = require("../middleware/auth");

    const BuyerController = require("../controllers/BuyerController");
    
    app.post("/getBuyer", Auth, BuyerController.getBuyer);
    app.post("/editBuyer", Auth, BuyerController.editBuyer);
    app.post("/showProducts", Auth, BuyerController.getApprovedProducts);
    app.post("/requestProducts", Auth, BuyerController.requestProducts);
    app.post("/showRequestedProducts", Auth, BuyerController.getRequestedProducts);
    app.post("/deleteRequestedProducts", Auth,  BuyerController.deleteRequestedProducts);
};