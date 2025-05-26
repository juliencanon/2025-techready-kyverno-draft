import {
    Reveal
  } from '../web_modules/sfeir-school-theme/sfeir-school-theme.mjs';
  (() => {
    Reveal.on('ready', event => {
        setTimeout(() => {
          Reveal.configure({
            keyboard: {
              67: 'right',
              68: 'left',
              72: 'right',
              74: 'left
            }
          });
        }, 1000);
    });
    Reveal.sync();
  })();
