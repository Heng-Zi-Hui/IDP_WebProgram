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

@WebServlet("/addproduct")
public class AddToCartServlet extends HttpServlet{
    
    @Override
        protected void doPost(HttpServletRequest request,
                HttpServletResponse response)
                throws ServletException, IOException {
            
            
            String itemId = request.getParameter("productId");
            String size = request.getParameter("size");
            String qty = request.getParameter("quantity");
            int qtyToAdd = Integer.valueOf(qty);
            
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultset = null;
            
            HttpSession session = request.getSession();
            
            List<CartLine> cart = (List<CartLine>) session.getAttribute("cart");
            
            if(cart == null){
                cart = new ArrayList<>();
            }
            
            try{
                connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/shoeshop?allowPublicKeyRetrieval=true&serverTimezone=UTC",
                        "root", "xxxx");
                
                preparedStatement = connection.prepareStatement("SELECT * FROM shoes WHERE itemId = ?");
                preparedStatement.setInt(1, Integer.parseInt(itemId));
                resultset = preparedStatement.executeQuery();

                resultset.next();
                int id = resultset.getInt("itemId");
                int stock = resultset.getInt("stock");
                
                if(size.equals("empty"))
                {
                    request
                        .setAttribute("message",
                        "Shoe size is not selected");
                }
                else if(cart.isEmpty()==false)
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
                        if(cart.get(repeatIndex).getQuantity()==10)
                        {
                            request
                                   .setAttribute("message",
                                    "You can only order a maximum of 10 of each item");
                        }
                        else
                        {
                            if(cart.get(repeatIndex).getQuantity()+qtyToAdd > stock){
                                request
                                   .setAttribute("message",
                                    "There is only "+ stock +"of this item left");
                            }else{
                                cart.get(repeatIndex).increaseQty(qtyToAdd);

                                request
                                   .setAttribute("message",
                                    "Item successfully added to cart");
                            }
                            
                        }

                    }
                    else
                    {
                        if(qtyToAdd > stock){
                            request
                               .setAttribute("message",
                                "There is only "+ stock +"of this item left");
                        }else{
                            CartLine line = new CartLine();
                        line.setItemId(id);
                        line.setDescription(resultset.getString("itemDescription"));
                        line.setBrand(resultset.getString("brand"));
                        line.setQuantity(qtyToAdd);
                        line.setPrice(resultset.getFloat("price"));
                        line.setPoints(resultset.getInt("points"));
                        line.setSize(size);
                        line.setImageFile(resultset.getString("imageFile"));

                        cart.add(line);

                        request
                               .setAttribute("message",
                                "Item successfully added to cart");
                        }
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
                    line.setSize(size);

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
