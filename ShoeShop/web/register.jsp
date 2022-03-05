<%-- 
    Document   : register
    Created on : 16 Jun, 2020, 4:33:56 PM
    Author     : fepit
--%>

<%@page import="ee.mote.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Registration Form</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="js/validation.js" type="text/javascript"></script>
    </head>
    <body>
        <% 
                Customer c = (Customer) session.getAttribute("customer");
            %>
        
        <div>
            <button style="float: left"><a href="index.jsp" ><b>Mõte Inc</b></a> </button>
             
            
            <% if(c == null){ %>
            
            <button style="float: left"><a href="register.jsp" >Register</a> </button>
            <button><a href="login.jsp" ><b>Login</b></a> </button>
            
            <% }else{ %>
            
            <form action="search" method="post" style="float: left">
                <input type="submit" value="Products"/>
            </form>
            <form action="cart" method="get" style="float: left">
                <input type="submit" value="Cart"/>
            </form> 
            <form action="profile" method="get" style="float: left">
                <input type="submit" value="Profile"/>
            </form> 
            <form action="logout" method="post">
                <input type="submit" value="Logout"/>
            </form>
            
            <% } %>
        </div>
        
        <h1>Registration Form</h1>
        
        <form name="customer" action="validate" method="post" onsubmit="return validateForm()">
            <font color="red">
                    <%=request.getAttribute("message")==null?"":request.getAttribute("message")%><br/>
            </font>
            
            Full Name*: <input type="text" name="fullName" required/><br/>
            Email*: <input type="email" name="email" required/><br/>
            Address line1*: <input type="text" name="address1" required/><br/>
            Address line2 : <input type="text" name="address2" /><br/>
            Postal Code*: <input type="text" name="postalCode" required/><br/>
            Mobile Number*: <input type="text" name="mobile" required/><br/>
            Password*: <input type="password" name="password" required/><br/>
            Confirm Password*: <input type="password" name="confirmPassword" required/><br/>

            <input type="submit" value="Register"/>
        </form>
    </body>
</html>
