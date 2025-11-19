import React, {useState, useEffect} from 'react';
import axios from 'axios';
function App(){
  const [token, setToken] = useState(localStorage.getItem('adminToken')||'');
  const [targets, setTargets] = useState([]);
  useEffect(()=>{ if(token) loadTargets(); }, [token]);
  async function loadTargets(){ const res = await axios.get('http://localhost:5000/targets'); setTargets(res.data); }
  return (<div style={{maxWidth:900, margin:'20px auto'}}><h2>Admin Panel (React)</h2>{ token ? (<div><h3>Today's Targets</h3><ul>{targets.map(t=> <li key={t._id}>{t.number} - {new Date(t.date).toLocaleString()}</li>)}</ul></div>) : (<div>Not logged in</div>)}</div>);
}
export default App;