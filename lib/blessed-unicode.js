module.exports = function(blessed){
  var charSize = function(c){
    return c.charCodeAt() < 1 << 7 ? 1 : 2;
  };
  var _draw = blessed.Screen.prototype.draw;
  blessed.Screen.prototype.draw = function(start, end){
    var lines = this.lines;
    var that = this;
    lines.forEach(function(line){
      var cw = 0;
      line.forEach(function(cell){
        cw += charSize(cell[1]);
      });
      if(that.width < cw){
        var count = cw - that.width;
        for(var l = line.length - 1;count;l--){
          line[l][1] === " " && line.splice(l, 1), count--;
        }
      }
    });

    _draw.call(this, start, end);
  };
};
