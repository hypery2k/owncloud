beforeEach(function() {
  addFixture('storagecharts.html');
});
afterEach(function() {
  clearMyFixtures();
});

describe('init', function() {
  it(' should work without any element', function() {
    StorageCharts2.init();
  });
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
    StorageCharts2.getHistoUsUnitsSelect(2048);
  });
  it('unit selector helper - hus_size', function() {
    var select = document.createElement('select');
    select.id = 'chunits';
    var option = document.createElement('option');
    option.id = 'uc_val';
    option.text = '3';
    select.appendChild(option);
    document.body.appendChild(select);
    StorageCharts2.getLinesUsseUnitsSelect(2048);
  });
});