const express = require('express');

const port = 3000;
const app = express();

const data = [
    {
        "name" : "Kawser",
    },
    {
        "name" : "Faria",
    }
];

app.get('/get_data',(req,res)=>{
    res.send(data);
})

app.listen(port,()=>{
    console.log(`Server Running on ${port}`);
})