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
        <title>Profile</title>
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
        
        <h1>Your Profile</h1>
        
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

    </body>
</html>