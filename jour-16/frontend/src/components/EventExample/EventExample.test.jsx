import React from "react";
import { render, screen, fireEvent } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import EventExample from "./EventExample";

test("EventExample initial", () => {
  render(<EventExample />);
  const input = screen.getByTestId("input");
  const text = screen.getByText("Hello, World!");

  expect(input.value).toBe("World");
  expect(text.textContent).toBe("Hello, World!");
});

test("EventExample change", () => {
    render(<EventExample />);
    const input = screen.getByTestId("input");
    const text = screen.getByText("Hello, World!");
  
    fireEvent.change(input, { target: { value: "React" } });
  
    expect(input.value).toBe("React");
    expect(text.textContent).toBe("Hello, React!");
  });

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