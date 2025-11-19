const express = require('express');
const router = express.Router();
const auth = require('../utils/auth');
const User = require('../models/user');

router.get('/me', auth, async (req,res)=>{
  const u = await User.findById(req.userId);
  return res.json({phone:u.phone, balance:u.balance});
});
router.get('/history', auth, async (req,res)=>{
  const u = await User.findById(req.userId);
  return res.json(u.history || []);
});
router.post('/withdraw', auth, async (req,res)=>{
  const {amount} = req.body;
  if(!amount || amount<=0) return res.status(400).json({msg:'invalid'});
  const u = await User.findById(req.userId);
  if(u.balance < amount) return res.status(400).json({msg:'insufficient'});
  u.balance -= amount;
  u.history.push({type:'withdraw', amount:-amount, note:'requested', date:new Date(), status:'pending'});
  await u.save();
  return res.json({status:'pending'});
});
module.exports = router;