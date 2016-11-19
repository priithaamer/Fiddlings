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

const editorOptions = {
  indentUnit: 2,
  smartIndent: true,
  tabSize: 2,
  lineNumbers: true,
  theme: 'fiddlings',
  viewportMargin: Infinity
}

const cssContent = `body {
  font-family: 'Helvetica Neue';
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  padding: 0;
  margin: 0;
}

h1 {
  font-size: 38px;
  font-weight: 300;
  text-align: center;
}

b {
  font-weight: 500;
}`;

const htmlEditor = CodeMirror(document.querySelector('.html-editor'), Object.assign({}, editorOptions, {
  value: '<h1>Welcome to <b>Fiddlings!</b></h1>',
  mode: 'htmlmixed',
}));
htmlEditor.on('change', (editor, change) => {
  updateContents('html', editor.doc.getValue());
});

const cssEditor = CodeMirror(document.querySelector('.css-editor'), Object.assign({}, editorOptions, {
  value: cssContent,
  mode: 'css',
}));
cssEditor.on('change', (editor, change) => {
  updateContents('css', editor.doc.getValue());
});

const jsEditor = CodeMirror(document.querySelector('.js-editor'), Object.assign({}, editorOptions, {
  mode: 'javascript',
}));
jsEditor.on('change', (editor, change) => {
  updateContents('javascript', editor.doc.getValue());
});

const preview = document.querySelector('#preview');

const updateContents = (kind, contents) => {
  preview.send('updater', kind, contents);
};

preview.addEventListener('console-message', (e) => {
  console.log('Preview pane log:', e.message);
});

preview.addEventListener('dom-ready', () => {
  updateContents('html', htmlEditor.doc.getValue());
  updateContents('css', cssEditor.doc.getValue());
  updateContents('javascript', jsEditor.doc.getValue());
});

const consoleInput = document.querySelector('.console-input');
const consoleLines = document.querySelector('.console-lines');
consoleInput.addEventListener('keyup', (event) => {
  if (event.key === 'Enter') {
    const inputValue = event.target.value;

    preview.executeJavaScript(inputValue, false, (result) => {
      var line1 = document.createElement('div');
      line1.innerHTML = inputValue;
      consoleLines.appendChild(line1);
      var line = document.createElement('div');
      line.innerHTML = JSON.stringify(result);
      consoleLines.appendChild(line);
    });
    event.target.value = '';
    event.target.focus();
  }
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
