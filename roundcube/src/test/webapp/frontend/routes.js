describe('routes', function() {
  it("refresh setting", function() {
    Roundcube.routes();
  });
  it("refresh - OC 6", function() {
    OC.currentUser = "admin";
    Roundcube.refreshInterval = 1;
    OC.Router = "";
    OC.Router.registerLoadedCallback = function(func) {
    };
    var routesSet = Roundcube.routes();
    expect(routesSet).toBe(true);

  });
  it("refresh - OC 7", function() {
    OC.currentUser = "admin";
    Roundcube.refreshInterval = 1;
    OC.Router = false;
    var routesSet = Roundcube.routes();
    expect(routesSet).toBe(true);
  });
  it("clear", function() {
    OC.currentUser = false;
    Roundcube.refreshInterval = 1;
    OC.Router = false;
    var routesSet = Roundcube.routes();
    expect(routesSet).toBe(false);
  });
});