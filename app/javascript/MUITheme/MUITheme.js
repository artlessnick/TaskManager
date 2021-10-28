/* import { useState } from 'react'; */
import * as React from 'react';
import IconButton from '@material-ui/core/IconButton';
import { ThemeProvider } from '@material-ui/core/styles';
import { Brightness7, Brightness4 } from '@material-ui/icons';
import { blueTheme, lightTheme } from './theme';

const MUITheme = ({ children }) => {
  const [mode, setTheme] = React.useState('light');

  const changeTheme = () => {
    setTheme((prevMode) => (prevMode === 'light' ? 'blue' : 'light'));
  };

  const theme = mode === 'light' ? lightTheme : blueTheme;

  return (
    <>
      <ThemeProvider theme={theme}>{children}</ThemeProvider>
      <IconButton onClick={changeTheme}>{mode === 'blue' ? <Brightness7 /> : <Brightness4 />}</IconButton>
    </>
  );
};

export default MUITheme;
