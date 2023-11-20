module.exports = function (app) {
  const { Auth } = require("../middleware/auth");
  const upload = require('../middleware/upload');

  const FarmerController = require("../controllers/FarmerController");

  app.post("/getFarmer", Auth, FarmerController.getFarmer);
  app.post("/editFarmer", Auth, FarmerController.editFarmer);
  app.post("/createCultivationProposal", Auth,  upload.uploadCulPropoal.single('image') ,FarmerController.createCultivationProposal);
  app.post("/createProductProposal", Auth,  upload.uploadProPropoal.single('image') ,FarmerController.createProductProposal);
  app.post("/getCultivation", Auth, FarmerController.getCultivation);
  app.post("/getProduct", Auth, FarmerController.getProduct);

  // app.post("/testt", Auth, FarmerController.testt);


};
