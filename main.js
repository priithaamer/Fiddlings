// @flow
const electron = require('electron');
const {Menu, dialog} = require('electron');
// Module to control application life.
const app = electron.app;
// Module to create native browser window.
const BrowserWindow = electron.BrowserWindow;

// Keep a global reference of the windows, if you don't, the windows will
// be closed automatically when the JavaScript object is garbage collected.
let windows = [];

function createWindow() {
  // Create the browser window.
  const window = new BrowserWindow({width: 1000, height: 700});

  // and load the index.html of the app.
  window.loadURL(`file://${__dirname}/index.html`);

  // Emitted when the window is closed.
  window.on('closed', function() {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    windows.splice(windows.indexOf(window), 1);
  });

  windows.push(window);

  return window;
}

function createMenu() {
  const template = [
    {
      label: 'File',
      submenu: [
        {
          label: 'New File',
          accelerator: 'CmdOrCtrl+Shift+N',
          click() {
            createWindow();
          }
        },
        {
          label: 'Open...',
          accelerator: 'CmdOrCtrl+O',
          click(item, focusedWindow) {
            dialog.showOpenDialog({properties: ['openFile']}, (fileNames) => {
              // fileNames is an array that contains all the selected
              if (fileNames === undefined) {
                return;
              }

              const window = createWindow();
              window.webContents.send('file-open', fileNames[0]);
            });
          }
        },
        {type: 'separator'},
        {
          label: 'Save',
          accelerator: 'CmdOrCtrl+S'
        },
        {
          label: 'Save as...',
          click(item, focusedWindow) {
            dialog.showSaveDialog((fileName) => {
              if (fileName === undefined) {
                return;
              }

              focusedWindow.webContents.send('file-save-as', fileName);
            });
          }
        }
      ]
    },
    {
      label: 'Edit',
      submenu: [
        {role: 'undo'},
        {role: 'redo'},
        {type: 'separator'},
        {role: 'cut'},
        {role: 'copy'},
        {role: 'paste'},
        {role: 'pasteandmatchstyle'},
        {role: 'delete'},
        {role: 'selectall'}
      ]
    },
    {
      label: 'View',
      submenu: [
        {role: 'togglefullscreen'}
      ]
    },
    {
      role: 'window',
      submenu: [
        {role: 'minimize'},
        {role: 'close'}
      ]
    },
    {
      role: 'help',
      submenu: [
        {
          label: 'Learn More',
          click() {
            // TODO: Link to fiddlings documentation site
            require('electron').shell.openExternal('https://github.com/priithaamer/Fiddlings');
          }
        }
      ]
    }
  ];

  if (process.platform === 'darwin') {
    const name = electron.app.getName();

    template.unshift({
      label: name,
      submenu: [
        {role: 'about'},
        {type: 'separator'},
        {role: 'services', submenu: []},
        {type: 'separator'},
        {role: 'hide'},
        {role: 'hideothers'},
        {role: 'unhide'},
        {type: 'separator'},
        {role: 'quit'}
      ]
    });
    // Edit menu.
    template[1].submenu.push(
      {type: 'separator'},
      {label: 'Speech', submenu: [{role: 'startspeaking'}, {role: 'stopspeaking'}]}
    );
    // Window menu.
    template[4].submenu = [
      {label: 'Close', accelerator: 'CmdOrCtrl+W', role: 'close'},
      {label: 'Minimize', accelerator: 'CmdOrCtrl+M', role: 'minimize'},
      {label: 'Zoom', role: 'zoom'},
      {type: 'separator'},
      {label: 'Bring All to Front', role: 'front'}
    ];
  }

  if (process.env.NODE_ENV === 'development') {
    template[3].submenu.push(
      {type: 'separator'},
      {
        label: 'Reload',
        accelerator: 'CmdOrCtrl+R',
        click(item, focusedWindow) {
          if (focusedWindow) {
            focusedWindow.reload();
          }
        }
      },
      {
        label: 'Toggle Developer Tools',
        accelerator: process.platform === 'darwin' ? 'Alt+Command+I' : 'Ctrl+Shift+I',
        click(item, focusedWindow) {
          if (focusedWindow) {
            focusedWindow.webContents.toggleDevTools();
          }
        }
      },
      {role: 'resetzoom'},
      {role: 'zoomin'},
      {role: 'zoomout'}
    );
  }

  const menu = Menu.buildFromTemplate(template);
  Menu.setApplicationMenu(menu);
}

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on('ready', createWindow);
app.on('ready', createMenu);

// Quit when all windows are closed.
app.on('window-all-closed', function() {
  // On OS X it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', function() {
  // On OS X it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (windows.length === 0) {
    createWindow();
  };
});

// In this file you can include the rest of your app's specific main process
// code. You can also put them in separate files and require them here.
