(function(){var t,r,e,o=function(t,r){function e(){this.constructor=t}for(var o in r)n.call(r,o)&&(t[o]=r[o]);return e.prototype=r.prototype,t.prototype=new e,t.__super__=r.prototype,t},n={}.hasOwnProperty;t=require("./core.object"),e=require("property.js"),r=function(t){function r(t,o){null==t&&(t={}),null==o&&(o={}),r.__super__.constructor.call(this,o),e.mixin(this),Object.keys(t).forEach(function(r){return this.addProperty(r,t[r]).observe(function(t,e){return t!==e?this.emit("change",this,{key:r,oldValue:t,newValue:e}):void 0})},this)}return o(r,t),r}(t),module.exports=r}).call(this);
