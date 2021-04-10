<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<title>Ifs Cars Service</title>

	<!-- https://getbootstrap.com/docs/4.0/getting-started/introduction/ -->
	<link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.0/normalize.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/skeleton/2.0.4/skeleton.min.css"/>

	<style>
		body {
			background-image: url("https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80");
	  		background-attachment: fixed;
	  		background-position: 0px 0px;
	  		background-repeat: no-repeat; 
	  		background-size: cover; 
	  		font-family: "Ubuntu", sans-serif;
	  		padding-bottom: 40px;
		}
	
		.navtag-big { 
			font-weight: bold;
			font-size: 32px;
  			color: #171C8F;
		}
		
		.navtag-medium { 
			font-weight: bold;
			font-size: 24px;
		}
		
		.navtag-medium.navtag-current{
			color: rgb(51,51,51);
		}
		
		#main {
			margin: 50px auto auto auto;
		}
		
		.home {
			text-align: center;
		}
		
		.container {
		  padding: 40px;
		  border: 5px solid;
		  background-color: #f2f2f2;
		}
		
		.container-title{
		 	font-weight: bold;
			font-size: 40px;
		}
		
		.container-body{
			font-size: 24px;
		}
		
		.gif {
  			display: block;
  			margin: auto auto auto auto;
  			width: 50%;
		}
	
	</style>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.10.2/p5.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.10.2/addons/p5.sound.min.js"></script>

</head>
<body>
        
	<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #f2f2f2;">
      <a class="navbar-brand nav-link disabled" href="#">
        <img
          src="https://www.univ-gustave-eiffel.fr/fileadmin/templates/UGE/assets/img/logo/logoRS-UGE.png"
          width="50"
          height="50"
          class="d-inline-block align-top"
          alt=""
        />
       </a>
      <div class="navtag-big">IFS CARS SERVICE&nbsp;&nbsp;</div>
      <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
        <div class="navbar-nav">
        <a class="nav-item nav-link disabled" href="#">
        	<span class="navtag-current navtag-medium">Welcome</span>
        </a>
        <a class="nav-item nav-link disabled" href="#">
        	<span class="navtag-medium">Shop</span>
        </a>
        <a class="nav-item nav-link disabled" href="#">
        	<span class="navtag-medium">Payment</span>
        </a>
        <a class="nav-item nav-link disabled" href="#">
        	<span class="navtag-medium">Done</span>
        </a>
        </div>

        <div class="navbar-text ml-auto">
          <span class="navtag-medium">@AT, NG, RD</span>
        </div>
      </div>
    </nav>
	
	<div id="main" class="home">
		<div class='container'>
			<div class='row'>
				<div class='twelve columns'>
					<div class="container-title">Click to enter the marketplace</div>
        				<p class="container-body">
        				Ifs Cars Service is a marketplace for used vehicles in mint condition at attractive rates. 
        				Browse reviews for the best deal and pay in any currency!<br>
        				- Eiffel Corp
        				</p>
					<img id="welcome-gif"
          				class="gif"
          				src="https://media.giphy.com/media/xT0BKDEhjH4ug1NwTC/giphy.gif"
          				alt=""
					/>
				</div>
			</div>
		</div>
	</div>
	
	    <script>
	    
	    function setup(){
	    }
	    
	    function draw(){
			noLoop();
	    }
	    
	    function mousePressed(){
	    	gotoShop();
	    }
	    
	    function gotoShop() {
	    	post("<%= request.getContextPath() %>/index", {} );
	    }
	  
	  //http post implementation for dynamic jsp
	  //creates a hidden form
	  //takes a json as data params
	  //parse and sends in text format
	  function post(path, params) {

	      let form = document.createElement("form");

	      form._submit_function_ = form.submit;

	      form.setAttribute("method", "post");
	      form.setAttribute("action", path);

	      for(let key in params) {
	          let hiddenField = document.createElement("input");
	          hiddenField.setAttribute("type", "hidden");
	          hiddenField.setAttribute("name", key);
	          hiddenField.setAttribute("value", params[key]);

	          form.appendChild(hiddenField);
	      }
	      document.body.appendChild(form);
	      form._submit_function_();
	  }
	    
	    </script>
	    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
