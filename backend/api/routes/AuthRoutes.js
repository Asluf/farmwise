module.exports = function(app) {
    const { Auth } = require("../middleware/auth");
    const upload = require('../middleware/upload');

    const AuthController = require("../controllers/AuthController");

    app.post("/registerFarmer", AuthController.registerFarmer);
    app.post("/registerInvestor", AuthController.registerInvestor);
    app.post("/registerBuyer", AuthController.registerBuyer);
    app.post("/login", AuthController.loginUser);
    app.get("/user", Auth, AuthController.getUserDetails);
    app.post("/uploadDp",Auth, upload.single('image'), AuthController.uploadDpImage);
};