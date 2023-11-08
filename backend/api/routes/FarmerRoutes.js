module.exports = function (app) {
  const { Auth } = require("../middleware/auth");

  const FarmerController = require("../controllers/FarmerController");

  app.post("/getFarmer", Auth, FarmerController.getFarmer);
  app.get("/getFarmer", (req, res) => {
    res.send("Hii");
  });
};
