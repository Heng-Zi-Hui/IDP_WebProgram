<%-- 
    Document   : profile
    Created on : 19 Jun, 2020, 3:40:04 PM
    Author     : fepit
--%>

<%@page import="ee.mote.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/master.css"> <%--Link to css--%>
        <link rel="icon" type="image/png" href="images/ZacZee's-logos_white.png"/> <%--Favicon--%>
        <title>Profile</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <% 
                Customer c = (Customer) session.getAttribute("customer");
            %>
        
        <div class="navbar">
            <a href="index.jsp" ><img src="images/ZacZee's-logo-nav.png" alt="ZacZee's" width="30" Height="30"/></a>
             
            
            <% if(c == null){ %>
            
            <a href="register.jsp" >Register</a>
            <a href="login.jsp" >Login</a>
            
            <% }else{ %>
            
            <form class="navForm" action="search" method="post" style="float: left">
                <input type="submit" value="Products"/>
            </form>
            <form class="navForm" action="cart" method="get" style="float: left">
                <input type="submit" value="Cart"/>
            </form> 
            <form class="navForm" action="profile" method="get" style="float: left">
                <input type="submit" value="Profile"/>
            </form> 
            <form class="navForm" action="logout" method="post">
                <input type="submit" value="Logout"/>
            </form>
            
            <% } %>
        </div>
        
        <br/><br/><br/>
        <h1>Your Profile</h1>
        <div class="textalignment">
            <img src="images/user.png" alt="user icon" width=50%/><br/>
            Full Name: <b><%=c.getFullName()%></b><br/>
            Email: <b><%=c.getEmail()%></b><br/>
            Address line1: <b><%=c.getAddress1()%></b><br/>
            Address line2: <b><%=c.getAddress2()==null?"-":c.getAddress2()%></b><br/>
            Postal Code: <b><%=c.getPostalCode()%></b><br/>
            Mobile Number: <b><%=c.getMobile()%></b><br/>
            <p>
                You Have <b><%=session.getAttribute("customerPoints")%></b> Points<br/>
            </p>
            <p>
                <button><a href="changePassword.jsp">Change Password</a></button>
            </p>
        </div>
    </body>
</html>
