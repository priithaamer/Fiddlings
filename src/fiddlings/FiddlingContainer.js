// @flow
import React from 'react';
import ClassSet from 'react-classset';

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

  state: {
    consoleVisible: boolean,
    consoleInputValue: string,
    consoleLines: Array<string>
  }

  constructor() {
    super();
    this.state = {
      consoleVisible: false,
      consoleInputValue: '',
      consoleLines: []
    };
  }

  componentDidMount() {
    const webViewContainer = this.refs.webViewContainer;

    this.webView = document.createElement('webview');
    this.webView.setAttribute('class', 'preview-frame');
    this.webView.setAttribute('id', 'preview');
    this.webView.setAttribute('src', './preview.html');
    this.webView.setAttribute('nodeintegration', 'true');

    this.webView.addEventListener('console-message', e => {
      this.appendToConsoleLog(e.message);
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

  appendToConsoleLog(...lines: Array<string>) {
    this.setState({
      consoleLines: [...this.state.consoleLines, ...lines]
    }, () => {
      this.refs.consoleInput.scrollIntoView();
    });
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

  handleConsoleToggleClick() {
    this.setState({
      consoleVisible: !this.state.consoleVisible
    });
  }

  handleConsoleInputChange(event: Event) {
    if (event.target instanceof HTMLInputElement) {
      const value = event.target.value;
      this.setState({consoleInputValue: value});
    }
  }

  handleConsoleKeyup(event: KeyboardEvent) {
    if (event.key === 'Enter' && event.target instanceof HTMLInputElement) {
      const input = event.target;
      const inputValue = input.value;

      this.webView.executeJavaScript(inputValue, false, (result) => {
        this.appendToConsoleLog(inputValue, JSON.stringify(result));
      });

      this.setState({
        consoleInputValue: ''
      }, () => {
        input.focus();
      });
    }
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
            <div
              className="controls-container-console"
              onClick={this.handleConsoleToggleClick.bind(this)}
              >
              Console
            </div>
          </div>
        </div>
        <div className="pane-preview">
          <div className="preview-container" ref="webViewContainer"></div>
          <div className={ClassSet({'console-container': true, 'console-container-visible': this.state.consoleVisible})}>
            <div className="console-lines">
              {this.state.consoleLines.map((line, idx) => (<div key={idx}>{line}</div>))}
            </div>
            <input
              type="text"
              ref="consoleInput"
              className="console-input"
              value={this.state.consoleInputValue}
              onChange={this.handleConsoleInputChange.bind(this)}
              onKeyUp={this.handleConsoleKeyup.bind(this)}
              />
          </div>
        </div>
      </div>
    );
  }
}
