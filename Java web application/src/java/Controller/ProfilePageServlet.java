/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDao;
import DAL.FollowUserDAO;
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
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author DELL
 */
@WebServlet(name = "ProfilePageServlet", urlPatterns = {"/Profile"})
public class ProfilePageServlet extends HttpServlet {

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

        String accountId = request.getParameter("accountId");
        AccountDao ad = new AccountDao();
        AccountDetail a = ad.getAccountById(Integer.parseInt(accountId), getServletContext());
        request.setAttribute("account", a);

        PostDAO pd = new PostDAO();
        List<Post> posts = pd.getPostsByAccountId(accountId, getServletContext());

        Map<AccountDetail, Post> map = new LinkedHashMap<>();
        for (Post p : posts) {
            map.put(a, p);
        }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProfilePageServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfilePageServlet at " + posts.size() + "</h1>");
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
        String page = request.getParameter("page");

        String message = request.getParameter("message");
        request.setAttribute("message", message);

        String accountId = request.getParameter("accountId");
        AccountDao ad = new AccountDao();
        AccountDetail a = ad.getAccountById(Integer.parseInt(accountId), getServletContext());
        request.setAttribute("account", a);

        //get following
        AccountDao acd = new AccountDao();
        List<AccountDetail> followingList = acd.getFollowingAccount(a.getAccountId(), getServletContext());
        request.setAttribute("followingList", followingList);
        
        //get follower
        List<AccountDetail> followerList = acd.getFollowersAccount(a.getAccountId(), getServletContext());
        request.setAttribute("followerList", followerList);
        
        
        

        HttpSession session = request.getSession();
        AccountDetail sessionAccount = (AccountDetail) session.getAttribute("AccDetail");

        FollowUserDAO fud = new FollowUserDAO();

        if (sessionAccount != null) {

            boolean checkFollow = fud.isFollow(Integer.parseInt(accountId), sessionAccount.getAccountId());
            request.setAttribute("checkFollow", checkFollow);
        }

        int numberOfPost = fud.countPost(a.getAccountId());
        request.setAttribute("numberOfPost", numberOfPost);

        int numberOfFollowing = fud.countFollowing(a.getAccountId());
        request.setAttribute("numberOfFollowing", numberOfFollowing);

        int numberOfFollower = fud.countFollower(a.getAccountId());
        request.setAttribute("numberOfFollower", numberOfFollower);

        if (page.equals("1")) {

            PostDAO pd = new PostDAO();
            List<Post> posts = pd.getPostsByAccountId(accountId, getServletContext());

            Map<AccountDetail, Post> map = new LinkedHashMap<>();
            for (Post p : posts) {
                map.put(ad.getAccountById(p.getAccountId(), getServletContext()), p);
            }
            request.setAttribute("postMap", map);

            request.getRequestDispatcher("profilePost.jsp").forward(request, response);
        } else if (page.equals("2")) {
            PostDAO pd = new PostDAO();
            List<Post> posts = pd.getSavedPosts(accountId, getServletContext());

            Map<AccountDetail, Post> map = new LinkedHashMap<>();
            for (Post p : posts) {
                map.put(ad.getAccountById(p.getAccountId(), getServletContext()), p);
            }
            request.setAttribute("postMap", map);

            request.getRequestDispatcher("profileSavedPost.jsp").forward(request, response);
        } else if (page.equals("3")) {

            RestaurantDAO rd = new RestaurantDAO();

            List<Restaurant> restaurants = rd.getRestaurantsByAccountId(accountId, getServletContext());

            request.setAttribute("restaurants", restaurants);

            request.getRequestDispatcher("profileRestaurant.jsp").forward(request, response);
        }
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
