// This file is required by the index.html file and will
// be executed in the renderer process for that window.
// All of the Node.js APIs are available in this process.

const CodeMirror = require('codemirror');
const htmlmixedmode = require('codemirror/mode/htmlmixed/htmlmixed');
const cssmode = require('codemirror/mode/css/css');
const jsmode = require('codemirror/mode/javascript/javascript');

const editorOptions = {
  indentUnit: 2,
  smartIndent: true,
  tabSize: 2,
  lineNumbers: true
}

const htmlEditor = CodeMirror(document.querySelector('.html-editor'), Object.assign({}, editorOptions, {
  value: 'Hello!',
  mode: 'htmlmixed',
}));
htmlEditor.on('change', (editor, change) => {
  updateContents('html', editor.doc.getValue());
});

const cssEditor = CodeMirror(document.querySelector('.css-editor'), Object.assign({}, editorOptions, {
  value: 'body { color: red; }',
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
  console.log('Guest page logged a message:', e.message);
});

preview.addEventListener('dom-ready', () => {
  updateContents('html', htmlEditor.doc.getValue());
  updateContents('css', cssEditor.doc.getValue());
  updateContents('javascript', jsEditor.doc.getValue());
});
