// @flow
import React from 'react';
import ReactDOM from 'react-dom';
import {ipcRenderer, remote} from 'electron';

import FiddlingContainer from './fiddlings/FiddlingContainer';
import Fiddling from './fiddlings/Fiddling';

let documentId;
let fiddling;

function handleContentChange() {
  ipcRenderer.send('fiddling-changed', documentId);
}

function renderFiddling() {
  ReactDOM.render((
    <FiddlingContainer
      fiddling={fiddling}
      onContentChange={handleContentChange}
      />
  ), document.querySelector('#root'));
}

ipcRenderer.on('set-contents', (event, id, data) => {

  console.log('set contents', id);

  documentId = id;
  // TODO: Recover from incorrect data
  fiddling = new Fiddling(data.html.data, data.css.data, data.javascript.data);
  renderFiddling();
});

ipcRenderer.on('get-contents', (event, id) => {
  event.sender.send(id, fiddling.toJSON());
});

// TODO: Maybe we can replace with this: https://pracucci.com/atom-electron-enable-copy-and-paste.html
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
