// @flow
import React from 'react';
import CodeMirror from 'codemirror';
import htmlmixedmode from 'codemirror/mode/htmlmixed/htmlmixed'; // eslint-disable-line no-unused-vars
import cssmode from 'codemirror/mode/css/css'; // eslint-disable-line no-unused-vars
import jsmode from 'codemirror/mode/javascript/javascript'; // eslint-disable-line no-unused-vars

const editorOptions = {
  indentUnit: 2,
  smartIndent: true,
  tabSize: 2,
  lineNumbers: true,
  theme: 'fiddlings',
  viewportMargin: Infinity
};

export default class CodeMirrorContainer extends React.Component {

  editor: CodeMirror;

  props: {
    defaultValue: string,
    mode: 'htmlmixed' | 'css' | 'javascript',
    className: string,
    handleChange(value: string): void
  }

  componentDidMount() {
    this.editor = CodeMirror(this.refs.editorContainer, Object.assign({}, editorOptions, {
      value: this.props.defaultValue,
      mode: this.props.mode
    }));
    this.editor.on('change', (editor, change) => {
      this.props.handleChange(editor.doc.getValue());
    });
  }

  render() {
    return (
      <div className={this.props.className} ref="editorContainer"></div>
    );
  }
}
