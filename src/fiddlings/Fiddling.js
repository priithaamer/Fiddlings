// @flow
export default class Fiddling {

  static parse = function(data) {
    if (data.version === '1.0') {
      return new Fiddling(data.html.data, data.css.data, data.javascript.data);
    } else {
      return new Fiddling('', '', '');
    }
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
