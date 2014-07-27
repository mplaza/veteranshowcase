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
    });

    AdminPost.query(function(posts) {
      $scope.adminPosts = posts;
    });

    $scope.newUserPost = new UserPost();

    UserPost.query(function(posts) {
      $scope.userPosts = posts;
      console.log($scope.userPosts);
    });

    $scope.selectPost = function(post) {
      $scope.selectedPost = post;
      console.log($scope.selectedPost);
    }

    $scope.approvePost = function() {
      $scope.selectedPost.approved = true;
      $scope.newUserPost = $scope.selectedPost;
      $scope.newUserPost.$save(function(post) {
        $scope.newUserPost = new UserPost();
      });
    }

    $scope.savePost = function() {
      $scope.selectedPost.saved = true;
      $scope.newUserPost = $scope.selectedPost;
      $scope.newUserPost.$save(function(post) {
        $scope.newUserPost = new UserPost();
      });
    }

    $scope.featurePost = function() {
      $scope.selectedPost.approved = true;
      $scope.selectedPost.favorite = true;
      $scope.newUserPost = $scope.selectedPost;
      $scope.newUserPost.$save(function(post) {
        $scope.newUserPost = new UserPost();
      });
    }

    $scope.deletePost = function() {
      // function here
    }
}])

app.filter('myFilter', function() {
  console.log('filtering');
   return function(items, filtword ) {
    var filtered = [];
    var matchcounter = 0;
    angular.forEach(items, function(item) {
      matchcounter = 0;
      var titlearray = item.title.split(" "); 
      for( var i = 0; i< titlearray.length; i++){
        for( var j = 0; j< filtword.length; j++){
          if(titlearray[i] == filtword[j].negativesearch){
            matchcounter +=1;
            break;
          };
        }    
      }
      if(matchcounter == 0){
        filtered.push(item);
      }

    });
    return filtered;

  };
});

