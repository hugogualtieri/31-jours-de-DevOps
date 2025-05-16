import React from 'react';
import {render, screen} from '@testing-library/react';

import SimpleComponentWithProps from './SimpleComponentWithProps';

test('renders without a name', () => {
  render(<SimpleComponentWithProps />);
  const linkElement = screen.getByText(/Hey, stranger/i);
  expect(linkElement).toBeInTheDocument();
});

test('renders with a name', () => {
  render(<SimpleComponentWithProps name="Mark" />);
  const linkElement = screen.getByText(/Hello, Mark!/i);
  expect(linkElement).toBeInTheDocument();
});
