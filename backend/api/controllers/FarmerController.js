const { Farmer } = require("../models/FarmerModel");
const { User } = require("../models/UserModel");
//done

exports.getFarmer = (req, res) => {
  Farmer.findOne({ email: req.body.email })
    .then((user) => {
      if (!user) {
        return res
          .status(404)
          .json({ success: false, message: "User email not found!" });
      } else {
        res.status(200).json({
          success: true,
          message: `Farmer found`,
          data: Farmer,
        });
      }
    })
    .catch((err) => {
    //   return res.status(200).json({
    //     success: true,
    //     message: "Something went wrong",
    //     data: err,
    //   });
    });
};

exports.getUserDetails = (req, res) => {
  res.json({ status: true, message: "User Received!", data: req.user });
};
