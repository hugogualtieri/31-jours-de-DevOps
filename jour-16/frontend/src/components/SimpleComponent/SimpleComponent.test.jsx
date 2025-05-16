import React from "react";
import { render, screen } from "@testing-library/react";
import SimpleComponent from "./SimpleComponent";

test("renders SimpleComponent", () => {
  render(<SimpleComponent />); // arrange
  const linkElement = screen.getByText(/SimpleComponent/i); // act but not really act because we are not doing anything
  expect(linkElement).toBeInTheDocument(); // assert
});