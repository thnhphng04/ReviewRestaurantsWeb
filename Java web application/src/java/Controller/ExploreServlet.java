/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDao;
import DAL.PostDAO;
import DAL.PostSavedDAO;
import DAL.RestaurantDAO;
import Model.AccountDetail;
import Model.Comment;
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
@WebServlet(name = "ExploreServlet", urlPatterns = {"/Explore"})
public class ExploreServlet extends HttpServlet {

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
        PostDAO pd = new PostDAO();

        List<Post> posts = pd.getTop9Posts(getServletContext());
        Map<AccountDetail, Post> map = new LinkedHashMap<>();
        AccountDao ad = new AccountDao();
        for (Post p : posts) {
            map.put(ad.getAccountById(p.getAccountId(), getServletContext()), p);
        }
        request.setAttribute("postMap", map);

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExploreServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExploreServlet at " + posts.size() + "</h1>");
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

        String message = request.getParameter("message");
        request.setAttribute("message", message);

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

        PostDAO pd = new PostDAO();

        String typeOfFood = request.getParameter("typeOfFood");
        String typeOfMeal = request.getParameter("typeOfMeal");

        if (typeOfFood != null) {
            List<Post> posts = pd.getPostsByTypeOfFood(getServletContext(), typeOfFood);
            Map<AccountDetail, Post> map = new LinkedHashMap<>();
            AccountDao ad = new AccountDao();
            for (Post p : posts) {
                map.put(ad.getAccountById(p.getAccountId(), getServletContext()), p);
            }
            request.setAttribute("notLoadMore", 1);
            request.setAttribute("postMap", map);
        } else if (typeOfMeal != null) {
            List<Post> posts = pd.getPostsByTypeOfMeal(getServletContext(), typeOfMeal);
            Map<AccountDetail, Post> map = new LinkedHashMap<>();
            AccountDao ad = new AccountDao();
            for (Post p : posts) {
                map.put(ad.getAccountById(p.getAccountId(), getServletContext()), p);
            }
            request.setAttribute("notLoadMore", 1);
            request.setAttribute("postMap", map);
        } else {
            List<Post> posts = pd.getTop9Posts(getServletContext());
            Map<AccountDetail, Post> map = new LinkedHashMap<>();
            AccountDao ad = new AccountDao();
            for (Post p : posts) {
                map.put(ad.getAccountById(p.getAccountId(), getServletContext()), p);
            }
            if (pd.getAllExplorePosts(getServletContext()).size() <= 9) {
                request.setAttribute("notLoadMore", 1);
            }

            request.setAttribute("postMap", map);
        }

        request.getRequestDispatcher("Explore.jsp").forward(request, response);

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
