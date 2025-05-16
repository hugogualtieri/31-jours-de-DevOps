import React from "react";

const SimpleComponentWithProps = (props) => {
  if (props.name) {
    return <h1>Hello, {props.name}!</h1>;
  } else {
    return <h1>Hey, stranger</h1>;
  }
};

export default SimpleComponentWithProps;