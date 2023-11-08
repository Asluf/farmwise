const { Investor } = require("../models/InvestorModel");
const { User } = require("../models/UserModel");

exports.getInvestor = (req, res) => {
  Investor.findOne({ email: req.body.email })
    .then((user) => {
      if (!user) {
        return res
          .status(404)
          .json({ success: false, message: "User email not found!" });
      } else {
        return res.status(200).json({
          success: true,
          message: `Investor found`,
          data: user,
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

