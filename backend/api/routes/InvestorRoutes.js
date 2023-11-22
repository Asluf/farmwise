module.exports = function(app) {
    const { Auth } = require("../middleware/auth");

    const InvestorController = require("../controllers/InvestorController");
    
    app.post("/getInvestor", Auth, InvestorController.getInvestor);
    app.post("/editInvestor", Auth, InvestorController.editInvestor);
    app.post("/showCultivation", Auth, InvestorController.getApprovedCultivation);
    app.post("/showRequestedCultivation", Auth, InvestorController.getRequestedCultivation);
    app.post("/requestCultivation", Auth, InvestorController.requestCultivation);
    app.post("/deleteRequestedCultivation", Auth, InvestorController.deleteRequestedCultivation);

};