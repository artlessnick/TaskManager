import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles(() => ({
  modal: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    outline: 0,
    overflow: 'scroll',
  },

  root: {
    width: 465,
  },

  loader: {
    display: 'flex',
    justifyContent: 'center',
  },

  actions: {
    display: 'flex',
    justifyContent: 'flex-end',
  },

  previewContainer: {
    justifyContent: 'center',
  },

  preview: {
    display: 'flex',
    height: 200,
  },
}));

export default useStyles;
