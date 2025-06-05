import React from 'react';
import { render } from '@testing-library/react-native';
import App from '../src/App';

test('renders correctly', () => {
  const { getByText } = render(<App />);
  const linkElement = getByText(/Welcome to MyReactNativeApp/i);
  expect(linkElement).toBeTruthy();
});