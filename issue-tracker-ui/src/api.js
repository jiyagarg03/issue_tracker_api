const API_URL = "http://localhost:3000";

export function getToken() {
  return localStorage.getItem("token");
}

export async function apiRequest(path, method = "GET", body) {
  const res = await fetch(`${API_URL}${path}`, {
    method,
    headers: {
      "Content-Type": "application/json",
      Authorization: getToken() ? `Bearer ${getToken()}` : "",
    },
    body: body ? JSON.stringify(body) : null,
  });

  if (res.status === 401) {
    localStorage.removeItem("token");
  }

  return res.json();
}
