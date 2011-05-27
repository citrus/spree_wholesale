$(document).ready(function() {
  
  $('.country-select').change(function(evt) {
    var parent = $(this).parents('fieldset').find('p.state-select');
    var span = parent.find('span.field');
    var prefix = parent.attr('id').match(/bill/i) ? 'bill' : 'ship';
    var current = span.find('.required');
    
    console.log(current);
    
    $.get('/admin/wholesaler/states', { country_id: this.options[this.selectedIndex].value }, function(res) {
      res = res.replace(/"_address/g, '"' + prefix + '_address');
      span.html(res);
    });
    
  });
    
  $('#wholesaler_use_billing').change(function(evt) {
    $('#fields_ship_address').toggle(!$(this).is(':checked'));
  }).change();
  
});
