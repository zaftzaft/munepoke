module.exports = function(blessed){
  var charSize = function(c){
    return c.charCodeAt() < 1 << 7 ? 1 : 2;
  };
  var strWidth = function(s){
    var w = 0;
    for(var i = 0, l = s.length;i < l;i++){
      w += charSize(s[i]);
    }
    return w;
  };
  var byteSlice = function(s, b){
    var m = 0, i = 0, c = "", t = "";
    while(1){
      c = s[i++];
      if(!c){ break; }
      m += charSize(c);
      if(m > b){ break; }
      t += c;
    }
    return t;
  };
  var byteBreak = function(s, b){
    var m = 0, t = "", c, w;
    for(var i = 0, l = s.length;i < l;i++){
      w = charSize(c = s[i]);
      (m + w > b) ? (m = w, t += "\n") : m += w;
      t += c;
    }
    return t;
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


  var _parseContent = blessed.Element.prototype.parseContent;
  blessed.Element.prototype.parseContent = function(noTags){
    var tmp = this.content;
    if(this.parent && strWidth(this.content) > this._getWidth(false)){
      this.content = byteBreak(this.content, this.width);
    }
    _parseContent.call(this, noTags);
    this.content = tmp;
  };

};
