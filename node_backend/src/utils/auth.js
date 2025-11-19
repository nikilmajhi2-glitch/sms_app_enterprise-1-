const jwt = require('jsonwebtoken');
module.exports = function(req,res,next){
  const h = req.headers['authorization'];
  if(!h) return res.status(401).json({msg:'No token'});
  const parts = h.split(' ');
  if(parts.length!==2) return res.status(401).json({msg:'Invalid token'});
  const token = parts[1];
  try{ const d = jwt.verify(token, process.env.JWT_SECRET || 'secret'); req.userId = d.id; next(); } catch(e){ return res.status(401).json({msg:'Invalid token'}); }
};