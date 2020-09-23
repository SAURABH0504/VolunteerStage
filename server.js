const express = require('express');
const mongoose = require('mongoose');
const Volunteer = require('./model/Volunteer.model.js');
const NGO = require('./model/NGO.model.js');
const app=express();
app.use(express.urlencoded({extended: false}));
app.use(express.json({extended: false}));

const Port = 5000;

const dbUrl="mongodb+srv://Saurabhdb:sau05rabh@cluster0.r2rdg.gcp.mongodb.net/SiteData?retryWrites=true&w=majority"

const connectDB = async () => {
  try{
    await mongoose.connect(dbUrl,{
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useCreateIndex: true,
      useFindAndModify: false
    });
    console.log("MongoDB is Connected");
  }
  catch(error){
    console.log(error);
  }
}
  //Connect Database
  connectDB();

app.post("/api/volunteer", async (req,res) => {
        try{
          await Volunteer.create({
          firstname: req.body.firstname,
          lastname: req.body.lastname,
          category: req.body.category,
          pastwork: req.body.pastwork,
          why: req.body.why,
          email: req.body.email,
          password: req.body.password,});
          res.json({
            message: "Registered"
          })
        }catch(error){
          res.json({
            message: "Data is not correct"
          })
        }

});
app.post("/api/ngo", async (req,res) => {
        try{
          await NGO.create({
          name: req.body.name,
          description: req.body.description,
          location: req.body.location,
          requirement: req.body.requirement,
          category: req.body.category,
          });
          res.json({
            message: "Registered"
          })
        }catch(error){
          res.json({
            message: "Data is not correct"
          })
        }

});
app.get("/api/getvolunteer/", async (req,res) =>{
  const volunteer = await Volunteer.find();
   try{
     res.json({
       volunteer: volunteer
     })
   }
   catch(error){
      console.log(error)
   }
});
app.get("/api/getngo", async (req,res) => {
    const ngos = await NGO.find();
    try{
      res.json({
        ngos: ngos
      })
    }
    catch(error){
      console.log(error)
    }
});
app.listen(Port,()=>{
  console.log("Server is running on Port :" +Port);
});
