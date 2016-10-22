var employees = new Vue({
  el: '#turnovers',
  data: {
    turnovers: []
  },
  mounted: function() {
    var that;
    that = this;
    $.ajax({
      url: '/top/index.json',
      success: function(res) {
        that.turnovers = res;
      }
    });
  }
});
