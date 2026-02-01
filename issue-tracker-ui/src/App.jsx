import { useState } from "react";
import Login from "./Login";
import Issues from "./Issues";

export default function App() {
  const [loggedIn, setLoggedIn] = useState(!!localStorage.getItem("token"));

  return loggedIn ? <Issues /> : <Login onLogin={() => setLoggedIn(true)} />;
}
