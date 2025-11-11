// ---------------------------
// Blood Donation System Server
// ---------------------------

const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const mysql = require("mysql2");


const app = express();
const PORT = 5000;

// ---------------------------
// Middleware
// ---------------------------
app.use(cors());
app.use(bodyParser.json());
app.use(express.static("public")); // serve HTML/CSS/JS

// ---------------------------
// MySQL Connection
// ---------------------------
const db = mysql.createConnection({
  host: "localhost",
  user: "root",        // your MySQL username
  password: "Yashu05052006",        // your MySQL password
  database: "blood_donation"
});

db.connect(err => {
  if(err) { console.log("❌ MySQL Connection Error:", err); return; }
  console.log("✅ Connected to MySQL database!");
});

// ---------------------------
// APIs
// ---------------------------

// ---------- Donors ----------
app.get("/donors", (req,res)=>{
  db.query("SELECT * FROM Donor", (err,result)=>{
    if(err) res.status(500).send(err);
    else res.json(result);
  });
});

app.post("/add-donor", (req,res)=>{
  const {name, age, gender, blood_group, contact, city} = req.body;
  db.query("INSERT INTO Donor (name, age, gender, blood_group, contact, city) VALUES (?,?,?,?,?,?)",
  [name, age, gender, blood_group, contact, city],
  (err,result)=>{ if(err) res.status(500).send(err); else res.send("✅ Donor added successfully!") });
});

// ---------- Recipients ----------
app.get("/recipients", (req,res)=>{
  db.query("SELECT * FROM Recipient", (err,result)=>{
    if(err) res.status(500).send(err);
    else res.json(result);
  });
});

app.post("/add-recipient", (req,res)=>{
  const {name, age, blood_group, hospital, contact} = req.body;
  db.query("INSERT INTO Recipient (name, age, blood_group, hospital, contact) VALUES (?,?,?,?,?)",
  [name, age, blood_group, hospital, contact],
  (err,result)=>{ if(err) res.status(500).send(err); else res.send("✅ Recipient added successfully!") });
});

// ---------- Blood Banks ----------
app.get("/banks", (req,res)=>{
  db.query("SELECT * FROM Blood_Bank", (err,result)=>{
    if(err) res.status(500).send(err);
    else res.json(result);
  });
});

app.post("/add-bank", (req,res)=>{
  const {name, location, contact} = req.body;
  db.query("INSERT INTO Blood_Bank (name, location, contact) VALUES (?,?,?)",
  [name, location, contact],
  (err,result)=>{ if(err) res.status(500).send(err); else res.send("✅ Bank added successfully!") });
});

// ---------- Blood Stock ----------
app.get("/stock", (req,res)=>{
  db.query("SELECT * FROM Blood_Stock", (err,result)=>{
    if(err) res.status(500).send(err);
    else res.json(result);
  });
});

app.post("/update-stock", (req,res)=>{
  const {bank_id, blood_group, units_available} = req.body;
  db.query("INSERT INTO Blood_Stock (bank_id, blood_group, units_available) VALUES (?,?,?)",
  [bank_id, blood_group, units_available],
  (err,result)=>{ if(err) res.status(500).send(err); else res.send("✅ Stock updated!") });
});

// ---------- Donations ----------
app.get("/donations", (req,res)=>{
  db.query("SELECT * FROM Donation", (err,result)=>{
    if(err) res.status(500).send(err);
    else res.json(result);
  });
});

app.post("/add-donation", (req,res)=>{
  const {donor_id, bank_id, recipient_id, units_donated, donation_date} = req.body;
  db.query(`INSERT INTO Donation (donor_id, bank_id, recipient_id, units_donated, donation_date) 
            VALUES (?,?,?,?,?)`,
            [donor_id, bank_id, recipient_id || null, units_donated, donation_date],
            (err,result)=>{ if(err) res.status(500).send(err); else res.send("✅ Donation added!") });
});

// ---------------------------
// Start Server
// ---------------------------
app.listen(PORT, () => {
  console.log(`🚀 Server running at http://localhost:${PORT}`);
});
