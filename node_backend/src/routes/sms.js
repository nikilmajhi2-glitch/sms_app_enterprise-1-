const express = require('express');
const router = express.Router();
const auth = require('../utils/auth');
const User = require('../models/user');
const Target = require('../models/target');

router.post('/proof', auth, async (req,res)=>{
  const {target, text, sentAt} = req.body;
  if(!target||!text) return res.status(400).json({msg:'target/text required'});
  const u = await User.findById(req.userId);
  if(!u) return res.status(400).json({msg:'User not found'});
  const today = new Date(); today.setHours(0,0,0,0); const tomorrow = new Date(today); tomorrow.setDate(today.getDate()+1);
  const t = await Target.findOne({number: target, date: {$gte: today, $lt: tomorrow}, active:true});
  if(!t) return res.status(400).json({msg:'Target not valid'});
  const fiveMinAgo = new Date(Date.now() - 5*60*1000);
  const recent = (u.history || []).find(h => h.type==='sms' && h.note===target && new Date(h.date) > fiveMinAgo);
  if(recent) return res.status(400).json({msg:'Duplicate detected'});
  const earned = 0.16;
  u.balance += earned;
  u.history.push({type:'sms', amount:earned, note:target, text:text, date: sentAt ? new Date(sentAt) : new Date()});
  await u.save();
  return res.json({earned});
});

module.exports = router;