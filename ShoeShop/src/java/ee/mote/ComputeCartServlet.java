/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ee.mote;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author fepit
 */

@WebServlet("/cart")
//@WebServlet(name = "compute", urlPatterns = {"/compute"})
public class ComputeCartServlet extends HttpServlet{
    
    @Override
        protected void doGet(HttpServletRequest request,
                HttpServletResponse response)
                throws ServletException, IOException {
            
            int totalPoints = 0;
            float totalPrice = 0;
            
            HttpSession session = request.getSession();
            List<CartLine> cart = (List<CartLine>) session.getAttribute("cart");
            
            if(cart != null)
            {
                for(int i=0; i<cart.size(); i++){
                    
                    totalPoints += cart.get(i).getQuantity() * cart.get(i).getPoints();
                    totalPrice += cart.get(i).getQuantity() * cart.get(i).getPrice();
                }
            }
            
            session.setAttribute("totalPoints", totalPoints);
            session.setAttribute("totalPrice", totalPrice);
            response.sendRedirect(this.getServletContext().getContextPath() + "/cart.jsp");
            
        }
    
}
