// @flow
import React from 'react';

import CodeMirror from '../lib/components/CodeMirror';

const DEFAULT_HTML = '<h1>Welcome to <b>Fiddlings!</b></h1>';

const DEFAULT_CSS = `body {
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

const DEFAULT_JS = '';

export default class FiddlingContainer extends React.Component {

  webView: any;

  componentDidMount() {
    const webViewContainer = this.refs.webViewContainer;

    this.webView = document.createElement('webview');
    this.webView.setAttribute('class', 'preview-container');
    this.webView.setAttribute('id', 'preview');
    this.webView.setAttribute('src', './preview.html');
    this.webView.setAttribute('nodeintegration', 'true');

    this.webView.addEventListener('console-message', e => {
      console.log('Preview pane log:', e.message);
    });

    this.webView.addEventListener('dom-ready', () => {
      this.updatePreview('html', DEFAULT_HTML);
      this.updatePreview('css', DEFAULT_CSS);
      this.updatePreview('javascript', DEFAULT_JS);
    });

    webViewContainer.appendChild(this.webView);
  }

  updatePreview(kind: 'html' | 'css' | 'javascript', value: string) {
    this.webView.send('updater', kind, value);
  }

  handleHtmlChanged(value: string) {
    this.updatePreview('html', value);
  }

  handleCssChanged(value: string) {
    this.updatePreview('css', value);
  }

  handleJavascriptChanged(value: string) {
    this.updatePreview('javascript', value);
  }

  render() {
    return (
      <div className="fiddling-container">
        <div className="pane-editors">
          <div className="editors-container">
            <div className="editor-container">
              <div className="editor-name">HTML</div>
              <CodeMirror
                defaultValue={DEFAULT_HTML}
                mode="htmlmixed"
                className="editor"
                handleChange={this.handleHtmlChanged.bind(this)}
              />
            </div>
            <div className="editor-container">
              <div className="editor-name">CSS</div>
              <CodeMirror
                defaultValue={DEFAULT_CSS}
                mode="htmlmixed"
                className="editor"
                handleChange={this.handleCssChanged.bind(this)}
              />
            </div>
            <div className="editor-container">
              <div className="editor-name">JavaScript</div>
              <CodeMirror
                defaultValue={DEFAULT_JS}
                mode="htmlmixed"
                className="editor"
                handleChange={this.handleJavascriptChanged.bind(this)}
              />
            </div>
          </div>
          <div className="controls-container">
            <div>Controls</div>
          </div>
        </div>
        <div className="pane-preview" ref="webViewContainer" />
      </div>
    );
  }
}
