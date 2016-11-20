// @flow
import React from 'react';
import ReactDOM from 'react-dom';

import FiddlingContainer from './fiddlings/FiddlingContainer';

window.onload = () => {
  ReactDOM.render(<FiddlingContainer />, document.querySelector('#root'));
}
