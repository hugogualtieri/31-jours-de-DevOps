import React from 'react';

const EventExample = () => {
  const [name, setName] = React.useState('World');
  const handleChange = (event) => {
    setName(event.target.value);
  };
  return (
    <div>
      <input
        type="text"
        value={name}
        onChange={handleChange}
        data-testid="input" // for testing
      />
      <p>Hello, {name}!</p>
    </div>
  );
};

export default EventExample;
