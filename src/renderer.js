// @flow
import React from 'react';
import ReactDOM from 'react-dom';
import fs from 'fs';
import {ipcRenderer, remote} from 'electron';

import FiddlingContainer from './fiddlings/FiddlingContainer';

ipcRenderer.on('file-open', (event, fileName) => {
  fs.readFile(fileName, 'utf-8', (err, data) => {
    if (err) {
      alert('An error ocurred reading the file: ' + err.message);
      return;
    }

    const contents = JSON.parse(data);

    if (contents.version === '1.0') {
      // TODO: set value from contents.html, contents.css, contents.javascript
    }
  });
});

ipcRenderer.on('file-save-as', (event, fileName) => {
  const contents = JSON.stringify({
    version: '1.0'
    // TODO: Read write values from editor
    // html: htmlEditor.doc.getValue(),
    // css: cssEditor.doc.getValue(),
    // javascript: jsEditor.doc.getValue()
  });

  fs.writeFile(fileName, contents, (err) => {
    if (err) {
      alert('An error ocurred creating the file ' + err.message);
    }

    // TODO: Notify that file has been saved
  });
});

const InputMenu = remote.Menu.buildFromTemplate(
  [
    {label: 'Undo', role: 'undo'},
    {label: 'Redo', role: 'redo'},
    {type: 'separator'},
    {label: 'Cut', role: 'cut'},
    {label: 'Copy', role: 'copy'},
    {label: 'Paste', role: 'paste'},
    {type: 'separator'},
    {label: 'Select all', role: 'selectall'}
  ]
);

window.addEventListener('contextmenu', (e) => {
  e.preventDefault();
  InputMenu.popup(remote.getCurrentWindow());
});

window.onload = () => {
  ReactDOM.render(<FiddlingContainer />, document.querySelector('#root'));
}
