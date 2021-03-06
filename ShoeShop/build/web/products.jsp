<%@page import="ee.mote.Customer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ee.mote.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/master.css">
        <link rel="icon" type="image/png" href="images/ZacZee's-logos_white.png"/> <%--Favicon--%>
        <title>Products</title> 
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
        <h1>Products</h1>
        <form action="search" method="Post">
            <p>
                <%--Search:<input type="text" name="searchterm" required/>
                <input type="submit" value="Search"/><br/>--%>
                <div class="searchField">
                <input type="text" placeholder="Search Item Name" name="searchterm"" required>
                <button class="searchBttn" type="submit" value="Search"/><img icon="search" src="images/search.ico" width="20px" height='20px'/></button><br/>
                </div>
            </p><br/><br/>
        </form>
        <div style="text-align: center">
            <br/><br/>
            <font color="red">
                        <%=request.getAttribute("message")==null?"":request.getAttribute("message")%><br/>
            </font>
        </div>
            <div class="outergrid">
            <% 
            List<Product> searchresult = (ArrayList<Product>) session.getAttribute("searchresult");
            
            if(searchresult == null || searchresult.size() <= 0){
            %>
            <tr><td colspan="5">(No result is found)</td></tr>
            <%
            }else{
                for(Product product:searchresult){
                %>
                
                    <div class="innergrid">
                        <div><img src="images/<%=product.getImageFile()%>" alt="product image"/></div>
                        <div><%=product.getDescription()%></div>
                        <div>$<%=dcf.format(product.getPrice())%></div>
                        <div>
                            <form action="addproduct" method="post">
                            <input type="hidden" name="productId" value="<%=product.getItemId()%>"/>
                            
                            <%
                                if(product.getStock()==0){
                            %>
                                <br/><br/>    
                                <%-- <input value="Out of Stock"/> --%>
                                <button class="outOfStock" disabled>-Out of Stock-</button>
                            <%
                                }else{
                            %>
                                        <select name="size">
                                        <option value="empty">size(US)</option>
                                        <% 
                                            if(product.getSex().equals("women")){
                                        %>
                                            <option value="W 5">W 5</option>
                                            <option value="W 6">W 6</option>
                                            <option value="W 7">W 7</option>
                                            <option value="W 8">W 8</option>
                                            <option value="W 9">W 9</option>
                                            <option value="W 10">W 10</option>
                                            <option value="W 11">W 11</option>
                                            <option value="W 12">W 12</option>
                                            <option value="W 13">W 13</option>
                                        <%
                                            }else if(product.getSex().equals("men")){
                                        %>
                                            <option value="M 3">M 3</option>
                                            <option value="M 4">M 4</option>
                                            <option value="M 5">M 5</option>
                                            <option value="M 6">M 6</option>
                                            <option value="M 7">M 7</option>
                                            <option value="M 8">M 8</option>
                                            <option value="M 9">M 9</option>
                                            <option value="M 10">M 10</option>
                                            <option value="M 11">M 11</option>
                                        <%
                                            }else if(product.getSex().equals("unisex")){
                                        %>
                                            <option value="M 3 | W 5">M 3 | W 5</option>
                                            <option value="M 4 | W 6">M 4 | W 6</option>
                                            <option value="M 5 | W 7">M 5 | W 7</option>
                                            <option value="M 6 | W 8">M 6 | W 8</option>
                                            <option value="M 7 | W 9">M 7 | W 9</option>
                                            <option value="M 8 | W 10">M 8 | W 10</option>
                                            <option value="M 9 | W 11">M 9 | W 11</option>
                                            <option value="M 10 | W 12">M 10 | W 12</option>
                                            <option value="M 11 | W 13">M 11 | W 13</option>
                                        <%
                                            }
                                        %>
                                    </select>
                                    <br/><br/>
                                    <%=product.getStock()%> in stock
                                    <br/><br/>
                                    <input type="submit" value="Add to Cart"/>
                            <%
                                }
                            %>
                            
                        </form>
                        </div>
                    </div>
                
                <%
                }
                
            }
            %>
            </div>
    </body>
</html>
