function Ctrl($scope) {
	
  $scope.list = [];
  $scope.text = 'hello';
  $scope.submit = function() {
	if (this.text) {
      this.list.push(this.text);
      this.text = '';
    }
  };
  $scope.click = function() {
	  alert(this.from);
    if (this.text) {
      this.list.push(this.text);
      $http.get('/ecp-gmap/EcpGMapInegrationServlet?from={"lat":13.07909,"lng":80.24074},{"lat":13.086310000000001,"lng":80.22337}').success(function(data) {
    	  $scope.phones = data;
      });
      this.text = '';
    }
  };
}