<%-- 
    Document   : changePassword
    Created on : 20 Jun, 2020, 1:30:43 PM
    Author     : fepit
--%>

<%@page import="ee.mote.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
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
        
        <h1>Change Password</h1>
        
        <font color="red">
                    <%=request.getAttribute("message")==null?"":request.getAttribute("message")%><br/>
            </font>
        
        <form name="changePassword" action="changePassword" method="post">
            Current Password: <input type="password" name="currentPassword" required/><br/>
            <br/>
            New Password: <input type="password" name="newPassword" required/><br/>
            Confirm New Password: <input type="password" name="confirmPassword" required/><br/>

            <input type="submit" value="Save"/>
        </form>
    </body>
</html>
