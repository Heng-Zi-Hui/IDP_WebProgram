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

@WebServlet("/removeCartLine")
public class RemoveFromCartServlet extends HttpServlet{
    
    @Override
        protected void doPost(HttpServletRequest request,
                HttpServletResponse response)
                throws ServletException, IOException {
            
            
            int itemId = Integer.valueOf(request.getParameter("productId"));
            
            HttpSession session = request.getSession();
            
            List<CartLine> cart = (List<CartLine>) session.getAttribute("cart");
            
                for(int i=0; i<cart.size(); i++){
                    if(cart.get(i).getItemId()==itemId)
                    {
                        cart.remove(i);
                    }
                }

            session.setAttribute("cart",cart);
            RequestDispatcher rd = request.getRequestDispatcher("/cart.jsp");
            rd.forward(request, response);
        }
         
}
