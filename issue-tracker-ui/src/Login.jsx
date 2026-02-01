import { apiRequest } from "./api";

export default function Login({ onLogin }) {
  async function handleLogin(e) {
    e.preventDefault();

    const email = e.target.email.value;
    const password = e.target.password.value;

    const res = await apiRequest("/login", "POST", { email, password });
    if (res.token) {
      localStorage.setItem("token", res.token);
      onLogin();
    } else {
      alert("Invalid credentials");
    }
  }

  return (
    <form onSubmit={handleLogin}>
      <h2>Login</h2>
      <input name="email" placeholder="email" />
      <input name="password" type="password" placeholder="password" />
      <button>Login</button>
    </form>
  );
}
