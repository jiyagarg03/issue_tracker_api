import { apiRequest } from "./api";
import { useEffect, useState } from "react";

export default function Issues() {
  const [issues, setIssues] = useState([]);

  async function loadIssues() {
    const res = await apiRequest("/issues");

    if (Array.isArray(res.issues)) {
      setIssues(res.issues);
    } else if (Array.isArray(res)) {
      setIssues(res);
    } else {
      setIssues([]); // fallback
    }
  }

  async function createIssue(e) {
    e.preventDefault();

    await apiRequest("/issues", "POST", {
      title: e.target.title.value,
      description: e.target.description.value,
      status: "open",
      priority: "medium",
    });

    loadIssues();
  }

  useEffect(() => {
    loadIssues();
  }, []);

  return (
    <div>
      <h2>Issues</h2>

      <form onSubmit={createIssue}>
        <input name="title" placeholder="title" />
        <input name="description" placeholder="description" />
        <button>Create</button>
      </form>

      <ul>
        {issues.map((i) => (
          <li key={i.id}>
            {i.title} — {i.status}
          </li>
        ))}
      </ul>
    </div>
  );
}
