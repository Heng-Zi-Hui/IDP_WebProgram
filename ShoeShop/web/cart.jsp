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
<%@page import="java.text.DecimalFormat" %>
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
                DecimalFormat dcf = new DecimalFormat("#0.00");
                request.setAttribute("dcf", dcf);
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
        <h1>Your Cart</h1>
        
        <%--
        <table>
                <tr>
                    <td><b>Item Description</b></td>
                    <td><b>Size(US)</b></td>
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
                    <td><%=cartline.getSize()%></td>
                    <td><%=cartline.getBrand()%></td>
                    <td><%=cartline.getQuantity()%></td>
                    <td>$<%=cartline.getPrice()%></td>
                    <td><%=cartline.getPoints()%></td>
                </tr>
                <%
                }
                
            }
            %>
            </table> --%>
        
        <div class="cartContainer">
        <% 
            List<CartLine> cart = (ArrayList<CartLine>) session.getAttribute("cart");
            
            if(cart == null || cart.size() <= 0){
            %>
            <p class="emptyCart">(You have not added anything in your cart :/)</p>
            <%
            }else{
                for(CartLine cartline:cart){
                %>
        
        
            <div class="Cart-Items">
                <div class="image-box">
                    <img src="images/<%=cartline.getImageFile()%>" height="120px" width="120px" />
                </div>
                <div class="about">
                    <h2 class="title"><%=cartline.getDescription()%></h2>
                    <h3 class="subtitle"><%=cartline.getBrand()%></<h3>
                    <h3 class="subtitle"><%=cartline.getSize()%></h3>
                </div>
                <div class="counter"></div>
                <div class="prices"></div>
                <div><%=cartline.getStock()%> in stock</div>
                <div class="counter">
                    <form action="decreaseQuantity" method="get">
                        <input type="hidden" name="itemId" value="<%=cartline.getItemId()%>"/>
                        <input class="btn" type="submit" value="-"/>
                    </form>
<!--                    <div class="btn">-</div>-->
                    <div class="count"><%=cartline.getQuantity()%></div>
<!--                    <div class="btn">+</div>-->
                    <form action="increaseQuantity" method="get">
                        <input type="hidden" name="itemId" value="<%=cartline.getItemId()%>"/>
                        <input class="btn" type="submit" value="+"/>
                    </form>
                </div>
                
                <div class="prices">
                    <div class="amount">$<%=dcf.format(cartline.getPrice())%></div>
<!--                    <div class="remove"><u>Remove</u></div>-->
                    <form action="removeCartLine" method="get">
                        <input type="hidden" name="itemId" value="<%=cartline.getItemId()%>"/>
                        <input class="remove" type="submit" value="Remove"/>
                    </form>
                </div>
                
            </div>
                    
            <%
                }
                
            }
            %>

            <hr> 
                <div class="checkout">
                    <div class="total">
                        <div>
                            <div class="Subtotal">Sub-Total</div>
                            <div class="items"><%=session.getAttribute("totalItems")%> items</div>
                            <div class="items"><%=session.getAttribute("totalPoints")%> points</div>
                        </div>
                        <div class="total-amount">$<%=dcf.format(session.getAttribute("totalPrice"))%></div>
                    </div>
                    <form action="checkout" method="post">
                        <input class="button" type="submit" value="Checkout"/>
                    </form>
                </div>
                </div>
    </body>
</html>
