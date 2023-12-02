const { Buyer } = require("../models/BuyerModel");
const { User } = require("../models/UserModel");
const { ProProposal } = require("../models/ProProposalModel");

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
      return res.status(500).json({
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
    mobile_number: req.body.mobile_number,
  };

  Buyer.findOneAndUpdate(
    { email: req.body.email },
    { $set: updateData },
    { new: true, useFindAndModify: false }
  )
    .then((data) => {
      if (!data) {
        return res.status(404).json({
          success: false,
          message: "Resource not found",
        });
      } else {
        return res.status(200).json({
          success: true,
          message: `Buyer Profile edited.`,
          data: data,
        });
      }
    })
    .catch((err) => {
      return res.status(500).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};

exports.getApprovedProducts = (req, res) => {
  ProProposal.aggregate([
    {
      $lookup: {
        from: "farmer_details",
        localField: "farmer_email",
        foreignField: "email",
        as: "farmerDetails",
      },
      //matching the farmer_email field in the CulProposal collection with the email field in the "farmer_details" collection.
    },
    { $unwind: "$farmerDetails" },
    {
      $match: {
        proposal_status: "approved",
        product_status: "available",
        response: "",
      },
    },
  ])
    .then((proposals) => {
      if (!proposals) {
        return res
          .status(404)
          .json({ success: false, message: "Products not found!" });
      }
      return res.status(200).json({
        success: true,
        message: `Approved Products found`,
        approvedProductDetails: proposals,
      });
    })
    .catch((err) => {
      return res.status(500).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};

exports.requestProducts = (req, res) => {
  const updateData = {
    product_status: "requested",
    buyer_email: req.body.buyer_email,
    response: "sent",
  };

  ProProposal.findOneAndUpdate(
    { _id: req.body.product_id },
    { $set: updateData },
    { new: true, useFindAndModify: false }
  )
    .then((data) => {
      if (!data) {
        return res.status(404).json({
          success: false,
          message: "Resource not found",
        });
      } else {
        return res.status(200).json({
          success: true,
          message: `Product requested`,
          data: data,
        });
      }
    })
    .catch((err) => {
      return res.status(500).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};

exports.getRequestedProducts = (req, res) => {
  ProProposal.aggregate([
    {
      $lookup: {
        from: "farmer_details",
        localField: "farmer_email",
        foreignField: "email",
        as: "farmerDetails",
      },
    },
    { $unwind: "$farmerDetails" },
    {
      $match: {
        buyer_email: req.body.buyer_email,
        proposal_status: "approved",
        product_status: "requested",
        response: "sent",
      },
    },
  ])
    .then((proposals) => {
      if (!proposals) {
        return res
          .status(404)
          .json({ success: false, message: "Proposals not found!" });
      }
      return res.status(200).json({
        success: true,
        message: `Requested Proposal found`,
        requestedProductDetails: proposals,
      });
    })
    .catch((err) => {
      return res.status(500).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};


exports.deleteRequestedProducts = (req, res) => {
  const updateData = {
    buyer_email: "",
    product_status: "available",
    response: "",
  };

  ProProposal.findOneAndUpdate(
    { _id: req.body.product_id, buyer_email : req.body.buyer_email },
    { $set: updateData },
    { new: true, useFindAndModify: false }
  )
    .then((data) => {
      if (!data) {
        return res.status(404).json({
          success: false,
          message: "Resource not found",
        });
      } else {
        return res.status(200).json({
          success: true,
          message: `Request for Product Deleted successfully.`,
          data: data,
        });
      }
    })
    .catch((err) => {
      return res.status(500).json({
        success: true,
        message: "Something went wrong",
        data: err,
      });
    });
};