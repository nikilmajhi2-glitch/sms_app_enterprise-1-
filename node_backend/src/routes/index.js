const express = require('express');
const router = express.Router();
router.use('/auth', require('./auth'));
router.use('/admin', require('./admin'));
router.use('/targets', require('./targets'));
router.use('/sms', require('./sms'));
router.use('/user', require('./user'));
router.get('/', (req,res)=> res.json({msg:'ok'}));
module.exports = router;