(function(){var t,e,r,n,i,o,u=function(t,e){function r(){this.constructor=t}for(var n in e)p.call(e,n)&&(t[n]=e[n]);return r.prototype=e.prototype,t.prototype=new r,t.__super__=e.prototype,t},p={}.hasOwnProperty,s=[].indexOf||function(t){for(var e=0,r=this.length;r>e;e++)if(e in this&&this[e]===t)return e;return-1};e=require("lodash"),i=require("detect-node"),o=require("portable-uuid"),r=require("events"),n=["extended","included"],t=function(t){function r(t){r.__super__.constructor.call(this),this.uuid=o(),this.node=i,this.options=e.extend({},t)}return u(r,t),r.prototype.extend=function(t){var e,r,i;for(e in t)i=t[e],s.call(n,e)<0&&(this[e]=i);return null!=(r=t.extended)&&r.apply(this),this},r.prototype.include=function(t){var e,r,i;for(e in t)i=t[e],s.call(n,e)<0&&(this.prototype[e]=i);return null!=(r=t.included)&&r.apply(this),this},r}(r.EventEmitter),module.exports=t}).call(this);
