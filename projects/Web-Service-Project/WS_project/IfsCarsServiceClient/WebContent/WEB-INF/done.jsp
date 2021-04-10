<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="ifscarsservice.Vehicle" %>
<%@ page import="java.util.List" %>

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
		
		#container-success{
			text-align: center;
		}
		
		#container-success .container-title{
			color: #679A7D;
		}
		
		#container-failure{
			text-align: center;
		}
		
		#container-failure .container-title{
			color: #F9665E;
		}
		
		#container-order{
			text-align: center;
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

	<% Vehicle shoppingCart[] = (Vehicle[])request.getAttribute("shoppingCart"); %> 
    <% String selectedCurrency = (String)request.getAttribute("selectedCurrency"); %>
    <% double exchangeRate = ((Double)request.getAttribute("exchangeRate")).doubleValue();%>
    <% boolean paiementSuccess = ((Boolean)request.getAttribute("paiementSuccess")).booleanValue(); %>    
    
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
        	<span class="navtag-medium">Shop</span>
        </a>
        <a class="nav-item nav-link disabled" href="#">
        	<span class="navtag-medium">Payment</span>
        </a>
        <a class="nav-item nav-link disabled" href="#">
        	<span class="navtag-current navtag-medium">Done</span>
        </a>
        </div>

        <div class="navbar-text ml-auto">
          <span class="navtag-medium">@AT, NG, RD</span>
        </div>
      </div>
    </nav>
	
	<div id="main" class="home">
	</div>
	
	    <script>
	    
	    let cart = {};
	    let nbArticles;
	    let totalPriceInEuros;
	    let currency;
	    let exchangeRate;
	    let totalPrice;
	    let success;
	    
	    function setup(){
	    	success = <%=paiementSuccess%>;
	    	
	    	if(success){
	    		createSuccessContainer()
				.parent(document.getElementById('main'));
	    	
	    	<%for(int i = 0; i < shoppingCart.length; i++){%>
	    	cart[<%=i%>] = {
		    	"id": "<%=shoppingCart[i].getId()%>",
		    	"manufacturer": "<%=shoppingCart[i].getMake()%>",
		    	"model": "<%=shoppingCart[i].getModel()%>",
		    	"year": "<%=shoppingCart[i].getYear()%>",
		    	"seatingcapacity": "<%=shoppingCart[i].getSeatingCapacity()%>",
		    	"fueltype": "<%=shoppingCart[i].getFuelType()%>",
		    	"transmission": "<%=shoppingCart[i].getTransmission()%>",
		    	"price": "<%=shoppingCart[i].getPrice()%>",
		    	"available": "<%=shoppingCart[i].isAvailableForSale()%>",
		    	"lastmessage": "<%=shoppingCart[i].getLastMessage()%>",
		    	"averagenote": "<%=shoppingCart[i].getAverageNote()%>",
		    	"imgurl": "<%=shoppingCart[i].getImgUrl()%>"
	    	};
    		<%}%>

	    		nbArticles = Object.keys(cart).length;
		    	
		    	exchangeRate = <%=exchangeRate%>;
		    	
		    	currency = "<%=selectedCurrency%>";
		    	
		    	createOrderSummary()
		    	.parent(document.getElementById('main'));
	    		
		    	createCurrencyContainer()
				.parent(document.getElementById('main'));
		    	
		    	for(let c in cart){
		    		createContainer(cart[c])
		    		.parent(document.getElementById('main'))
		    	}

	    	}else{
	    		createFailureContainer()
				.parent(document.getElementById('main'));	
	    	}
	    }
	    
	    function draw(){
			noLoop();
	    }
	    
	    function createSuccessContainer(){
	    	return createDiv(
	    			"<div id='container-success' class='container'>" +
		    			"<div class='row'>" +
		    				"<div class='twelve columns'>" +
		    					"<div class='container-title'>Your paiement was succesfull!</div>" +
		            				"<p class='container-body'>" +
		            				"Your bank has accepted the transaction. Please come and collect the vehicles at Eiffel Corp with a proof of ID. " +
		            				"Thank you for using Ifs Cars Service, drive safe!<br>" +
		            				"- Eiffel Corp" +
		            				"</p>" +
		    				"</div>" +
		    			"</div>" +
		    		"</div>"
	    	);
	    }
	    
	    function createFailureContainer(){
	    	return createDiv(
	    			"<div id='container-failure' class='container'>" +
		    			"<div class='row'>" +
		    				"<div class='twelve columns'>" +
		    					"<div class='container-title'>Something went wrong...</div>" +
		            				"<p class='container-body'>" +
		            				"Unfortunatly, the transaction was rejected. Contact your bank to check if you have sufficient funds. " +
		            				"Still, we hope to see you again soon!<br>" +
		            				"- Eiffel Corp" +
		            				"</p>" +
		    				"</div>" +
		    			"</div>" +
		    		"</div>"
	    	);
	    }
	    
	    function createOrderSummary(){
	    	return createDiv(
	    		"<div class='container'>" +
	    			"<div class='row'>" +
	    				"<div class='twelve columns'>" +
	    					"<div id='container-order' class='container-title'>- Order summary -</div>" +
	    				"</div>" +
	    			"</div>" +
	    		"</div>"
	    	);
	    }
	    
	    function createCartSummaryContainer(){
	    	let str = "";
	    	str += "<span class='container-title'>" + nbArticles + (nbArticles < 2 ? " vehicle:" : " vehicles:") + "</span>";
	    	str += "<ul class='container-list'>";
	    	totalPriceInEuros = 0;
	    	for(c in cart){
	    		str += "<li>";
	    		str += cart[c].manufacturer + " " + cart[c].model + " " + cart[c].year + ", " + nf(cart[c].price * exchangeRate, "", 2) + " " + currency; 
	    		str += "</li>";
	    		totalPriceInEuros += int(cart[c].price);
	    	}
	    	str += "</ul>";
	    	
	    	totalPrice = totalPriceInEuros * exchangeRate;
	    	return str;
	    }
	    
	    function createCurrencyContainer(){
	    	return createDiv(
	    			"<div class='container'>" +
						"<div class='row'>" + 
							"<div class='six columns'>" + 
								createCartSummaryContainer() +
							"</div>" +
							"<div class='six columns'>" + 
								"<span class='container-price'>" + "Total: " + nf(totalPrice, "", 2) + " " + currency + "</span>" + 
								(currency === "EUR" ? 
										""
										:
										"<ul class='container-list'>" +
											"<li>" +
												"EUR to " + currency + " exchange rate: " + exchangeRate + 
											"</li>" + 
											"<li>" +
												"Total in EUR: " + nf(totalPriceInEuros, "", 2) + " EUR" + 
											"</li>" + 
										"</ul>"
								) +
							"</div>" +
						"</div>" +
					"</div>"
	    	);
	    }
	    
	    function createContainer(v){
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
									nf(v.price * exchangeRate, "", 2) + " " + currency + "<br>" +
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
    				"</div>"
    		);
	    }
	    
	    function mousePressed(){
	    	gotoIndex();
	    }
	    
	    function gotoIndex() {
	    	post("<%= request.getContextPath() %>/done", {} );
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