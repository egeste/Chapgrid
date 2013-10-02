require([
  'jquery'
, 'underscore'
], function($, _) {
  console.log('Adding jscoverage reporter.');
  var jasmineEnv = jasmine.getEnv();
  jasmineEnv.addReporter({reportRunnerResults: coverageReport});
  jasmineEnv.execute();
  function coverageReport(){
    var $container = $('.coverage');
    if ($container.length === 0) {
      $container = $('<div class="coverage"></div>');
    } else {
      $container.empty();
    }
    _.each(
      window._$jscoverage,
      function(val, key){
        var cov = _.reduce(val, function(m, n, i){
          m.covered += (n > 0) ? 1 : 0;
          m.total += 1;
          m.percentage = (m.covered / m.total * 100).toFixed(2);
          return m;
        }, {
          covered: 0,
          total: 0,
          percentage: 0,
        });
        console.log([key, [cov.covered, cov.total].join('/'), cov.percentage + '%'].join(' :: '));
        var $file = $('<div class="file-coverage"><span class="file-name">' + key + '</span>' + [cov.covered, cov.total].join('/') + ' (' + cov.percentage + ') ' + '<ol class="source"></ol></div>');
        _.each(
          val.source,
          function(code, idx){
            var $line = $('<li><pre>' + code + '</pre></li>'),
              ex = val[idx + 1];
            if (ex === undefined) {
              $line.addClass('ignored');
            } else if (ex > 0) {
              $line.addClass('covered');
            } else {
              $line.addClass('uncovered');
            }
            $file.find('.source').append($line)
          }, this
        );
        $file.find('.source').hide();
        $file.find('.file-name').click(function(){
          var clickedSource = $file.find('.source');
          $container.find('.source').each(function(idx, elem){
            if (elem === clickedSource.get(0)) {
              $(elem).toggle(200);
            } else {
              $(elem).hide(200);
            }
          });
        });
        $container.append($file);
      }, _$jscoverage
    );
    $('body').append($container);
  }
});