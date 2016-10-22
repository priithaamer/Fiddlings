const CodeMirror = require('codemirror');
const htmlmixedmode = require('codemirror/mode/htmlmixed/htmlmixed');
const cssmode = require('codemirror/mode/css/css');
const jsmode = require('codemirror/mode/javascript/javascript');

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
  console.log('Guest page logged a message:', e.message);
});

preview.addEventListener('dom-ready', () => {
  updateContents('html', htmlEditor.doc.getValue());
  updateContents('css', cssEditor.doc.getValue());
  updateContents('javascript', jsEditor.doc.getValue());
});
