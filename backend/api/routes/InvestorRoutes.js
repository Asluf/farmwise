module.exports = function(app) {
    const { Auth } = require("../middleware/auth");

    const InvestorController = require("../controllers/InvestorController");
    
    app.post("/getInvestor", Auth, InvestorController.getInvestor);
    
};