/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ee.mote;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author fepit
 */

@WebServlet("/increaseQuantity")
//@WebServlet(name = "compute", urlPatterns = {"/compute"})
public class IncreaseQuantityServlet extends HttpServlet{
    
    @Override
        protected void doGet(HttpServletRequest request,
                HttpServletResponse response)
                throws ServletException, IOException {
            
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultset = null;
            
            String itemId = request.getParameter("itemId");
            int id = Integer.valueOf(itemId);
            
            HttpSession session = request.getSession();
            List<CartLine> cart = (List<CartLine>) session.getAttribute("cart");
            
            try{
                
                connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/shoeshop?allowPublicKeyRetrieval=true&serverTimezone=UTC",
                        "root", "xxxx");
                
                preparedStatement = connection.prepareStatement("SELECT * FROM shoes WHERE itemId = ?");
                preparedStatement.setInt(1, Integer.parseInt(itemId));
                resultset = preparedStatement.executeQuery();

                resultset.next();
                int stock = resultset.getInt("stock");
            
            for(int i=0; i<cart.size(); i++){
                if(cart.get(i).getItemId()==id)
                {
                    if(cart.get(i).getQuantity() < stock){
                        cart.get(i).increaseQty(1);
                    }
                }
            }
            
            }catch (SQLException ex) {
            
            request
                   .setAttribute("message",
                    "An error has occured. Please try again");

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
            
            session.setAttribute("cart",cart);
            RequestDispatcher rd = request.getRequestDispatcher("/cart");
            rd.forward(request, response);
        }
            
            
            
        }
    
}
