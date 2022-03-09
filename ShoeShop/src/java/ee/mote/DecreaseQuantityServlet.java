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

/**
 *
 * @author fepit
 */

@WebServlet("/decreaseQuantity")
//@WebServlet(name = "compute", urlPatterns = {"/compute"})
public class DecreaseQuantityServlet extends HttpServlet{
    
    @Override
        protected void doGet(HttpServletRequest request,
                HttpServletResponse response)
                throws ServletException, IOException {
            
            String itemId = request.getParameter("itemId");
            int id = Integer.valueOf(itemId);
            
            HttpSession session = request.getSession();
            List<CartLine> cart = (List<CartLine>) session.getAttribute("cart");
            
            for(int i=0; i<cart.size(); i++){
                if(cart.get(i).getItemId()==id)
                {
                    if(cart.get(i).getQuantity()==1){
                        cart.remove(i);
                    }else{
                        cart.get(i).decreaseQty(1);
                    }
                }
            }
            
            session.setAttribute("cart",cart);
            RequestDispatcher rd = request.getRequestDispatcher("/cart");
            rd.forward(request, response);
            
        }
    
}
