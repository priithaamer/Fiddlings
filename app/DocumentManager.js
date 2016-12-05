const electron = require('electron');
const {ipcMain} = require('electron');
const fs = require('fs');
const path = require('path');
const uuid = require('uuid');
const BrowserWindow = electron.BrowserWindow;

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

// TODO: Ask save confirm dialog before closing edited window
class DocumentManager {

  constructor() {
    this.windows = new Map();

    ipcMain.on('fiddling-changed', this.handleFiddlingChanged.bind(this));
  }

  get size() {
    return this.windows.size;
  }

  getDocumentByFilename(fileName) {
    const document = Array.from(this.windows).find(([id, window]) => {
      return window.fileName === fileName;
    });

    if (document) {
      return document[1];
    } else {
      return null;
    }
  }

  getDocumentByWindow(window) {
    return this.windows.get(window.id);
  }

  setWindowFilename(window, fileName) {
    this.windows.set(window.id, Object.assign({}, this.windows.get(window.id), {fileName}));
  }

  // TODO: Compare saved state and actual document state. Otherwise, it may
  // get off the track quickly by doing undo etc.
  setWindowEditStatus(window, status) {
    window.setDocumentEdited(status);
  }

  getDocumentContents(window, callback) {
    const id = uuid.v4();
    ipcMain.once(id, (event, data) => {
      callback(data);
    });
    window.webContents.send('get-contents', id);
  }

  newDocument() {
    const window = this.createWindow();
    window.once('ready-to-show', () => {
      this.setWindowContents(window, {
        html: {data: DefaultHtml},
        css: {data: DefaultCss},
        javascript: {data: ''}
      });
      window.show();
    });
  }

  // TODO: Work with file descriptors instead. This way we can survive file move etc.
  openDocument(fileName) {
    const existingWindow = this.getDocumentByFilename(fileName);
    if (existingWindow && existingWindow.window) {
      existingWindow.window.show();
      return;
    }

    fs.readFile(fileName, 'utf-8', (err, data) => {
      if (err) {
        alert('An error ocurred reading the file: ' + err.message);
        return;
      }

      const basename = path.basename(fileName);

      const window = this.createWindow({fileName});
      window.setRepresentedFilename(basename);
      window.setTitle(basename);
      window.once('ready-to-show', () => {
        this.setWindowContents(window, JSON.parse(data));
        window.show();
      });

      this.addAppRecentDocument(fileName);
    });
  }

  // TODO: Notify that file has been saved
  saveDocument(window, getSavePath) {
    this.getDocumentContents(window, (data) => {
      const contents = JSON.stringify(data);
      const document = this.getDocumentByWindow(window);

      const saveFile = (fileName, contents) => {
        fs.writeFile(fileName, contents, (err) => {
          if (err) {
            alert(err.message);
          }

          this.setWindowEditStatus(window, false);
        });
      };

      if (document.fileName && fs.existsSync(document.fileName)) {
        saveFile(document.fileName, contents);
      } else {
        getSavePath(window, (fileName) => {
          const basename = path.basename(fileName);
          saveFile(fileName, contents);
          this.setWindowFilename(window, fileName);
          window.setRepresentedFilename(basename);
          window.setTitle(basename);
        });
      }
    });
  }

  saveDocumentAs(window, fileName) {
    this.getDocumentContents(window, (data) => {
      const contents = JSON.stringify(data);

      const basename = path.basename(fileName);
      // TODO: This is duplicated with the one in saveDocument. Extract into storage module.
      fs.writeFile(fileName, contents, (err) => {
        if (err) {
          alert(err.message);
        }

        this.setWindowEditStatus(window, false);
      });
      this.setWindowFilename(window, fileName);
      window.setRepresentedFilename(basename);
      window.setTitle(basename);

      this.addAppRecentDocument(fileName);
    });
  }

  reloadDocument(window) {
    this.getDocumentContents(window, (data) => {
      window.reload();
      window.webContents.once('did-finish-load', () => {
        this.setWindowContents(window, data);
      });
    });
  }

  setWindowContents(window, data) {
    window.webContents.send('set-contents', window.id, data);
  }

  // TODO: Handle recent document click
  addAppRecentDocument(fileName) {
  }

  handleFiddlingChanged(event, id) {
    if (this.windows.has(id)) {
      const {window} = this.windows.get(id);
      this.setWindowEditStatus(window, true);
    }
  }

  // Dereference the window object, usually you would store windows
  // in an array if your app supports multi windows, this is the time
  // when you should delete the corresponding element.
  // TODO: Implement window close function
  handleWindowClosed(event) {
    // console.log(event);
    //
    // console.log(this.windows, event.sender.id);
    // console.log(window.id);

    // this.windows.delete(event.sender.id);
  }

  createWindow(options) {
    // Create the browser window.
    const window = new BrowserWindow({width: 1000, height: 700, vibrancy: 'light', show: false});

    // and load the index.html of the app.
    window.loadURL(`file://${__dirname}/../index.html`);

    // Emitted when the window is closed.
    window.on('closed', this.handleWindowClosed.bind(this));

    this.windows.set(window.id, Object.assign({}, options, {window, id: window.id}));

    return window;
  }
}

module.exports = DocumentManager;
