var app = angular.module('MainApp', ['ngResource']).config(
    ['$httpProvider', function($httpProvider) {
    var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
    var defaults = $httpProvider.defaults.headers;

    defaults.common["X-CSRF-TOKEN"] = authToken;
    defaults.patch = defaults.patch || {};
    defaults.patch['Content-Type'] = 'application/json';
    defaults.common['Accept'] = 'application/json';
}]);

app.factory('AdminPost', ['$resource', function($resource) {
  return $resource('/adminposts/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

app.factory('UserPost', ['$resource', function($resource) {
  return $resource('/userposts/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

app.factory('FilteredWord', ['$resource', function($resource) {
  return $resource('/filteredwords/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

app.controller('MainCtrl', ['$scope', 'AdminPost', 'UserPost', 'FilteredWord', function($scope, AdminPost, UserPost, FilteredWord) {
    // $scope.adminPosts = [];
    // $scope.userPosts = [];

    FilteredWord.query(function(words) {
      $scope.filteredwords = words;
      console.log($scope.filteredwords);
    });

    AdminPost.query(function(posts) {
      $scope.adminPosts = posts;
      console.log($scope.adminPosts);
    });

    UserPost.query(function(posts) {
      $scope.userPosts = posts;
    });

}])