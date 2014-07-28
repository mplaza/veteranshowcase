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

app.factory('UserView', ['$resource', function($resource) {
  return $resource('/savedposts/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);

app.controller('MainCtrl', ['$scope', 'AdminPost', 'UserPost', 'FilteredWord', 'UserView', function($scope, AdminPost, UserPost, FilteredWord, UserView) {
    // $scope.adminPosts = [];
    // $scope.userPosts = [];
    $(document).foundation();
    $scope.Math = window.Math;
    $scope.randomPictures = [
      "http://i89.photobucket.com/albums/k223/slvadrgn/post14_zpsccaf1915.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/post13_zpsfb1e824f.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/post12_zpsae30fc46.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/post15_zpscfb0c455.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/Got%20Your%206%20Hackathon%20Images/post3_zps01cf609e.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/Got%20Your%206%20Hackathon%20Images/post1_zpsd671a814.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/Got%20Your%206%20Hackathon%20Images/post2_zps6bc26e1f.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/Got%20Your%206%20Hackathon%20Images/post6_zpsbacb6338.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/Got%20Your%206%20Hackathon%20Images/post8_zps3ea320bb.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/Got%20Your%206%20Hackathon%20Images/post5_zps55e73726.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/Got%20Your%206%20Hackathon%20Images/post10_zps1be0ae09.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/Got%20Your%206%20Hackathon%20Images/post7_zpsa3c366f7.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/Got%20Your%206%20Hackathon%20Images/post9_zps99abe1b8.png",
      "http://i89.photobucket.com/albums/k223/slvadrgn/Got%20Your%206%20Hackathon%20Images/post4_zpscf011073.png"
    ]

    FilteredWord.query(function(words) {
      $scope.filteredwords = words;
    });

    AdminPost.query(function(posts) {
      $scope.adminPosts = posts;
    });

    UserView.query(function(posts){
      $scope.userViews = posts;
    })

    $scope.newUserPost = new UserPost();

    UserPost.query(function(posts) {
      $scope.userPosts = posts;
      console.log($scope.userPosts);
    });

    $scope.showSavedPost = function(){
      if($scope.savedfilter == true){
        $scope.savedfilter = false
      }
      else {
        $scope.savedfilter = true
      }
    }



    $scope.selectPost = function(post) {
      $scope.selectedPost = post;
      console.log($scope.selectedPost);
    }

    $scope.approvePost = function() {
      $scope.selectedPost.approved = true;
      $scope.newUserPost = $scope.selectedPost;
      $scope.newUserPost.$save(function(post) {
        position = $scope.adminPosts.indexOf($scope.selectedPost);
        $scope.adminPosts.splice(position, 1);
        $scope.newUserPost = new UserPost();
      });
    }

    $scope.savePost = function() {
      $scope.selectedPost.saved = true;
      $scope.newUserPost = $scope.selectedPost;
      $scope.newUserPost.$save(function(post) {
        position = $scope.adminPosts.indexOf($scope.selectedPost);
        $scope.adminPosts.splice(position, 1);
        $scope.newUserPost = new UserPost();
      });
    }

    $scope.updatePost = function() {
      $scope.selectedPost.$update(function() { 
      }, function(errors) {
        $scope.errors = errors.data;
      });
    }

    $scope.featurePost = function() {
      $scope.selectedPost.approved = true;
      $scope.selectedPost.favorite = true;
      $scope.newUserPost = $scope.selectedPost;
      $scope.newUserPost.$save(function(post) {
        position = $scope.adminPosts.indexOf($scope.selectedPost);
        $scope.adminPosts.splice(position, 1);
        $scope.newUserPost = new UserPost();
      });
    }


    $scope.featureOTSPost = function(post) {
      $scope.mouseoverPost = post;
      $scope.mouseoverPost.saved = false;
      $scope.mouseoverPost.approved = true;
      $scope.mouseoverPost.favorite = true;
      $scope.mouseoverPost.$update(function() { 
      }, function(errors) {
        $scope.errors = errors.data;
      });
    }

    $scope.postOTSPost = function(post) {
      $scope.mouseoverPost = post;
      $scope.mouseoverPost.saved = false;
      $scope.mouseoverPost.approved = true;
      $scope.mouseoverPost.$update(function() { 
      }, function(errors) {
        $scope.errors = errors.data;
      });
    }

    $scope.updatePost = function(selectedPost) {
      $scope.selectedPost.$update(function() { 
      }, function(errors) {
        $scope.errors = errors.data;
      });
    }

    $scope.deletePost = function (post) {
      $scope.selectedPost = post
      $scope.selectedPost.$delete(function() {
        position = $scope.userPosts.indexOf($scope.selectedPost);
        $scope.userPosts.splice(position, 1);
      }, function(errors) {
        $scope.errors = errors.data;
      });
    }

    $scope.userviewdeletePost = function (post) {
      $scope.selectedPost = post
      $scope.selectedPost.$delete(function() {
        position = $scope.userPosts.indexOf($scope.selectedPost);
        $scope.userPosts.splice(position, 1);
      }, function(errors) {
        $scope.errors = errors.data;
      });
    }

    $scope.added = false;
}])

app.filter('myFilter', function() {
  console.log('filtering');
   return function(items, filtword, sfilter) {
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

