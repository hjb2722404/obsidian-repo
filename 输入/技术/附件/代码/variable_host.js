f=function(){return true;};
g=function(){return false;};
~function() {
    if(g() && [] == ![]) {
        f = function() { return false;};
        function g() { return true; };
    }
}();
console.log(f());
console.log(g());