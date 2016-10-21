// This file is required by the index.html file and will
// be executed in the renderer process for that window.
// All of the Node.js APIs are available in this process.

// const ace = require('ace-builds/src/ace');

const htmlEditor = ace.edit(document.querySelector('.html-editor'));
htmlEditor.session.setMode('ace/mode/html');
htmlEditor.session.on('change', (event, session) => {
  updateContents('html', session.getValue());
});

const cssEditor = ace.edit(document.querySelector('.css-editor'));
cssEditor.session.setMode('ace/mode/css');
cssEditor.session.on('change', (event, session) => {
  updateContents('css', session.getValue());
});

const jsEditor = ace.edit(document.querySelector('.js-editor'));
jsEditor.session.setMode('ace/mode/javascript');
jsEditor.session.on('change', (event, session) => {
  updateContents('javascript', session.getValue());
});

const preview = document.querySelector('#preview');

const updateContents = (kind, contents) => {
  preview.send('updater', kind, contents);
};

preview.addEventListener('console-message', (e) => {
  console.log('Guest page logged a message:', e.message);
});
