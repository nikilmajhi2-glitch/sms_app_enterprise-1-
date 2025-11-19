const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const UserSchema = new Schema({
  phone:{type:String, unique:true},
  password:String,
  balance:{type:Number, default:0},
  history:{type:Array, default:[]}
});
module.exports = mongoose.model('User', UserSchema);