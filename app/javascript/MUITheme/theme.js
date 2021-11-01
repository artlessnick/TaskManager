import { createTheme } from '@material-ui/core/styles';

export const blueTheme = createTheme({
  palette: {
    text: {
      primary: '#FFFFFF',
      secondary: '#CFD8DC',
    },
    action: {
      active: '#90CAF9',
    },
    background: {
      paper: '#3f51b5',
    },
    primary: {
      main: '#BBDEFB',
    },
    secondary: {
      main: '#D1C4E9',
    },
  },
});

export const lightTheme = createTheme({
  palette: {
    background: {
      paper: '#edeffa',
    },
  },
});
