/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDao;
import DAL.PostDAO;
import DAL.RestaurantDAO;
import Model.AccountDetail;
import Model.Post;
import Model.Restaurant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author DELL
 */
@WebServlet(name = "FeedServlet", urlPatterns = {"/Feed"})
public class FeedServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        PostDAO pd = new PostDAO();
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet FeedServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedServlet at " + pd.getNextFeedPosts(2, 0, getServletContext()).size() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //get all restaurant 
        RestaurantDAO rd = new RestaurantDAO();
        List<Restaurant> restaurants = rd.getAllRestaurant(getServletContext());
        request.setAttribute("restaurants", restaurants);

        //get following
        HttpSession session = request.getSession();
        AccountDetail sessionAccount = (AccountDetail) session.getAttribute("AccDetail");
        if (sessionAccount != null) {
            AccountDao acd = new AccountDao();
            List<AccountDetail> followingList = acd.getFollowingAccount(sessionAccount.getAccountId(), getServletContext());
            request.setAttribute("followingList", followingList);
        }

        //get posts
        PostDAO pd = new PostDAO();
        if (sessionAccount != null) {
            List<Post> posts = pd.getFeedPosts(sessionAccount.getAccountId(), getServletContext());
            Map<AccountDetail, Post> map = new LinkedHashMap<>();
            AccountDao ad = new AccountDao();
            for (Post p : posts) {
                map.put(ad.getAccountById(p.getAccountId(), getServletContext()), p);
            }
            
            if(pd.getAllFeedPosts(sessionAccount.getAccountId(), getServletContext()).size()<=10){
               request.setAttribute("notLoadMore", 1); 
            }
            
            request.setAttribute("postMap", map);
        }

        request.getRequestDispatcher("Feed.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
