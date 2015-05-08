(function () {
  'use strict';

  var gulp = require('gulp'),
    plugins = require('gulp-load-plugins')(),
    help = plugins.help(gulp),
    rimraf = require('rimraf'),
    path = require('path'),
    source = require('vinyl-source-stream'),
    paths = {
      out: './out/',
      clean: ['./out/', './coverage'],
      coffee: ['./src/*.coffee', './src/**/*.coffee'],
      test: ['./out/test/*.spec.js'],
      js: ['./out/*.js', './out/**/*.js']
    };

  // Utility tasks
  gulp.task('clean', 'Removes prior build output', function () {
    // TODO: Make this async
    var fn = function (path) { rimraf.sync(path); };
    paths.clean.forEach(fn);
  });

  gulp.task('build', 'Builds the module', ['clean', 'coffee', 'bump-patch']);

  gulp.task('bump-major', 'Bumps the major build number', function () {
    return gulp.src(['./bower.json', './component.json', './package.json'])
      .pipe(plugins.bump({type: 'major'}))
      .pipe(gulp.dest('./'));
  });

  gulp.task('bump-minor', 'Bumps the minor build number', function () {
    return gulp.src(['./bower.json', './component.json', './package.json'])
      .pipe(plugins.bump({type: 'minor'}))
      .pipe(gulp.dest('./'));
  });

  gulp.task('bump-patch', 'Bumps the patch build number', function () {
    return gulp.src(['./bower.json', './component.json', './package.json'])
      .pipe(plugins.bump({type: 'patch'}))
      .pipe(gulp.dest('./'));
  });

  gulp.task('bump-prerelease', 'Bumps the prerelease build number', function () {
    return gulp.src(['./bower.json', './component.json', './package.json'])
      .pipe(plugins.bump({type: 'prerelease'}))
      .pipe(gulp.dest('./'));
  });

  gulp.task('default', 'Builds the module', ['build']);

  // Conversion tasks
  gulp.task('coffee', 'Transforms Coffeescript to JavaScript', function () {
    return gulp.src(paths.coffee)
      .pipe(plugins.coffee())
      .pipe(plugins.uglify())
      .pipe(gulp.dest(paths.out))
      .on('error', plugins.util.log.bind(plugins.util, 'CoffeeScript Error'));
  });

  // Test tasks
  gulp.task('test', 'Runs all Jasmine tests', ['build'], function () {
    return gulp.src(paths.test)
      .pipe(plugins.jasmine({ verbose: true, includeStackTrace: false }))
      .on('error', plugins.util.log.bind(plugins.util, 'Jasmine Error'));
  });

  gulp.task('coverage', 'Creates a coverage report for Jasmine tests', ['test'], function () {
    return gulp.src(paths.js)
      .pipe(plugins.istanbul())
      .on('error', plugins.util.log.bind(plugins.util, 'Istanbul Error'))
      .on('finish', function () {
        gulp.src(paths.test)
          .pipe(plugins.jasmine())
          .pipe(plugins.istanbul.writeReports());
      });
  });
})();
