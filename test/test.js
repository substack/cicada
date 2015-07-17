// simple server setup
var http = require('http');
var cicada = require('../');

var output = [];

var ci = cicada('/tmp/beep');
ci.on('commit', function (commit) {
    commit.run('test').on('exit', function (code) {
        var status = code === 0 ? 'PASSED' : 'FAILED';
        console.log(commit.hash + ' ' + status);
        output.push(status);
    });
});

var server = http.createServer(ci.handle);
server.listen(5255);


// testing
var assert = require("assert");
var spawn = require('child_process').spawn;
describe('Push', function() {
  it('should run test and return PASSED', function() {
    var cmd = spawn(__dirname + '/push.sh', [
        'http://localhost:' + server.address().port + '/beep.git'
    ]);
    cmd.on('exit', function() {
      assert.equal('PASSED', output[-1]);
    });
  });
});
