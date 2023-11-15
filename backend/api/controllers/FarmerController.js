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
        User.findOne({ email: req.body.email }, "profile_pic").then(
          (loginDetails) => {
            if (!loginDetails) {
              return res
                .status(404)
                .json({ success: false, message: "User email not found!" });
            } else {
              return res.status(200).json({
                success: true,
                message: `Farmer found`,
                data: user,
                dpDetails: loginDetails,
              });
            }
          }
        );
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

exports.editFarmer = (req, res) => {

  const updateData = {
    farmer_name: req.body.farmer_name,
    farmer_address: req.body.farmer_address,
    farm_name: req.body.farm_name,
    mobile_number: req.body.mobile_number
  };

  Farmer.findOneAndUpdate(
    { email: req.body.email },
    { $set: updateData },
    { new: true, useFindAndModify: false }
  )
    .then((user) => {
      return res.status(200).json({
        success: true,
        message: `Farmer Profile edited.`,
        data: user,
       
      });
    })
    .catch((err) => {
      return res.status(200).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};
