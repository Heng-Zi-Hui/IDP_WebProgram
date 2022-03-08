/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ee.mote;


import java.util.Date;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.DriverManager;

/**
 *
 * @author fepit
 */

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet{
    
    @Override
        protected void doPost(HttpServletRequest request,
                HttpServletResponse response)
                throws ServletException, IOException {
            
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultset = null;
            
            
            HttpSession session = request.getSession();
            
            //retrieve customerId,orderPrice,orderPoints
            Customer customer = (Customer) session.getAttribute("customer");
            int customerId = customer.getId();
            String orderPrice = session.getAttribute("totalPrice").toString();
            String orderPoints = session.getAttribute("totalPoints").toString();
            //initialize timestamp
            Date date = new Date();
            Timestamp timeStamp = new Timestamp(date.getTime());
            timeStamp.setNanos(0);

            session.setAttribute("timeStamp", timeStamp);
            
            
            //retrieve cart from session
            List<CartLine> cart = (List<CartLine>) session.getAttribute("cart");
            
            if(cart != null && cart.isEmpty()==false)
            {
                //try
                //insert all 4 variables into "orders" table
                //insert orderID,itemId,quantity into "orderdetails" table
                
                try {
            
            // Get the connection from the DataSource
            connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/shoeshop?allowPublicKeyRetrieval=true&serverTimezone=UTC",
                        "root", "xxxx");
            //Set auto commit to false to control the transaction
            connection.setAutoCommit(false);
            // Create a statement using the Connection
            
            preparedStatement = connection.prepareStatement("INSERT INTO orders (customerid, orderprice, orderpoints, timestamp) "
                                                          + "VALUES(?, ?, ?, ?)");
            preparedStatement.setInt(1, customerId);
            preparedStatement.setFloat(2, Float.parseFloat(orderPrice));
            preparedStatement.setInt(3, Integer.parseInt(orderPoints));
            preparedStatement.setTimestamp(4, timeStamp);
            preparedStatement.executeUpdate();
            
            
            
            
            preparedStatement = connection.prepareStatement("SELECT orderid from orders where timestamp = ?");
            preparedStatement.setTimestamp(1, timeStamp);
            
            resultset = preparedStatement.executeQuery();
            resultset.next();
            int orderId = resultset.getInt(1);
            
                for (CartLine cartline : cart) {
                    preparedStatement = connection.prepareStatement("INSERT INTO orderdetails (orderid, itemid, quantity) "
                                                                  + "VALUES(?, ?, ?)");
                    preparedStatement.setInt(1, orderId);
                    preparedStatement.setInt(2, cartline.getItemId());
                    preparedStatement.setInt(3, cartline.getQuantity());
                    preparedStatement.executeUpdate();
                }
            connection.commit();
            cart.clear();
            
            session.setAttribute("cart",cart);
            session.setAttribute("orderPrice",orderPrice);
            session.setAttribute("orderPoints",orderPoints);
            session.setAttribute("totalPrice",0);
            session.setAttribute("totalPoints",0);
            response.sendRedirect(this.getServletContext().getContextPath() + "/orderPlaced.jsp");
            
        } catch (SQLException ex) {
            
            request
                   .setAttribute("message",
                    "An error has occured. Please try again");
            
            RequestDispatcher rd = request.getRequestDispatcher("/cart.jsp");
            rd.forward(request, response);

            try {
                //Roll back if there is an error
                connection.rollback();
            } catch (SQLException ex1) {
                ex1.printStackTrace();
                System.err.println(ex1.getMessage());
            }
            ex.printStackTrace();
            System.err.println(ex.getMessage());

        } finally{
                
            if(resultset != null){
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AddUserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if(preparedStatement != null){
                try {
                    preparedStatement.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AddUserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if(connection != null){
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AddUserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            
        }
                
            }
            else
            {
                request
                       .setAttribute("message",
                        "You do not have anything in your cart to checkout with");
                
                RequestDispatcher rd = request.getRequestDispatcher("/cart.jsp");
                rd.forward(request, response);
            }
            
            
            
            
            
        }
    
}
