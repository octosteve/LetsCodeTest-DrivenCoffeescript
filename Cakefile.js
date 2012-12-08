(function() {

  task("default", function() {
    return console.log("default");
  });

  task("example", "Example!!!", function() {
    invoke('dependency');
    return console.log("Yaaaaar");
  });

  task("dependency", function() {
    return console.log("I'm a dependency!");
  });

}).call(this);
