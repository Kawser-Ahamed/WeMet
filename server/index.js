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
    uploadPostCollection.insertOne(req.body)
    .then((value)=> res.send('Your post is successfully uploaded'))
    .catch((error)=> res.send(error));
});

app.get('/get_all_post/:category', async (req,res)=>{
    try{
        const allPostsCollection = client.db(databaseName).collection("all");
        if(req.params.category == "all"){
            var values = allPostsCollection.find();
            var json = await values.toArray();
            res.send(json);
        }
        else{
            var values = allPostsCollection.find({postCategory : req.params.category});
            var json = await values.toArray();
            res.send(json);
        }
    }
    catch(error){
        res.send(error);
    }
});

app.get('/get_user_data/:email',async (req,res)=>{
    const profileDataCollection = client.db(databaseName).collection('users');
    try{
        var values = profileDataCollection.find({email : req.params.email});
        var json = await values.toArray();
        res.send(json);
    }
    catch(error){
        res.send(error);
    }
})

app.get('/get_profile_data/:email', async(req,res)=>{
    try{
        const profileDataCollection = client.db(databaseName).collection('all');
        var values = profileDataCollection.find({email : req.params.email});
        var json = await values.toArray()
        res.send(json);
    }
    catch(error){
        res.send(error);
    }
});

const updateProfileCollection = client.db(databaseName).collection('users');
app.put('/update_profile/:email', (req,res)=>{
    updateProfileCollection.updateOne({email: req.params.email},{
        $set: {
            fullName : req.body.fullName,
            bio: req.body.bio,
        },
    }).then((value)=>{
        client.db(databaseName).collection('all').updateMany({email: req.params.email},{
            $set :{
                uploaderName : req.body.fullName,
            },
        }).then((value)=> {
            client.db(databaseName).collection('posts-comments').updateMany({email: req.params.email},{
                $set : {
                    commenterName : req.body.fullName,
                }
            })
            .then((value)=> res.send('Profile updated successfully.'))
            .catch((error) => res.send(error));
        })
        .catch((error)=> res.send(error));
    })
    .catch((error)=> res.send(error));
})

app.put('/update_profile_picture/:email', (req,res)=>{
    updateProfileCollection.updateOne({email : req.params.email},{
        $set: {
            profileImageUrl : req.body.profileImageUrl,
        }
    }).then((value)=>{
        client.db(databaseName).collection('all').updateMany({email: req.params.email},{
            $set : {
                uploaderProfilePictureImageUrl : req.body.profileImageUrl,
            }
        }).then((value)=>{
            client.db(databaseName).collection('posts-comments').updateMany({email: req.params.email},{
                $set : {
                    commenterProfilePictureImageUrl : req.body.profileImageUrl,
                }
            })
            .then((value) => res.send('Profile Picture updated successfully.'))
            .catch((error)=> res.send(error));
        })
        .catch((error)=>res.send(error));
    })
    .catch((error)=> res.send(error))
});

app.put('/update_cover_photo/:email',(req,res)=>{
    updateProfileCollection.updateOne({email : req.params.email},{
        $set : {
            coverPhotoUrl : req.body.coverPhotoUrl,
        }
    })
    .then((value)=> res.send('Cover Photo updated successfully.'))
    .catch((error)=>res.send(error));
});

app.post('/upload_comment/:id', (req,res)=>{
    const uploadCommentCollection = client.db(databaseName).collection('posts-comments');
    uploadCommentCollection.insertOne(req.body)
    .then((value)=> res.send('Your Comment Successfully Uploaded'))
    .catch((error)=> res.send(error));
});

app.get('/fetch_comment/:id', async (req,res)=>{
    const fetchCommentCollection = client.db(databaseName).collection('posts-comments');
    try{
        var values = fetchCommentCollection.find({id: req.params.id});
        var json = await values.toArray();
        res.send(json);
    }
    catch(error){
        res.send(error);
    }
});

const userCollection = client.db(databaseName).collection("users");
app.post('/add_user', async(req,res)=>{
    userCollection.insertOne(req.body)
    .then((value)=>res.send(value))
    .catch((error)=> res.send(error));
});

const randomUser = client.db(databaseName).collection('users');
app.get('/get_random_user', async(req,res)=>{
    try{
        var values = randomUser.find();
        var json = await values.toArray();
        const randomValue = Math.floor(Math.random() * json.length);
        var jsondata = [json[randomValue]];
        res.send(jsondata);
    }
    catch(error){
        res.send(error);
    }
});

const searchCollection = client.db(databaseName).collection('users');
app.get('/get_search_user/:searchvalue', async(req,res)=>{
    try{
        let filterdUser = [];
        var values = searchCollection.find();
        var json = await values.toArray();
        for(let values in json){
            let userName = json[values]['fullName'];
            if(userName.toLowerCase().includes(req.params.searchvalue)){
                filterdUser.push(json[values]);
            }
        }
        res.send(filterdUser);
    }
    catch(error){
        return res.send(error);
    }
});

app.post('/add_following', async (req,res)=>{
    try{
        const addFollwoingCollection = client.db(databaseName).collection(`${req.body.userEmail}-following`);
        
        addFollwoingCollection.insertOne({
            'followingEmail' : req.body.followingEmail,
        });

        let userFollowing = await client.db(databaseName).collection('users').findOne({email : req.body.userEmail});
        let followingResponse = await client.db(databaseName).collection('users').findOne({email : req.body.followingEmail});
        
        client.db(databaseName).collection('users').updateOne({email : req.body.userEmail},{
            $set: {
                following : (userFollowing['following'] + 1),
            }
        });

        client.db(databaseName).collection('users').updateOne({email : req.body.followingEmail},{
            $set: {
                followers : (followingResponse['followers'] + 1),
            }
        });

        res.send("You are now following ");
    }
    catch(error){
        res.send(error);
    }
    
});

const followersCollection = client.db(databaseName).collection('follower');
app.get('/get_followers_data', async(req,res)=>{
    try{
        let followersData = [];
        var values = followersCollection.find();
        var json = await values.toArray();
        for(let i in json){
            let followers =  await client.db(databaseName).collection('users').findOne({email : json[i]['email']});
            followersData.push(followers);
        }
        res.send(followersData);
    }
    catch(error){
        res.send(error);
    }
})

app.listen(port,()=>{
    console.log(`Server Running on ${port}`);
})