# Unit Testing with React

# **What is testing, and Why?**

Unit testing is a method by which you verify the small parts of code independently.

Testing is checking your application. It can be done in two ways. The first is that you can write code and preview it in a browser; you see what your users will see. This is called manual testing. The second is that you write the code that tests your code, called automated testing. The challenging aspect of the first approach is testing all potential combinations and scenarios, which takes a lot of time and isn't always feasible. At this point, we write the code that tests our code.

![1](https://miro.medium.com/max/640/1*ES8cBlgPWbbEeo7Bk9g57g.png)

I'll discuss three different types of automated tests.

# **Understanding different tests**

The first is that this article's focus is on unit tests.

**Unit testing** is a method of testing that isolates small code blocks**.** I mean that code blocks are functions and components. The isolation unit test does not care about how the application works, it cares about how the little parts of the application work. Projects typically contain dozens or hundreds of unit tests.

**Integration testing** is a method in which you test the modules of the application that are connected. It’s about ensuring the accuracy of the created software modules by bringing them together. All modules created for the software product are put together and tested in this way. Projects typically contain a couple of integration tests.

**End-to-end testing** is a method that allows you to complete scenarios and application workflows from start to finish as the user experiences them. This technique seeks to test actual user scenarios to verify the system’s integration and data integrity. Projects typically contain only a few E2E tests.

![2](https://miro.medium.com/max/700/1*25ZqZZuDh12F6Pd9g53Rcg.png)

# **Requirements**

In this article, I use *"npx create-react-app’’* which provides us with the required tools and setup. If you want to try step by step, you can open the terminal and write below.

```bash

npx create-react-app 'your-app-name'
```

For running our tests and asserting results, we need “*JEST*” and “*React Testing Library”* to simulate our react components. Both tools are already set up for us when using *"create-react-app.*"

# **Building Blocks**

There is a method called AAA (Arrange-Act-Assert) and we are following these steps. The first step is to arrange In this step, we set up the test data, test conditions, and test environment. The second step is to act. In this step, we run the logic that should be tested. The third step is to assert. In this step, we compare the execution results with the expected results.

![3](https://miro.medium.com/max/700/1*b-9mFRsbV9XihnB1dcw8Bg.png)

# **Testing a React Component**

Let’s start with a simple component. We will test a component that renders the “*SimpleComponent*’’ text.

```jsx
import React from "react";

const SimpleComponent = () => {
  return <p>SimpleComponent</p>;
};

export default SimpleComponent;
```

We will test this component with JEST and the React Testing Library. Firstly, we need to import the render method from the React testing library. Then we will render the component, try to find it with queries, and check if the component renders the text "*SimpleComponent*."

```jsx
import React from "react";
import { render, screen } from "@testing-library/react";
import SimpleComponent from "./SimpleComponent";

test("renders SimpleComponent", () => {
  render(<SimpleComponent />); // arrange
  const linkElement = screen.getByText(/SimpleComponent/i); // act but not really act because we are not doing anything
  expect(linkElement).toBeInTheDocument(); // assert
});
```

To run the test, we need to type “*npm test*” in the terminal.

![4](https://miro.medium.com/max/700/0*DmhDznh8AKhKN0nx)
 

And that's it. We have our first test. Before diving into the details. The testing library has 3 different(”get”, “find”, and “query”) query types. I’m not going to add this table but we will use it in most of our tests. If you have time please check.

[About Queries | Testing Library](https://testing-library.com/docs/queries/about/#types-of-queries)

## **Testing a React Component with Props**

Let’s create a component that renders a text that is passed as a prop.

```jsx
import React from "react";

const SimpleComponentWithProps = (props) => {
  if (props.name) {
    return <h1>Hello, {props.name}!</h1>;
  } else {
    return <h1>Hey, stranger</h1>;
  }
};

export default SimpleComponentWithProps;
```

We will test two cases. One of them is without props, and the other one is with props. In the without props case, our test looks like our first example. Just renders “Hey, stranger”.

```jsx
import React from "react";
import { render, screen } from "@testing-library/react";

import SimpleComponentWithProps from "./SimpleComponentWithProps";

test("SimpleComponentWithProps renders without a name", () => {
  render(<SimpleComponentWithProps />);
  const linkElement = screen.getByText(/Hey, stranger/i);
  expect(linkElement).toBeInTheDocument();
});
```

In the with props case, we will just give a name with props and we expect it to render “Hello, {name} !”.

```jsx
test("renders with a name", () => {
  render(<SimpleComponentWithProps name="Mark" />);
  const linkElement = screen.getByText(/Hello, Mark!/i);
  expect(linkElement).toBeInTheDocument();
});
```

By the way in the queries with text, we can use ‘string’, ‘regex’, or a custom function. In this example, we can write like that too.

```jsx
// Matching a string:
screen.getByText('Hello, Mark!') // full string match
screen.getByText('llo, Mark!', {exact: false}) // substring match
screen.getByText('hello, mark!', {exact: false}) // ignore case

// Matching a regex:
screen.getByText(/Mark!/) // substring match
screen.getByText(/mark/i) // substring match, ignore case
screen.getByText(/^hello, mark!$/i) // full string match, ignore case

// Matching with a custom function:
screen.getByText((content, element) => content.startsWith('Hello'))
```

## **Testing a React Component with Events**

Let’s create a component that when we write something in input, that shows us above the input “Hello, {name}!”. We also have some states to keep the data and ‘change’ event to update our state.

```jsx
import React from "react";

const EventExample = () => {
  const [name, setName] = React.useState("World");
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
```

We will first test the initial condition. If we don’t write something in the input we will just see the “Hello, !” text. Here something is different. We give “data-testid” to input for easy selection of our input.

```jsx
import React from "react";
import { render, screen, fireEvent } from "@testing-library/react";
import EventExample from "./EventExample";

test("EventExample initial", () => {
  render(<EventExample />);
  const input = screen.getByTestId("input");
  const text = screen.getByText("Hello, World!");

  expect(input.value).toBe("World");
  expect(text.textContent).toBe("Hello, World!");
});
```

In the second test, we will fire an event for the acting. We will pretend we are writing and we will try to see it in the text part of the component.

```jsx
test("EventExample change", () => {
  render(<EventExample />);
  const input = screen.getByTestId("input");
  const text = screen.getByText("Hello, World!");

  fireEvent.change(input, { target: { value: "React" } });

  expect(input.value).toBe("React");
  expect(text.textContent).toBe("Hello, React!");
});
```

We can also use *“user-event”* too. The difference between *“user-event”* and *“fireEvent”* is “*fireEvent*” dispatches *DOM events*, whereas *“user-event”* simulates full interactions, which may fire multiple events and do additional checks along the way.

So our *“user-event”* example is like this below:

```jsx
import userEvent from "@testing-library/user-event";

test("EventExample change with user-event", () => {
  // arrange
  render(<EventExample />);
  const input = screen.getByTestId("input");
  const text = screen.getByText("Hello, World!");

  // act
  for (let i = 0; i < 5; i++) {
    userEvent.type(input, "{backspace}");
  }

  userEvent.type(input, "React");

  // assert
  expect(input.value).toBe("React");
  expect(text.textContent).toBe("Hello, React!");
});
```

## **Testing a React Component with Fetching Data**

Just like other examples, firstly we will create a component that fetches some data and with states, we will manage the success, loading, and error cases.

We will start the states with null. Also, we will use the *“useEffect”* with an empty array just because we just want to fetch it at the start. Also inside of the *“useEffect”* we will change the states regarding the fetch results. While fetching, we will show the user some loading text. And finally, if the fetching result is successful, we will show the result of the fetch.

```jsx
import React from "react";

const FetchExample = () => {
  const [data, setData] = React.useState(null);
  const [error, setError] = React.useState(null);
  const [loading, setLoading] = React.useState(false);

  React.useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const response = await fetch(
          "https://jsonplaceholder.typicode.com/todos/1"
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

  if (loading) return "Loading...";
  if (error) return "Error!";
  if (!data) return null;

  return (
    <div>
      <p>{JSON.stringify(data)}</p>
    </div>
  );
};

export default FetchExample;
```

Now we will test this component. We will test the success, error, and loading cases. For the success case, we will check if the component renders the data. For the error case, we will check if the component renders the error text. For the loading case, we will check if the component renders the loading text.

```jsx
import React from "react";
import { render, screen, act } from "@testing-library/react";
import FetchExample from "./FetchExample";

// loading
test("FetchExample loading", () => {
  render(<FetchExample />);
  const text = screen.getByText("Loading...");
  expect(text.textContent).toBe("Loading...");
});
```

For the error case, we will use the “mock” method. Because we don’t want to make a real fetch request. Sending real requests can be expensive or in the test time, the service can be inaccessible. That causes failure of the unit tests. We just want to test the component. So we will mock the fetch method and we will throw an error. Then we will check if the component renders the error text.

```jsx
// with mock data and error
test("FetchExample error", async () => {
  const mockError = new Error("Something went wrong");
  const mockFetchPromise = Promise.reject(mockError);
  jest.spyOn(global, "fetch").mockImplementation(() => mockFetchPromise);

  render(<FetchExample />);

  expect(screen.getByText("Loading...")).toBeInTheDocument();

  const error = await screen.findByText("Error!");

  expect(error).toBeInTheDocument();

  global.fetch.mockRestore();
});
```

For the success case, we will use the “mock” method again for the same reason. We will mock the fetch method and we will return a JSON object. Then we will check if the component renders the data.

```jsx
test("FetchExample success", async () => {
  const mockData = {
    userId: 1,
    id: 1,
    title: "delectus aut autem",
    completed: false,
  };
  const mockJsonPromise = Promise.resolve(mockData);
  const mockFetchPromise = Promise.resolve({
    json: () => mockJsonPromise,
  });
  jest.spyOn(global, "fetch").mockImplementation(() => mockFetchPromise);

  render(<FetchExample />);

  expect(screen.getByText("Loading...")).toBeInTheDocument();

  const data = await screen.findByText(JSON.stringify(mockData));

  expect(data).toBeInTheDocument();

  global.fetch.mockRestore();
});
```

# **Resources**

- [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
- [React Testing Library Cheat Sheet](https://testing-library.com/docs/react-testing-library/cheatsheet/)
- [React — The Complete Guide (incl Hooks, React Router, Redux) by Maximilian Schwarzmüller](https://www.udemy.com/course/react-the-complete-guide-incl-redux/)