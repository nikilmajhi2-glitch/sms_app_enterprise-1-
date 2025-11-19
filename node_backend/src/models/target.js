const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const TargetSchema = new Schema({
  number:String, note:String, active:Boolean, date:Date
});
module.exports = mongoose.model('Target', TargetSchema);