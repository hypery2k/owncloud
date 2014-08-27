beforeEach(function() {
  addFixture('userSettings.html');
});
afterEach(function() {
  clearMyFixtures();
});

describe('userSettings - without errors', function() {
  it('userSettings - empty dom', function() {
    clearMyFixtures();
    Roundcube.userSettingsUI();
    $("#usermail_update").click();
  });
  it('userSettings - empty dom', function() {
    Roundcube.userSettingsUI();
    $("#usermail_update").click();
  });
  it('userSettings - error handling', function() {
    Roundcube.userSettingsUI();
    $("#usermail_update").click();
  });

});