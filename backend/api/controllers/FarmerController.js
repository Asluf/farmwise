const { Farmer } = require("../models/FarmerModel");
const { User } = require("../models/UserModel");

exports.getFarmer = (req, res) => {
  Farmer.findOne({ email: req.body.email })
    .then((user) => {
      if (!user) {
        return res
          .status(404)
          .json({ success: false, message: "User email not found!" });
      } else {
        User.findOne({ email: req.body.email },'profile_pic').then((loginDetails) => {
          if (!loginDetails) {
            return res
              .status(404)
              .json({ success: false, message: "User email not found!" });
          } else {
            return res.status(200).json({
              success: true,
              message: `Farmer found`,
              data: user,
              dpDetails: loginDetails
            });
          }
        });
      }
    })
    .catch((err) => {
      return res.status(200).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};
