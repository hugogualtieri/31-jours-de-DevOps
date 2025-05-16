import React from "react";
import { render, screen, act } from "@testing-library/react";
import FetchExample from "./FetchExample";

// loading
test("FetchExample loading", () => {
  render(<FetchExample />);
  const text = screen.getByText("Loading...");
  expect(text.textContent).toBe("Loading...");
});

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

  // with mock data and success
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