import React, { useState } from 'react';
import { submitFeedback } from '../api';

const FeedbackForm = () => {
  const [name, setName] = useState('');
  const [message, setMessage] = useState('');
  const [response, setResponse] = useState('');

  const handleSubmit = async () => {
    const res = await submitFeedback(name, message);
    setResponse(res.status);
  };

  return (
    <div>
      <input
        placeholder="Your Name"
        value={name}
        onChange={(e) => setName(e.target.value)}
      /><br /><br />
      <textarea
        placeholder="Your Message"
        value={message}
        onChange={(e) => setMessage(e.target.value)}
      /><br /><br />
      <button onClick={handleSubmit}>Submit</button>
      <p>{response}</p>
    </div>
  );
};

export default FeedbackForm;
