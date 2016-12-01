// @flow
const DefaultHtml = '<h1>Welcome to <b>Fiddlings!</b></h1>';

const DefaultCss = `body {
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

export default class Fiddling {

  static getDefaultFiddling = () => new Fiddling(DefaultHtml, DefaultCss, '');

  static parse = function(data) {

  };

  version = '1.0';

  html: string;

  css: string;

  javascript: string;

  constructor(html: string = '', css: string = '', javascript: string = '') {
    this.html = html;
    this.css = css;
    this.javascript = javascript;
  }

  toJSON() {
    return {
      version: this.version,
      html: {
        data: this.html
      },
      css: {
        data: this.css
      },
      javascript: {
        data: this.javascript
      }
    };
  }
}
