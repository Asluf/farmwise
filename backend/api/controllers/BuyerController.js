const { Buyer } = require("../models/BuyerModel");
const { User } = require("../models/UserModel");

exports.getBuyer = (req, res) => {
  Buyer.findOne({ email: req.body.email })
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
                message: `Buyer found`,
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

exports.editBuyer = (req, res) => {

  const updateData = {
    buyer_name: req.body.buyer_name,
    address: req.body.address,
    mobile_number: req.body.mobile_number
  };

  Buyer.findOneAndUpdate(
    { email: req.body.email },
    { $set: updateData },
    { new: true, useFindAndModify: false }
  )
    .then((user) => {
      return res.status(200).json({
        success: true,
        message: `Buyer Profile edited.`,
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
