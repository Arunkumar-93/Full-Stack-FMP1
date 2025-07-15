export async function submitFeedback(name, message) {
  try {
    const res = await fetch('/api/feedback/', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name, message })
    });
    return await res.json();
  } catch (error) {
    return { status: 'error', error: error.message };
  }
}
