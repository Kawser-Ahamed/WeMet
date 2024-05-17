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

const postCategoryCollection = client.db(databaseName).collection("post-category");
app.get("/post_category", async (req,res)=>{
    try{
       var values = postCategoryCollection.find();
       var json = await values.toArray();
       res.send(json);
    }
    catch(error){
        console.log(error);
    }
});

const uploadPostCollection = client.db(databaseName).collection("all");
app.post("/upload_post/:email/:category", async (req,res)=>{
    const uploadPostInProfile = client.db(databaseName).collection(`${req.params.email}-post`);
    const categoryPostCollection = client.db(databaseName).collection(req.params.category);
    uploadPostCollection.insertOne(req.body)
    .then((value)=>{
        uploadPostInProfile.insertOne(req.body)
        .then((value)=>{
            if(req.params.category != 'none'){
                categoryPostCollection.insertOne(req.body)
                .then((value)=>res.send('Your post is successfully uploaded'))
                .catch((error)=>res.send(error));
            }
            else{
                res.send('Your post is successfully uploaded');
            }
        })
        .catch((error)=> res.send(error));
    })
    .catch((error)=> res.send(error));
});

app.get('/get_all_post/:category', async (req,res)=>{
    const allPostsCollection = client.db(databaseName).collection(req.params.category);
    try{
       var values = allPostsCollection.find();
       var json = await values.toArray();
       res.send(json);
    }
    catch(error){
        res.send(error);
    }
});

app.get('/profile_data/:email', async(req,res)=>{
    try{
        const profileDataCollection = client.db(databaseName).collection(`${req.params.email}-post`);
        var values = profileDataCollection.find();
        var json = await values.toArray()
        res.send(json);
    }
    catch(error){
        res.send(error);
    }
});

app.listen(port,()=>{
    console.log(`Server Running on ${port}`);
})