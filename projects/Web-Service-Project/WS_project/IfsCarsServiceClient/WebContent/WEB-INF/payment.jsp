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
		
		.container-body .form-control{
			font-size: 18px;
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
		
		.container-alert{
			font-size: 18px;
		}
	
	</style>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.10.2/p5.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.10.2/addons/p5.sound.min.js"></script>

</head>
<body>

		<% Vehicle shoppingCart[] = (Vehicle[])request.getAttribute("shoppingCart"); %>
		<% List<String> currencies = (List<String>)request.getAttribute("currencies"); %>
        <% String selectedCurrency = (String)request.getAttribute("selectedCurrency"); %>
        <% double exchangeRate = ((Double)request.getAttribute("exchangeRate")).doubleValue();%>
        
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
        	<span class="navtag-current navtag-medium">Payment</span>
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
		<div id="currency-container" class="container"> 
		</div>
		<div class="container">
			<div class="row">
				<div class="twelve columns">
					<div class="container-title">
						Payment information:
					</div>
						<div class="container-body">
						<div id="name-input">
						  <div class="form-row">
							  <div class="form-group col-md-6">
							    <label for="firstname">Name on card</label>
							    <input type="text" class="form-control" id="firstname" placeholder="First name">
							  </div>
							  <div class="form-group col-md-6">
							    <label for="lastname">&nbsp;</label>
							    <input type="text" class="form-control" id="lastname" placeholder="Last name">
							  </div>
						  </div>
						  </div>
						  <div id="card-input">
							  <div class="form-row">
								  <div class="form-group col-md-3">
									    <label for="cardnumber1">Card number</label>
									    <input type="text" class="form-control" id="cardnumber1" placeholder="XXXX">
								  </div>
								  <div class="form-group col-md-3">
									    <label for="cardnumber2">&nbsp;</label>
									    <input type="text" class="form-control" id="cardnumber2" placeholder="XXXX">
								  </div>
								  <div class="form-group col-md-3">
									    <label for="cardnumber3">&nbsp;</label>
									    <input type="text" class="form-control" id="cardnumber3" placeholder="XXXX">
								  </div>
								  <div class="form-group col-md-3">
									    <label for="cardnumber4">&nbsp;</label>
									    <input type="text" class="form-control" id="cardnumber4" placeholder="XXXX">
								  </div>
							  </div>
					      </div>
						  <div class="form-row">
							  <div id="cvv-input" class="form-group col-md-4">
								    <label for="cvv">CVV</label>
								    <input type="text" class="form-control" id="cvv" placeholder="123(4)">
							  </div>
							  <div class="form-group col-md-4">
						      <label for="inputmonth">Expiracy date</label>
						      <select id="inputmonth" class="form-control">
						        <option selected>January</option>
						        <option>February</option>
						        <option>March</option>
						        <option>April</option>
						        <option>May</option>
						        <option>June</option>
						        <option>July</option>
						        <option>August</option>
						        <option>September</option>
						        <option>October</option>
						        <option>November</option>
						        <option>December</option>
						      </select>
						    </div>
						    <div class="form-group col-md-4">
						      <label for="inputyear">&nbsp;</label>
						      <select id="inputyear" class="form-control">
						        <option selected>2021</option>
						        <option>2022</option>
						        <option>2023</option>
						        <option>2024</option>
						        <option>2025</option>
						        <option>2026</option>
						        <option>2027</option>
						        <option>2028</option>
						        <option>2029</option>
						        <option>2030</option>
						      </select>
						    </div>
						  </div>
						  	<button onclick="confirmPayment()" class="btn btn-outline-info btn-lg">
						  		Confirm and pay
						  	</button>
						</div>
				</div>
			</div>
		</div>
	</div>
	
	    <script>
	    
	    let cart = {};
	    let nbArticles;
	    let currencyList = [];
	    let currencyDropdown;
	    let totalPriceInEuros;
	    let exchangeRate;
	    let totalPrice;
	    let check = true;
	    
	    function setup(){
	    	
	    	<%for(int i = 0; i < shoppingCart.length; i++){%>
	    	cart[<%=i%>] = {
		    	"id": "<%=shoppingCart[i].getId()%>",
		    	"manufacturer": "<%=shoppingCart[i].getMake()%>",
		    	"model": "<%=shoppingCart[i].getModel()%>",
		    	"year": "<%=shoppingCart[i].getYear()%>",
		    	"price": "<%=shoppingCart[i].getPrice()%>"
		    };
    	<%}%>
    		
    		nbArticles = Object.keys(cart).length;
	    	
	    	exchangeRate = <%=exchangeRate%>;
	    	
	    	currencyDropdown = createSelect('');
	    	<%for(int i = 0; i < currencies.size(); i++){%>
	    		currencyList.push("<%=currencies.get(i)%>");
	    		currencyDropdown.option("<%=currencies.get(i)%>");
	    	<%}%>
	    	currencyDropdown.value("<%=selectedCurrency%>");
	    	currencyDropdown.changed(setCurrency);
	    	
	    	createCurrencyContainer()
			.parent(document.getElementById('currency-container'));
	    	
	    	currencyDropdown.parent(document.getElementById('currency-dropdown'));
    	}
	    
	    function draw(){
			noLoop();
	    }
	    
	    function createCartSummaryContainer(){
	    	let str = "";
	    	str += "<span class='container-title'>" + nbArticles + (nbArticles < 2 ? " vehicle:" : " vehicles:") + "</span>";
	    	str += "<ul class='container-list'>";
	    	totalPriceInEuros = 0;
	    	for(c in cart){
	    		str += "<li>";
	    		str += cart[c].manufacturer + " " + cart[c].model + " " + cart[c].year + ", " + nf(cart[c].price * exchangeRate, "", 2) + " " + currencyDropdown.value(); 
	    		str += "</li>";
	    		totalPriceInEuros += int(cart[c].price);
	    	}
	    	str += "</ul>";
	    	
	    	totalPrice = totalPriceInEuros * exchangeRate;
	    	return str;
	    }
	    
	    function createCurrencyContainer(){
	    	return createDiv(
					"<div class='row'>" + 
						"<div class='six columns'>" + 
							createCartSummaryContainer() +
						"</div>" +
						"<div class='six columns'>" + 
							"<span class='container-price'>" + "Total: " + nf(totalPrice, "", 2) + " " + currencyDropdown.value() + "</span>" + 
							"<div id='currency-dropdown'>" + 
								"<span class='container-body'>" + "Change currency: " + "</span>" + 
							"</div>" + 
							(currencyDropdown.value() === "EUR" ? 
									""
									:
									"<ul class='container-list'>" +
										"<li>" +
											"EUR to " + currencyDropdown.value() + " exchange rate: " + exchangeRate + 
										"</li>" + 
										"<li>" +
											"Total in EUR: " + nf(totalPriceInEuros, "", 2) + " EUR" + 
										"</li>" + 
									"</ul>"
							) +
						"</div>" +
					"</div>"
	    	);
	    }
	    
	    function setCurrency(){
	    	let a = "currency";
	    	let v = [];
	    	for(c in cart){
	    		v.push(cart[c].id);
	    	}
	    	
	    	post("<%= request.getContextPath() %>/payment", { action: a, vehicles: v, currency: currencyDropdown.value(), activeCurrencies: currencyList } );
	    }
	    
	    function isValidName(){
	    	if(!document.getElementById('firstname').value.length || !document.getElementById('lastname').value.length){
	    		return false;
	    	}
	    	return true;	
	    }
	    
	    function isValidCardNumber(){
	    	for(let i = 1; i <= 4; i++){
	    		let n = document.getElementById('cardnumber' + i).value;
	    		if(n.length != 4){
	    			return false;
	    		}
	    		for(let c = 0; c < 4; c++){
	    			charcode = n[c].charCodeAt(0);
	    			if(charcode < 48 || charcode > 57){
	    				return false;
	    			}
	    		}
	    	}
	    	return true;
	    }
	    
	    function isValidCvv(){
    		let n = document.getElementById('cvv').value;
    		if(n.length > 4 || n.length < 3){
    			return false;
    		}
    		for(let c = 0; c < n.length; c++){
    			charcode = n[c].charCodeAt(0);
    			if(charcode < 48 || charcode > 57){
    				return false;
    			}
    		}
    		return true;
	    }
	    
	    function createAlert(warning, msg){
	    	return createDiv(
	    			"<div class='alert alert-danger alert-dismissible fade show' role='alert'>" + 
	    				"<div class='container-alert'>" + 
		    				"<strong>" + warning + "</strong> " + msg + 
		    					"<button type='button' class='close' data-dismiss='alert' aria-label='Close'>" + 
		    					"<span aria-hidden='true'>&times;</span>" + 
		    				"</button>" + 
	    				"</div>" + 
	    			"</div>"
	    			);
	    }
	    
	    function confirmPayment() {
	    
	    /*type nocheck() in console skip validity check*/
	    if(check){
	    	if(!isValidName()){
	    		createAlert("Invalid Name!", "")
	    		.parent(document.getElementById('name-input'));
	    		return;
	    	}	    	
	    	
	    	if(!isValidCardNumber()){
	    		createAlert("Invalid Card Number!", "16 digits")
	    		.parent(document.getElementById('card-input'));
	    		return;
	    	}
	    	
	    	if(!isValidCvv()){
	    		createAlert("Invalid CVV!", "3 or 4 digits")
	    		.parent(document.getElementById('cvv-input'));
	    		return;
	    	}	
	    }
	    /**/
	    
	    	let name_ = document.getElementById('firstname').value + ";" + document.getElementById('lastname').value;
	    	let cardnumber_ = document.getElementById('cardnumber1').value + document.getElementById('cardnumber2').value + document.getElementById('cardnumber3').value + document.getElementById('cardnumber4').value;
	    	let cvv_ = document.getElementById('cvv').value; 
	    	let date_ = document.getElementById('inputmonth').value + ";" + document.getElementById('inputyear').value; 
	    	
	    	let a = "payment";
	    	let v = [];
	    	for(c in cart){
	    		v.push(cart[c].id);
	    	}
	    	
	    	post("<%= request.getContextPath() %>/payment", { action: a, vehicles: v, currency: currencyDropdown.value(), name: name_, cardnumber: cardnumber_, cvv: cvv_, expiracydate: date_, price: totalPrice } );
	    }
	    
	  	function nocheck(){
	  		check = false;
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


