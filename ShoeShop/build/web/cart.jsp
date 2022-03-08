<%-- 
    Document   : cart
    Created on : 17 Jun, 2020, 10:15:32 PM
    Author     : fepit
--%>

<%@page import="ee.mote.Customer"%>
<%@page import="ee.mote.CartLine"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/master.css"> <%--Link to css--%>
        <link rel="icon" type="image/png" href="images/ZacZee's-logos_white.png"/> <%--Favicon--%>
        <title>Cart</title>
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
        
        <p>
            <form action="search" method="post">
                <input type="submit" value="Back to shopping"/>
            </form>
        </p>
        
        <h1>Your Cart</h1>
        
        <table>
                <tr>
                    <td><b>Item Description</b></td>
                    <td><b>Brand</b></td>
                    <td><b>Quantity</b></td>
                    <td><b>Price</b></td>
                    <td><b>Points</b></td>
                    <td></td>
                </tr>
                
                <% 
            List<CartLine> cart = (ArrayList<CartLine>) session.getAttribute("cart");
            
            if(cart == null || cart.size() <= 0){
            %>
            <tr><td colspan="5">(You have not added anything in your cart :/)</td></tr>
            <%
            }else{
                for(CartLine cartline:cart){
                %>
                <tr>
                    <td><%=cartline.getDescription()%></td>
                    <td><%=cartline.getBrand()%></td>
                    <td><%=cartline.getQuantity()%></td>
                    <td>$<%=cartline.getPrice()%></td>
                    <td><%=cartline.getPoints()%></td>
                </tr>
                <%
                }
                
            }
            %>
            </table>
        <p>
            Points You Would Receive: <b><%=session.getAttribute("totalPoints")%></b><br/>
            Total Cost: <b>$<%=session.getAttribute("totalPrice")%></b>
        </p>
        <p>
            <font color="red">
                    <%=request.getAttribute("message")==null?"":request.getAttribute("message")%><br/>
            </font>
            <form action="checkout" method="post">
                <input type="submit" value="Checkout"/>
            </form>
        </p>
    </body>
</html>
