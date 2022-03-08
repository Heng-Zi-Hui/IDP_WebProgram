<%-- 
    Document   : login
    Created on : 21 Jun, 2020, 2:50:25 PM
    Author     : fepit
--%>

<%@page import="ee.mote.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/login.css">
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <% 
                Customer c = (Customer) session.getAttribute("customer");
            %>
        
        <div class="navbar">
            <a href="index.jsp" >ZacZee's</a>
             
            
            <% if(c == null){ %>
            
            <a href="register.jsp" >Register</a>
            <a href="login.jsp" >Login</a>
            
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
        
        <h1>Login</h1>
        
        <font color="red">
                    <%=request.getAttribute("message")==null?"":request.getAttribute("message")%><br/>
        </font>
        
        <form name="customer" action="authenticate" method="post">
            <div class="container">
                <label for="email"><b>Email</b></label><br/>
                <input type="email" placeholder="Enter Email" name="email" required><br/>
                <label for="password"><b>Password</b></label><br/>
                <input type="password" placeholder="Enter Password" name="password" required><br/>
                <button type="submit">Login</button>
            </div>
        </form>
    </body>
</html>
