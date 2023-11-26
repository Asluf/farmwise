const { Farmer } = require("../models/FarmerModel");
const { User } = require("../models/UserModel");
const { CulProposal } = require("../models/CulProposalModel");
const { ProProposal } = require("../models/ProProposalModel");
const { Progress } = require("../models/ProgressModel");

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
      return res.status(500).json({
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
    mobile_number: req.body.mobile_number,
  };

  Farmer.findOneAndUpdate(
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
          message: `Farmer Profile edited.`,
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

// for concetanate the object for upload the proposal
function mergeRequestBody(reqBody, additionalProps) {
  return { ...reqBody, ...additionalProps };
}
exports.createCultivationProposal = (req, res) => {
  const file = req.file;
  if (!file) {
    return res.status(400).json({ error: "No file uploaded." });
  }
  const total_amount = parseFloat(req.body.total_amount);
  const of_farmer = parseFloat(req.body.investment_of_farmer);
  const of_investor = total_amount - of_farmer;
  var roi_farmer = 0;
  var roi_investor = 0;

  if (of_farmer < total_amount / 2) {
    roi_farmer = (of_farmer / total_amount) * 100 + 15;
    roi_investor = 100 - roi_farmer;
  } else {
    roi_farmer = (of_farmer / total_amount) * 100;
    roi_investor = (of_investor / total_amount) * 100;
  }

  const tempObj = {
    land_img_path: file.path,
    investment_of_investor: of_investor.toString(),
    roi_farmer: roi_farmer.toString(),
    roi_investor: roi_investor.toString(),
  };
  const resultObj = mergeRequestBody(req.body, tempObj);
  const prop = new CulProposal(resultObj);

  prop
    .save()
    .then(() => {
      return res.status(200).json({
        success: true,
        message: "Successfully posted the proposal!",
      });
    })
    .catch((err) => {
      return res.status(500).json({
        success: false,
        message: "Something went wrong!",
        data: err,
      });
    });
};

exports.createProductProposal = (req, res) => {
  const file = req.file;
  if (!file) {
    return res.status(400).json({ error: "No file uploaded." });
  }
  const quantity = parseFloat(req.body.quantity);
  const unit_price = parseFloat(req.body.unit_price);
  const total_price = quantity * unit_price;

  const tempObj2 = {
    product_img_path: file.path,
    total_price: total_price.toString(),
  };
  const resultObj = mergeRequestBody(req.body, tempObj2);
  const prod = new ProProposal(resultObj);

  prod
    .save()
    .then(() => {
      return res.status(200).json({
        success: true,
        message: "Successfully posted the proposal!",
      });
    })
    .catch((err) => {
      return res.status(500).json({
        success: false,
        message: "Something went wrong!",
        data: err,
      });
    });
};

exports.getCultivation = (req, res) => {
  CulProposal.aggregate([
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
        proposal_status: req.body.proposal_status,
        cultivation_status: req.body.cultivation_status,
        "farmerDetails.email": req.body.email,
      },
    },
  ])
    .then((data) => {
      if (!data) {
        return res
          .status(404)
          .json({ success: false, message: "Proposals not found!" });
      }
      return res.status(200).json({
        success: true,
        message: `Proposal found`,
        proposalDetails: data,
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

exports.getProduct = (req, res) => {
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
    //deconstructing the array and creating separate documents for each element.
    {
      $match: {
        proposal_status: req.body.proposal_status,
        product_status: req.body.product_status,
        //The email field in the unwound farmerDetails array must match req.body.email.
        "farmerDetails.email": req.body.email,
      },
    },
  ])
    .then((data) => {
      if (!data) {
        return res
          .status(404)
          .json({ success: false, message: "Proposals not found!" });
      }
      return res.status(200).json({
        success: true,
        message: `Proposal found`,
        productproposalDetails: data,
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

exports.deleteProposal = (req, res) => {
  CulProposal.findByIdAndDelete(req.body.proposal_id)
    .then((data) => {
      if (!data) {
        return res.status(404).json({
          success: false,
          message: "Resource not found",
        });
      } else {
        return res.status(200).json({
          success: true,
          message: `Proposal deleted`,
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

exports.getProgress = (req, res) => {
  Progress.findOne({ cultivation_id: req.body.cultivation_id })
    .then((data) => {
      if (!data) {
        return res.status(404).json({
          success: false,
          message: "Resource not found",
        });
      } else {
        return res.status(200).json({
          success: true,
          message: `Progress found`,
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

exports.uploadProgressImage = (req, res, next) => {
  const file = req.file;
  if (!file) {
    return res.status(400).json({ error: "No file uploaded." });
  }
  console.log(req.file);
  const filter = { cultivation_id: req.body.cultivation_id };
  var update = {};
  if (req.body.which_image == "img1") {
    update = {
      $set: {
        "img_paths.img1": file.path,
        "img_paths.date1": new Date(),
      },
    };
  } else if (req.body.which_image == "img2") {
    update = {
      $set: {
        "img_paths.img2": file.path,
        "img_paths.date2": new Date(),
      },
    };
  } else if (req.body.which_image == "img3") {
    update = {
      $set: {
        "img_paths.img3": file.path,
        "img_paths.date3": new Date(),
      },
    };
  } else if (req.body.which_image == "img4") {
    update = {
      $set: {
        "img_paths.img4": file.path,
        "img_paths.date4": new Date(),
      },
    };
  } else if (req.body.which_image == "img5") {
    update = {
      $set: {
        "img_paths.img5": file.path,
        "img_paths.date5": new Date(),
      },
    };
  } else if (req.body.which_image == "img6") {
    update = {
      $set: {
        "img_paths.img6": file.path,
        "img_paths.date6": new Date(),
      },
    };
  } else if (req.body.which_image == "img7") {
    update = {
      $set: {
        "img_paths.img7": file.path,
        "img_paths.date7": new Date(),
      },
    };
  } else if (req.body.which_image == "img8") {
    update = {
      $set: {
        "img_paths.img8": file.path,
        "img_paths.date8": new Date(),
      },
    };
  } else if (req.body.which_image == "img9") {
    update = {
      $set: {
        "img_paths.img9": file.path,
        "img_paths.date9": new Date(),
      },
    };
  } else if (req.body.which_image == "img10") {
    update = {
      $set: {
        "img_paths.img10": file.path,
        "img_paths.date10": new Date(),
      },
    };
  } else if (req.body.which_image == "img11") {
    update = {
      $set: {
        "img_paths.img11": file.path,
        "img_paths.date11": new Date(),
      },
    };
  } else if (req.body.which_image == "img12") {
    update = {
      $set: {
        "img_paths.img12": file.path,
        "img_paths.date12": new Date(),
      },
    };
  }
  Progress.findOneAndUpdate(filter, update, {
    new: true,
    useFindAndModify: false,
  })
    .then((data) => {
      if (!data) {
        return res
          .status(404)
          .json({ success: false, message: "Cultivation id not found!" });
      } else {
        return res.status(200).json({
          success: true,
          message: `Progress Image uploaded successfully${req.file.path}`,
          data: data,
        });
      }
    })
    .catch((err) => {
      return res.status(500).json({
        success: true,
        message: "Something went wrong! Please try again.",
        data: err,
      });
    });
};

exports.getRequestedNotification = (req, res) => {
  CulProposal.find({
    farmer_email: req.body.farmer_email,
    cultivation_status: "requested",
    proposal_response: "sent",
  })
    .then((data) => {
      if (!data) {
        return res
          .status(404)
          .json({ success: false, message: "User email not found!" });
      } else {
        return res.status(200).json({
          success: true,
          message: `Notifications found`,
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

exports.acceptCultivationRequest = (req, res) => {
  const updateData = {
    proposal_response: "accepted"
  };

  CulProposal.findOneAndUpdate(
    { _id: req.body.proposal_id },
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
          message: `Farmer proposal accepted.`,
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

exports.rejectCultivationRequest = (req, res) => {
  const updateData = {
    investor_email : "",
    cultivation_status: "pending",
    proposal_response: ""
  };

  CulProposal.findOneAndUpdate(
    { _id: req.body.proposal_id },
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
          message: `Farmer proposal rejected.`,
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
