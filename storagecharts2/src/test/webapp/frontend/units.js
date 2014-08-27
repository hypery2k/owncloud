beforeEach(function() {
  addFixture('storagecharts.html');
});
afterEach(function() {
  clearMyFixtures();
});

describe('view charts', function() {
  it('unit selector helper - hu_size', function() {
    var select = document.createElement('select');
    select.id = 'chunits_hus';
    var option = document.createElement('option');
    option.id = 'uc_val';
    option.text = '3';
    select.appendChild(option);
    document.body.appendChild(select);
    getHistoUsUnitsSelect(2048);
  });
});