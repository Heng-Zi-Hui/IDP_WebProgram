<%-- 
    Document   : index.jsp
    Created on : 22 Jun, 2020, 1:09:31 PM
    Author     : fepit
--%>

<%@page import="ee.mote.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        
        <% if(c == null){ %>
        <h1>Welcome to Mõte Inc!</h1>
        <% }else{ %>
        <h1>Welcome to Mõte Inc, <%=c.getFullName()%>!</h1>
        <% } %>
        
    </body>
</html>
