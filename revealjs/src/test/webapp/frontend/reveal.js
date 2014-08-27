beforeEach(function() {
  addFixture('player.html');
});
afterEach(function() {
  clearMyFixtures();
});

describe('revealjs', function() {
  it("init", function() {
    Reveal.initialize();
  });
});