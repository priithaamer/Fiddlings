const electron = require('electron');
const fs = require('fs');
const {ipcRenderer} = require('electron');
const CodeMirror = require('codemirror');
const htmlmixedmode = require('codemirror/mode/htmlmixed/htmlmixed');
const cssmode = require('codemirror/mode/css/css');
const jsmode = require('codemirror/mode/javascript/javascript');

ipcRenderer.on('file-open', (event, fileName) => {
  fs.readFile(fileName, 'utf-8', (err, data) => {
    if (err) {
      alert('An error ocurred reading the file: ' + err.message);
      return;
    }

    const contents = JSON.parse(data);

    if (contents.version === '1.0') {
      htmlEditor.doc.setValue(contents.html);
      cssEditor.doc.setValue(contents.css);
      jsEditor.doc.setValue(contents.javascript);
    }
  });
});

ipcRenderer.on('file-save-as', (event, fileName) => {
  const contents = JSON.stringify({
    version: '1.0',
    html: htmlEditor.doc.getValue(),
    css: cssEditor.doc.getValue(),
    javascript: jsEditor.doc.getValue()
  });

  fs.writeFile(fileName, contents, (err) => {
    if (err) {
      alert('An error ocurred creating the file ' + err.message);
    }

    // TODO: Notify that file has been saved
  });
});

const {remote} = electron;
const {Menu} = remote;

const InputMenu = Menu.buildFromTemplate(
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
