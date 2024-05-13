const express = require('express');
const cors = require('cors');
const bodyparser = require('body-parser');
const {MongoClient,ServerApiVersion} = require('mongodb');
require('dotenv').config();
const port = 3000;
const databaseName = "WeMet";

const app = express();
app.use(cors());
app.use(bodyparser.json());

const uri = `mongodb+srv://${process.env.DB_USER}:${process.env.DB_PASSWORD}@kawserahamed.xyq6inq.mongodb.net/?retryWrites=true&w=majority&appName=KawserAhamed`;

const client = new MongoClient(uri, {
    serverApi: {
      version: ServerApiVersion.v1,
      strict: true,
      deprecationErrors: true,
    }
});

async function dbConnect(){
    try{
        client.connect();
        console.log("Pinged your deployment. You successfully connected to MongoDB!");
    }
    catch(error){
        console.log(`Error: ${error}`);
    }
}

dbConnect();

const data = [
    {
        "name" : "Kawser",
    },
    {
        "name" : "Faria Shaowly",
    }
];

app.get('/',(req,res)=>{
    res.send(data);
})


const databse = client.db(databaseName).collection("Post-Category");
app.get("/post_category", async (req,res)=>{
    try{
       var values = databse.find();
       var json = await values.toArray();
       res.send(json);
    }
    catch(error){
        console.log(error);
    }
});

app.listen(port,()=>{
    console.log(`Server Running on ${port}`);
})