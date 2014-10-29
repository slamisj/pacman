

Array.prototype.add = function(point) {
  if (!this.length) {
    return null;
  }
  var retval = [];
  retval[0] = this[0] + point[0];
  retval[1] = this[1] + point[1];
  return retval;
}

var Game = {

  /** 0 on the numeric keypad. */
  VK_NUMPAD0: 96,
  /** 1 on the numeric keypad. */
  VK_NUMPAD1: 97,
  /** 2 on the numeric keypad. */
  VK_NUMPAD2: 98,
  /** 3 on the numeric keypad. */
  VK_NUMPAD3: 99,
  /** 4 on the numeric keypad. */
  VK_NUMPAD4: 100,
  /** 5 on the numeric keypad. */
  VK_NUMPAD5: 101,
  /** 6 on the numeric keypad. */
  VK_NUMPAD6: 102,
  /** 7 on the numeric keypad. */
  VK_NUMPAD7: 103,
  /** 8 on the numeric keypad. */
  VK_NUMPAD8: 104,
  /** 9 on the numeric keypad. */
  VK_NUMPAD9: 105,

  DIR_RIGHT: 0,
  DIR_DOWN: 90,
  DIR_LEFT: 180,
  DIR_UP: 270,

  COLS: 21,
  ROWS: 15,

  WIDTH: 640,
  HEIGHT: 480,

  DIST: 30,
  STEP: 3,

  level: 1,

  players: [],

  getRandomInt: function (min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  },

  getMazeWidth: function() {
    return this.COLS * this.DIST;
  },
  getMazeHeight: function () {
    return this.ROWS * this.DIST;
  },

  dir2Rads: function(dir) {
    return dir / 360 * 2 * Math.PI;
  },

  dir2Array: function(dir) {
    var rads = Game.dir2Rads(dir);
    return [Math.cos(rads), Math.sin(rads)];
  },

  ctx: null,

  setContext: function(context) {
    this.ctx = context;
    this.ctx.lineWidth = 2;
  },

  drawCanvas: function(ctx) {
    this.ctx.fillStyle = "#000000";
    this.ctx.fillRect(0, 0, Game.WIDTH, Game.HEIGHT);
  },

  keyDown: function(keyCode) {
    switch (keyCode) {
      case Game.VK_NUMPAD4:
        Game.players[0].turn(Game.DIR_LEFT);
      break;
      case Game.VK_NUMPAD8:
        Game.players[0].turn(Game.DIR_UP);
      break;
      case Game.VK_NUMPAD6:
        Game.players[0].turn(Game.DIR_RIGHT);
      break;
      case Game.VK_NUMPAD5:
        Game.players[0].turn(Game.DIR_DOWN);
      break;
    }
  },

  run: function() {
    var canvas = document.getElementById('canvas');

    Game.players[0] = new this.Player();

    var ctx = canvas.getContext('2d');
    this.setContext(ctx);
    this.drawCanvas(this.ctx);
    Game.players[0].draw();
    //this.Maze.draw(this.ctx, 1);
    //alert('tu');

    document.onkeydown = function(event) {
      Game.keyDown(event.keyCode);
      Game.players[0].draw();
      Game.players[0].move();
    };


  }

}

Game.Console = {
  add: function(text) {
    //RETURN;
    var console = document.getElementById('console');
    console.innerHTML = console.innerHTML + '<br /> ' + text;
  }
}

Game.Player = function() {
  this.x = 20;
  this.y = 20;
  this.lastX = 20;
  this.lastY = 20;
  this.dir = Game.DIR_RIGHT;
}

Game.Player.prototype.setPosition = function(x, y) {
  this.x = x;
  this.y = y;
}

Game.Player.prototype.turn = function(dir) {
  this.dir = dir;
}

Game.Player.prototype.move = function() {
  var dirArray = Game.dir2Array(this.dir);
  [this.lastX, this.lastY] = [this.x, this.y];
  this.x += Game.STEP * dirArray[0];
  this.y += Game.STEP * dirArray[1];
}

Game.Player.prototype.draw = function() {
  var baseDir = this.dir / 360 * 2 * Math.PI;
  Game.ctx.lineWidth = 2;
  Game.ctx.fillStyle = "black";
  Game.ctx.beginPath();
  Game.ctx.arc(this.lastX, this.lastY, Game.DIST / 2 + 2, 0, Math.PI * 2);
  Game.ctx.closePath();
  Game.ctx.fill();

  Game.ctx.strokeStyle = "yellow";
  Game.ctx.beginPath();
  Game.ctx.arc(this.x, this.y, Game.DIST / 2, baseDir + Math.PI * 1/4, baseDir - Math.PI * 1/4);
  Game.ctx.lineTo(this.x, this.y);
  Game.ctx.closePath();
  Game.ctx.stroke();
}

Game.Maze = {
  RIGHT: [1, 0],
  DOWN: [0, 1],
  LEFT: [-1, 0],
  UP: [0, -1],
  DIRS: [[1, 0], [0, 1], [-1, 0], [0, -1]],
  getPixelColor: function(imageData, x, y) {
    //return '#ffffff';
    var offset = (630 * y + x) * 4;


    var color = "#" + ("000000" + ((imageData[offset] << 16) | (imageData[offset + 1] << 8) | imageData[offset + 2]).toString(16)).slice(-6);

    return color;
  },
  isInMaze: function(x, y) {
    return x >= 0 && x < Game.COLS && y >= 0 && y < Game.ROWS;
  },
  canReach: function(ctx, startX, startY, endX, endY) {
    var points = new Array(Game.COLS);
    var NUM_STEPS = 10;
    var counter;
    var stop = false;
    var dir;
    for (i = 0; i < Game.COLS; i++) {
      points[i] = new Array(Game.ROWS);
      for (j = 0; j < Game.ROWS; j++) {
        points[i][j] = false;
      }
    }
    points[startX][startY] = true;
    //Game.Console.add(startX + 'x' + startY + endX + 'x' + endY);

    var imageData = ctx.getImageData(0, 0, 630, 450).data;
    for (var i = 0; i < NUM_STEPS; i++) {
      for (var j = 0; j < Game.COLS; j++) {
        for (var k = 0; k < Game.ROWS; k++) {
          if (points[j][k]) {
            //Game.Console.add(j + 'x' + k);
            for (var l = 0; l < 4; l++) {
              dir = this.DIRS[l];
              counter = 1;
              stop = false;
                /*ctx.beginPath();
                ctx.strokeStyle = "green";
                ctx.arc(j * 30 + 15, k * 30 + 15, 2, 0, 2 * Math.PI);
                ctx.stroke();*/
              while (!stop) {
                currX = j + counter * dir[0];
                currY = k + counter * dir[1];
                wallX = currX * Game.DIST + 15 - 15 * dir[0];
                wallY = currY * Game.DIST + 15 - 15 * dir[1];

                /*ctx.beginPath();
                ctx.strokeStyle = "yellow";
                ctx.arc(wallX, wallY, 2, 0, 2 * Math.PI);
                ctx.stroke();*/

                if (this.isInMaze(currX, currY) && (this.getPixelColor(imageData, wallX, wallY) != "#ffffff")) {
                  if (currX == endX && currY == endY) {
                    //Game.Console.add(currX + '#' + currY + '#' +wallX + '#' + wallY + '#' + this.getPixelColor(imageData, wallX, wallY));
                    return true;
                  } else {
                    points[currX][currY] = true;
                  }
                } else {
                  stop = true;
                }
                counter++;
              }
              //EXIT;
            }

          }
        }
      }
    }

    return false;
  },
  draw: function(ctx, level) {

    var dirs = [this.RIGHT, this.DOWN];
    var dir;
    var lineCol, lineRow, lineX1, lineX2, lineY1, lineY2;
    ctx.globalAlpha = 1.0;
    ctx.strokeStyle = "#FFFFFF";
    ctx.fillStyle = "#FFFFFF";
    ctx.strokeRect(0, 0, Game.getMazeWidth(), Game.getMazeHeight());


    for (var i = 1; i < 300 + 5 * level; i++) {
      ctx.strokeStyle = "#ffffff";
      dir = dirs.random();
      lineCol = Game.getRandomInt(0, Game.COLS - 1);
      lineRow = Game.getRandomInt(0, Game.ROWS - 1);
      lineX1 = lineCol * Game.DIST;
      lineY1 = lineRow * Game.DIST;
      lineX2 = (lineCol + dir[0]) * Game.DIST;
      lineY2 = (lineRow + dir[1]) * Game.DIST;
      if ((lineCol > 0 || dir != this.DOWN) && (lineRow > 0 || dir != this.RIGHT)) {
        ctx.beginPath();
        ctx.moveTo(lineX1, lineY1);
        ctx.lineTo(lineX2, lineY2);
        ctx.stroke();
        var startPoint, endPoint;
        if (dir == this.DOWN) {
          startPoint = [lineCol - 1, lineRow];
          endPoint = [lineCol, lineRow];
        } else {
          startPoint = [lineCol, lineRow - 1];
          endPoint = [lineCol, lineRow];
        }
        if (!this.canReach(ctx, startPoint[0], startPoint[1], endPoint[0], endPoint[1])) {
          ctx.strokeStyle = "#000000";
          ctx.beginPath();
          ctx.moveTo(lineX1, lineY1);
          ctx.lineTo(lineX2, lineY2);
          ctx.stroke();
        }
      }
    }
  }

}