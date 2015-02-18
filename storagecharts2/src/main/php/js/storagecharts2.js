// declare namespace
var StorageCharts2 = StorageCharts2 || {};

// TODO include correct callback
StorageCharts2.getLinesUsseUnitsSelect = function(s) {

  $('#clines_usse h3').append(
      '<span id="selunits"><span id="selloader"></span><select id="chunits"><option value="1"'
	  + (s == 1 ? ' selected' : '') + '>' + t('storage_charts', 'Kilobytes (KB)') + '</option><option value="2"'
	  + (s == 2 ? ' selected' : '') + '>' + t('storage_charts', 'Megabytes (MB)') + '</option><option value="3"'
	  + (s == 3 ? ' selected' : '') + '>' + t('storage_charts', 'Gigabytes (GB)') + '</option><option value="4"'
	  + (s == 4 ? ' selected' : '') + '>' + t('storage_charts', 'Terabytes (TB)') + '</option></select></span>');
  $('#chunits').chosen();
  $('#chunits').change(function() {
    $('#selloader').html('<img src="' + OC.imagePath('storage_charts', 'loader.gif') + '" />');
    $.ajax({
      type : 'POST',
      url : OC.linkTo('storage_charts', 'ajax/data.php'),
      dataType : 'json',
      data : {
	s : $('#chunits').val(),
	k : 'hu_size'
      },
      async : true,
      success : function(s) {
	eval(s.r);
	$('#selloader img').remove();
      }
    });
  });
}

// TODO include correct callback
StorageCharts2.getHistoUsUnitsSelect = function(s) {

  $('#chisto_us h3').append(
      '<span id="selunits_hus"><span id="selloader_hus"></span><select id="chunits_hus"><option value="1"'
	  + (s == 1 ? ' selected' : '') + '>' + t('storage_charts', 'Kilobytes (KB)') + '</option><option value="2"'
	  + (s == 2 ? ' selected' : '') + '>' + t('storage_charts', 'Megabytes (MB)') + '</option><option value="3"'
	  + (s == 3 ? ' selected' : '') + '>' + t('storage_charts', 'Gigabytes (GB)') + '</option><option value="4"'
	  + (s == 4 ? ' selected' : '') + '>' + t('storage_charts', 'Terabytes (TB)') + '</option></select></span>');
  $('#chunits_hus').chosen();
  $('#chunits_hus').change(function() {
    $('#selloader_hus').html('<img src="' + OC.imagePath('storage_charts', 'loader.gif') + '" />');
    $.ajax({
      type : 'POST',
      url : OC.linkTo('storage_charts', 'ajax/data.php'),
      dataType : 'json',
      data : {
	s : $('#chunits_hus').val(),
	k : 'hu_size_hus'
      },
      async : true,
      success : function(s) {
	eval(s.r);
	$('#selloader_hus img').remove();
      }
    });
  });
}

/**
 * Fills height and width of window. (more precise than height: 100%; or width: 100%;)
 */
StorageCharts2.render = function(renderChart) {
  if (renderChart) {
    $(document).ready(function() {
      eval(renderChart);
    })
  }
}

// init sorting
$(document).ready(function() {

  if ($('#clines_usse').size() > 0) {
    // TODO unit selection
    // StorageCharts2.getLinesUsseUnitsSelect($('#storagecharts2').data('sc-size'));
    $.post(OC.filePath('storagecharts2', 'ajax', 'data.php'), {
      's' : $('#storagecharts2').data('sc-size-hus'),
      'k' : 'hu_size'
    }, function(data) {
      if (data.r) {
	eval(data.r);
      }
    });
  }
  if ($('#chisto_us').size() > 0) {
    // TODO unit selection
    // StorageCharts2.getHistoUsUnitsSelect($('#storagecharts2').data('sc-size-hus'));
    $.post(OC.filePath('storagecharts2', 'ajax', 'data.php'), {
      's' : $('#storagecharts2').data('sc-size-hus'),
      'k' : 'hu_size_hus'
    }, function(data) {
      if (data.r) {
	eval(data.r);
      }
    });
  }
  if ($('#cpie_rfsus').size() > 0) {
    $.post(OC.filePath('storagecharts2', 'ajax', 'data.php'), {
      'k' : 'hu_ratio'
    }, function(data) {
      if (data.r) {
	eval(data.r);
      }
    });
  }
  $('#stc_sortable').sortable({
    axis : 'y',
    handle : 'h3',
    placeholder : 'ui-state-highlight',
    update : function(e, u) {
      $.ajax({
	type : 'POST',
	url : OC.linkTo('storagecharts2', 'ajax/userSettings.php'),
	dataType : 'json',
	data : {
	  o : 'set',
	  k : 'sc_sort',
	  i : $('#stc_sortable').sortable('toArray')
	},
	async : true
      });
    }
  });
  $('#stc_sortable').disableSelection();
});
