const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/user');

router.post('/register', async (req,res)=>{
  const {phone,password} = req.body;
  if(!phone||!password) return res.status(400).json({msg:'phone/password required'});
  const exists = await User.findOne({phone});
  if(exists) return res.status(400).json({msg:'exists'});
  const hash = await bcrypt.hash(password,10);
  const u = new User({phone,password:hash});
  await u.save();
  return res.status(201).json({msg:'registered'});
});

router.post('/login', async (req,res)=>{
  const {phone,password} = req.body;
  const u = await User.findOne({phone});
  if(!u) return res.status(400).json({msg:'Invalid'});
  const ok = await bcrypt.compare(password, u.password);
  if(!ok) return res.status(400).json({msg:'Invalid'});
  const token = jwt.sign({id:u._id}, process.env.JWT_SECRET || 'secret', {expiresIn:'7d'});
  return res.json({token});
});
module.exports = router;