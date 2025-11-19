const express = require('express');
const router = express.Router();
const Target = require('../models/target');
const adminAuth = require('../utils/adminAuth');

router.get('/', async (req,res)=>{
  const today = new Date(); today.setHours(0,0,0,0); const tomorrow = new Date(today); tomorrow.setDate(today.getDate()+1);
  const ts = await Target.find({date:{$gte:today,$lt:tomorrow}, active:true}).lean();
  return res.json(ts);
});

router.post('/admin', adminAuth, async (req,res)=>{
  const {number,note,date} = req.body;
  const t = new Target({number,note,active:true, date: date ? new Date(date) : new Date()});
  await t.save();
  return res.json({msg:'ok'});
});
module.exports = router;