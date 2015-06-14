module.exports = function(grunt) {

  // Add the grunt-mocha-test tasks.
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.initConfig({
    // Configure a mochaTest task
    mochaTest: {
      test: {
        options: {
          reporter: 'spec',
          captureFile: 'results.txt', // Optionally capture the reporter output to a file
          quiet: false, // Optionally suppress output to standard out (defaults to false)
          clearRequireCache: true // Optionally clear the require cache before running tests (defaults to false)
        },
        src: ['test/*.coffee']
      }
    },

    watch: {
      js: {
        options: {
          spawn: false
        },
        files: '**/*.coffee',
        tasks: ['default']
      }
    }
  });

  grunt.registerTask('default', 'mochaTest');

};