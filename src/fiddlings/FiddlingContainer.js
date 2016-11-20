// @flow
import React from 'react';

export default class FiddlingContainer extends React.Component {

  componentDidMount() {
    const webViewContainer = this.refs.webViewContainer;

    const webView = document.createElement('webview');
    webView.setAttribute('class', 'preview-container');
    webView.setAttribute('id', 'preview');
    webView.setAttribute('src', './preview.html');
    webView.setAttribute('nodeintegration', 'true');

    webViewContainer.appendChild(webView);
  }

  render() {
    return (
      <div className="fiddling-container">
        <div className="pane-editors">
          <div className="editor-container">
            <div className="editor-name">HTML</div>
            <div className="editor html-editor"></div>
          </div>
          <div className="editor-container">
            <div className="editor-name">CSS</div>
            <div className="editor css-editor"></div>
          </div>
          <div className="editor-container">
            <div className="editor-name">JavaScript</div>
            <div className="editor js-editor"></div>
          </div>
        </div>
        <div className="pane-preview" ref="webViewContainer" />
      </div>
    );
  }
}
