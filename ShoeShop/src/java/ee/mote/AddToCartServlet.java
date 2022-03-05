/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ee.mote;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 *
 * @author fepit
 */

@WebServlet("/addproduct")
public class AddToCartServlet extends HttpServlet{
    
    @Resource(name="jdbc/jed")
    private DataSource moteIncDB;
    
    @Override
        protected void doPost(HttpServletRequest request,
                HttpServletResponse response)
                throws ServletException, IOException {
            
            
            String itemId = request.getParameter("productId");
            
            
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultset = null;
            
            HttpSession session = request.getSession();
            
            List<CartLine> cart = (List<CartLine>) session.getAttribute("cart");
            
            if(cart == null){
                cart = new ArrayList<>();
            }
            
            try{
                connection = moteIncDB.getConnection();
                
                preparedStatement = connection.prepareStatement("SELECT * FROM item WHERE itemId = ?");
                preparedStatement.setInt(1, Integer.parseInt(itemId));
                resultset = preparedStatement.executeQuery();

                resultset.next();
                int id = resultset.getInt("itemId");
                
                if(cart.isEmpty()==false)
                {
                    boolean repeat = false;
                    int repeatIndex = -1;
                    for(int i=0; i<cart.size(); i++){
                        if(cart.get(i).getItemId()==id)
                        {
                            repeat = true;
                            repeatIndex = i;
                        }
                    }

                    if(repeat==true)
                    {
                        if(cart.get(repeatIndex).getQuantity()==50)
                        {
                            request
                                   .setAttribute("message",
                                    "You can only order a maximum of 50 of each item");
                        }
                        else
                        {
                            cart.get(repeatIndex).increaseQty();

                            request
                                   .setAttribute("message",
                                    "Item successfully added to cart");
                        }

                    }
                    else
                    {
                        CartLine line = new CartLine();
                        line.setItemId(id);
                        line.setDescription(resultset.getString("itemDescription"));
                        line.setBrand(resultset.getString("brand"));
                        line.setQuantity(1);
                        line.setPrice(resultset.getFloat("price"));
                        line.setPoints(resultset.getInt("points"));

                        cart.add(line);

                        request
                               .setAttribute("message",
                                "Item successfully added to cart");
                    }
                }
                else
                {
                    CartLine line = new CartLine();
                    line.setItemId(id);
                    line.setDescription(resultset.getString("itemDescription"));
                    line.setBrand(resultset.getString("brand"));
                    line.setQuantity(1);
                    line.setPrice(resultset.getFloat("price"));
                    line.setPoints(resultset.getInt("points"));

                    cart.add(line);
                    
                    request
                           .setAttribute("message",
                            "Item successfully added to cart");
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
            RequestDispatcher rd = request.getRequestDispatcher("/products.jsp");
            rd.forward(request, response);
        }
            
            
            
        }
    
}
