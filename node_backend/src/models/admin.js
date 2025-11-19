const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const AdminSchema = new Schema({ username:{type:String, unique:true}, password:String });
module.exports = mongoose.model('Admin', AdminSchema);