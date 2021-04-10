<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="ifscarsservice.Vehicle" %>

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
		
		.nav-label{
			font-weight: bold;
			font-size: 32px;
  			color: #171C8F;
		}
		
		#main {
			margin: 50px auto auto auto;
		}
		
		.home {
			text-align: center;
		}
		
		.container {
		  padding: 40px;
		  border-bottom: 1px solid;
		  background-color: #f2f2f2;
		  text-align: left;
		}
		
		.container.nav-container{
			padding: 0px;
		}
		
		.container-title{
		 	font-weight: bold;
			font-size: 40px;
		}
		
		.container-body{
			font-size: 24px;
		}
		
		.container-price{
			color: #171C8F;
			font-weight: bold;
			font-size: 40px;
			text-align: right;
		}
		
		.container-list{
			padding-left:40px; 
			font-size: 18px;
		}
		
		.container-available{
			padding-top: 20px;
		}
		
		.container-unavailable{
			color: #F9665E;
			font-weight: bold;
			font-size: 32px;
		}
		
		.img {
			width: 100%;
			display: block;
			margin: auto auto auto auto;
		}
	
	</style>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.10.2/p5.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.10.2/addons/p5.sound.min.js"></script>

</head>
<body>
		<% Vehicle vehiclesObj[] = (Vehicle[])request.getAttribute("vehicles"); %>
        
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
        	<span class="navtag-medium">Welcome</span>
        </a>
        <a class="nav-item nav-link disabled" href="#">
        	<span class="navtag-current navtag-medium">Shop</span>
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
		<div class="nav-container container">
			<nav>
		        <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
		          <a
		            class="nav-item nav-link text-secondary active"
		            id="nav-shop-tab"
		            data-toggle="tab"
		            href="#nav-shop"
		            role="tab"
		            aria-controls="nav-shop"
		            aria-selected="true"
		            ><span class="nav-label">SHOP</span></a
		          >
		          <a
		            class="nav-item nav-link text-secondary"
		            id="nav-cart-tab"
		            data-toggle="tab"
		            href="#nav-cart"
		            role="tab"
		            aria-controls="nav-cart"
		            aria-selected="false"
		            ><span class="nav-label">MY CART</span></a
		          >
		        </div>
		    </nav>
	    </div>
      
      	<div class="tab-content" id="nav-tabContent">
	        <div
	          class="tab-pane fade show active"
	          id="nav-shop"
	          role="tabpanel"
	          aria-labelledby="nav-shop-tab"
	        >
	        </div>
	        <div
	          class="tab-pane fade"
	          id="nav-cart"
	          role="tabpanel"
	          aria-labelledby="nav-cart-tab"
	        >
			</div>
		</div>
	</div>
	
	    <script>
	    
	    let vehicles = [];
	    let shop = {};
	    let cart = {};
	    let cartSummary;
	    
	    function setup(){
	    	
	    	<%for(int i = 0; i < vehiclesObj.length; i++){%>
		    	vehicles[<%=i%>] = {
			    	"id": "<%=vehiclesObj[i].getId()%>",
			    	"manufacturer": "<%=vehiclesObj[i].getMake()%>",
			    	"model": "<%=vehiclesObj[i].getModel()%>",
			    	"year": "<%=vehiclesObj[i].getYear()%>",
			    	"seatingcapacity": "<%=vehiclesObj[i].getSeatingCapacity()%>",
			    	"fueltype": "<%=vehiclesObj[i].getFuelType()%>",
			    	"transmission": "<%=vehiclesObj[i].getTransmission()%>",
			    	"price": "<%=vehiclesObj[i].getPrice()%>",
			    	"available": "<%=vehiclesObj[i].isAvailableForSale()%>",
			    	"lastmessage": "<%=vehiclesObj[i].getLastMessage()%>",
			    	"averagenote": "<%=vehiclesObj[i].getAverageNote()%>",
			    	"imgurl": "<%=vehiclesObj[i].getImgUrl()%>"
		    	};
	    	<%}%>
	    	
	    	////TODO remove test values
	    	////////////////////////////////////////////////////
	    	/*vehicles[1].available = true;
	    	vehicles[4].available = true;
	    	
	    	vehicles[1].averagenote = 4.73;
	    	vehicles[4].averagenote = 3;	    	
	    	
	    	vehicles[1].lastmessage = "this car was so great";
	    	vehicles[4].lastmessage = "good drive but a little bit bumpy";
	    	*/
	    	////////////////////////////////////////////////////
	    	
	    	vehicles.sort(compareAvailable);
	    	function compareAvailable(a, b) {
	    	    return (b.available === 'true' ? 1 : 0) - (a.available === 'true' ? 1 : 0);
	    	}
	    	
	    	
	    	cartSummary = createDiv()
	    		.parent(document.getElementById('nav-cart'))
	    		.hide();

	    	for(let i in vehicles){
	    		shop[vehicles[i].id] = {
	    				"vindex": i,
	    				"container": createContainer(vehicles[i], true)
	    					.parent(document.getElementById('nav-shop'))
	    		};
	    	}
	    }
	    
	    function draw(){
			noLoop();
	    }
	    
	    function createContainer(v, shop){
	    	return createDiv(
	    			"<div class='container'>" +
						"<div class='row'>" +
							"<div class='six columns'>" +
								"<div class='container-title'>" +
									v.manufacturer + " " + v.model + " " + v.year + 
								"</div>" +
							"</div>" + 	
							"<div class='six columns'>" +
								"<div class='container-price'>" +
									nf(v.price, "", 2) + " EUR" + "<br>" +
								"</div>" +
						"</div>" + 
    					"<div class='row'>" +
    						"<div class='five columns'>" +
    						 	"<img " + 
    			                	"class='img' " + 
    			                	"src='" + v.imgurl + "' " + 
    			                	"alt=''" +
    			              	"/>" +
    						"</div>" + 
    						"<div class='seven columns'>" +
    							"<div class='container-body'>" +
									"<strong>" + "Seating capacity" + "</strong>" + ": " + v.seatingcapacity + "<br>" +	
									"<strong>" + "Fuel type" + "</strong>" + ": " + v.fueltype + "<br>" +	
									"<strong>" + "Transmission" + "</strong>" + ": " + v.transmission + "<br>" +
									"<strong>" + "Average note" + "</strong>" + ": " + nf(v.averagenote, "", 1) + "<br>" +
									"<strong>" + "Last message" + "</strong>" + ": " + v.lastmessage + "<br>" +		
    							"</div>" +
    						"</div>" + 
    					"</div>" +
						"<div class='row'>" +
							"<div class='twelve columns'>" +
							(v.available === 'true' ?
									"<div class='container-available'>" +
										(int(shop) ? 
							          			"<button onclick='addToCart(" + v.id + ")' class='btn btn-outline-success btn-lg'>" + 
														"Add to cart" + 
					          					"</button>"
					          					:
								          		"<button onclick='removeFromCart(" + v.id + ")' class='btn btn-outline-danger btn-lg'>" + 
														"Remove from cart" + 
				          						"</button>"					          					
										) +
									"</div>"
									:
									"<div class='container-unavailable'>" +
										"Available soon..." +
									"</div>"										
							) + 
							"</div>" + 	
						"</div>" + 
    				"</div>"
    		);
	    }
	    
	    function addToCart(id){
	    	shop[id].container.hide();
	    	cart[id] = {
	    		"vindex": shop[id].vindex, 
				"container": createContainer(vehicles[shop[id].vindex])
					.parent(document.getElementById('nav-cart'))
	    	};
	    	updateCartSummary();	    	
	    }
	    
	    function removeFromCart(id){
	    	shop[id].container.show();
	    	cart[id].container.remove();
	    	delete cart[id];
	    	updateCartSummary();
	    }
	    
	    function updateCartSummary(){
	    	let nbArticles = Object.keys(cart).length;
	    	if(nbArticles == 0){
	    		cartSummary.html('');
	    		cartSummary.hide();
	    		return;
	    	}
	    	
	    	let str = "";
	    	str += "<div id='cart-summary' class='container'>";
	    	str += "<div class='row'>";
	    	str += "<div class='six columns'>";
	    	str += "<span class='container-title'>" + nbArticles + (nbArticles < 2 ? " vehicle:" : " vehicles:") + "</span>";
	    	str += "<ul class='container-list'>";
	    	let totalPrice = 0;
	    	for(c in cart){
	    		str += "<li>";
	    		str += vehicles[cart[c].vindex].manufacturer + " " + vehicles[cart[c].vindex].model + " " + vehicles[cart[c].vindex].year + ", " + nf(vehicles[cart[c].vindex].price, "", 2) + " EUR"; 
	    		str += "</li>";
	    		totalPrice += int(vehicles[cart[c].vindex].price);
	    	}
	    	str += "</ul>";
	    	str += "</div>";
	    	str += "<div class='six columns'>";
	    	str += "<span class='container-price'>" + "Total: " + nf(totalPrice, "", 2) + " EUR" + "</span>";
	    	str += "<br><br>";
  			str += "<button onclick='confirmCart()' class='btn btn-outline-info btn-lg'>";
  			str += "Proceed to Checkout";
			str += "</button>";
	    	str += "</div>";
	    	str += "</div>";
	    	str += "</div>";
	    	
	    	cartSummary.html(str);
	    	cartSummary.show();
	    }
	    
	    function confirmCart() {
	    	let v = [];
	    	for(c in cart){
	    		v.push(c);
	    	}
	    	
	    	post("<%= request.getContextPath() %>/shop", { vehicles: v } );
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


