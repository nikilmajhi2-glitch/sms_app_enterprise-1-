const express = require('express');
const router = express.Router();
const Admin = require('../models/admin');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/user');

router.post('/login', async (req,res)=>{
  const {username,password} = req.body;
  const a = await Admin.findOne({username});
  if(!a) return res.status(400).json({msg:'Invalid'});
  const ok = await bcrypt.compare(password, a.password);
  if(!ok) return res.status(400).json({msg:'Invalid'});
  const token = jwt.sign({id:a._id}, process.env.ADMIN_JWT || 'adminsecret', {expiresIn:'7d'});
  return res.json({token});
});

router.get('/withdraws', async (req,res)=>{
  // NOTE: assume adminAuth middleware handles token - simplified for brevity
  const users = await User.find().lean();
  const withdraws = [];
  users.forEach(u=>{ (u.history || []).forEach(h=>{ if(h.type==='withdraw' && h.status==='pending') withdraws.push({userId:u._id, phone:u.phone, ...h}); }); });
  return res.json(withdraws);
});
module.exports = router;