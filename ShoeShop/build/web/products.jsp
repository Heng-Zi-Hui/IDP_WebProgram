<%-- 
    Document   : products
    Created on : 15 Jun, 2020, 2:15:07 PM
    Author     : fepit
--%>

<%@page import="ee.mote.Customer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ee.mote.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Products</title>
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
        
        <h1>Products</h1>
        <form action="search" method="Post">
            <p>
                Search:<input type="text" name="searchterm" required/>
                <input type="submit" value="Search"/><br/>
                
            </p>
        </form>
        <font color="red">
                    <%=request.getAttribute("message")==null?"":request.getAttribute("message")%><br/>
        </font>
            <table>
                <tr>
                    <td><b>Item Description</b></td>
                    <td><b>Brand</b></td>
                    <td><b>Price</b></td>
                    <td><b>Points</b></td>
                    <td></td>
                </tr>
                
                <% 
            List<Product> searchresult = (ArrayList<Product>) session.getAttribute("searchresult");
            
            if(searchresult == null || searchresult.size() <= 0){
            %>
            <tr><td colspan="5">(No result is found)</td></tr>
            <%
            }else{
                for(Product product:searchresult){
                %>
                <tr>
                    <td><%=product.getDescription()%></td>
                    <td><%=product.getBrand()%></td>
                    <td>$<%=product.getPrice()%></td>
                    <td><%=product.getPoints()%></td>
                    <td>
                        <form action="addproduct" method="post">
                            <input type="hidden" name="productId" value="<%=product.getItemId()%>"/>
                            <input type="submit" value="Add to Cart"/>
                        </form>
                    </td>
                </tr>
                <%
                }
                
            }
            %>
            
            </table>
        
        
    </body>
</html>
