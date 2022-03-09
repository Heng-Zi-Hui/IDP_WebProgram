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

@WebServlet("/searchBy")
public class SearchProductsByServlet extends HttpServlet{
    
    @Override
        protected void doPost(HttpServletRequest request,
                HttpServletResponse response)
                throws ServletException, IOException {
            
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultset = null;
            List<Product> results = new ArrayList<Product>();
            
            String column = request.getParameter("by");
            String searchterm = request.getParameter("searchterm");
            String sqlSelect = "SELECT * FROM shoes WHERE ? LIKE ?";
            
            if(searchterm != null)
            {
                try {
            
            // Get the connection from the DataSource
            connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/shoeshop?allowPublicKeyRetrieval=true&serverTimezone=UTC",
                        "root", "xxxx");
            // Create a statement using the Connection
            statement = connection.prepareStatement(sqlSelect);
            
            statement.setString(1, column);
            statement.setString(2, "%" + searchterm + "%");
            // Make a query to the DB using ResultSet through the Statement
            resultset = statement.executeQuery();
            
            //resultset is like a pointer
            while(resultset.next()){
                //Create a book object
                Product product = new Product();
                //Pull out data from resultset put it in the book
                product.setItemId(resultset.getInt("itemId"));
                product.setDescription(resultset.getString("itemDescription"));
                product.setBrand(resultset.getString("brand"));
                product.setSex(resultset.getString("sex"));
                product.setCategory(resultset.getString("category"));
                product.setPrice(resultset.getFloat("price"));
                product.setPoints(resultset.getInt("points"));
                product.setImageFile(resultset.getString("imageFile"));
                product.setStock(resultset.getInt("stock"));
                
                results.add(product);
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(SearchProductsByServlet.class.getName()).log(Level.SEVERE, null, ex);
            ex.printStackTrace();
            System.err.println(ex.getMessage());
        } finally{
                
            if(resultset != null){
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SearchProductsByServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if(statement != null){
                try {
                    statement.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SearchProductsByServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if(connection != null){
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SearchProductsByServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            
        }
            }
            else
            {
                try {
            
            connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/shoeshop?allowPublicKeyRetrieval=true&serverTimezone=UTC",
                        "root", "xxxx");
            sqlSelect = "SELECT * FROM shoes";
            statement = connection.prepareStatement(sqlSelect);
            resultset = statement.executeQuery();
            
            //resultset is like a pointer
            while(resultset.next()){
                //Create a book object
                Product product = new Product();
                //Pull out data from resultset put it in the book
                product.setItemId(resultset.getInt("itemId"));
                product.setDescription(resultset.getString("itemDescription"));
                product.setBrand(resultset.getString("brand"));
                product.setSex(resultset.getString("sex"));
                product.setCategory(resultset.getString("category"));
                product.setPrice(resultset.getFloat("price"));
                product.setPoints(resultset.getInt("points"));
                product.setImageFile(resultset.getString("imageFile"));
                product.setStock(resultset.getInt("stock"));
                
                results.add(product);
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(SearchProductsByServlet.class.getName()).log(Level.SEVERE, null, ex);
            ex.printStackTrace();
            System.err.println(ex.getMessage());
        } finally{
                
            if(resultset != null){
                try {
                    resultset.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SearchProductsByServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if(statement != null){
                try {
                    statement.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SearchProductsByServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if(connection != null){
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(SearchProductsByServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            
        }
            }
            
            HttpSession session = request.getSession();
            session.setAttribute("searchresult", (Object) results);
            response.sendRedirect(this.getServletContext().getContextPath() + "/products.jsp");
            
        }
    
    
}
