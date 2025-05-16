import React from 'react';

const FetchExample = () => {
  const [data, setData] = React.useState(null);
  const [error, setError] = React.useState(null);
  const [loading, setLoading] = React.useState(false);

  React.useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const response = await fetch(
          'https://jsonplaceholder.typicode.com/todos/1'
        );
        const json = await response.json();
        setData(json);
      } catch (error) {
        setError(error);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) return 'Loading...';
  if (error) return 'Error!';
  if (!data) return null;

  return (
    <div>
      <p>{JSON.stringify(data)}</p>
    </div>
  );
};

export default FetchExample;
