/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDao;
import DAL.CommentDAO;
import DAL.PostDAO;
import Model.AccountDetail;
import Model.Comment;
import Model.Post;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author cuanl
 */
@WebServlet(name = "CommentServlet", urlPatterns = {"/comment"})
public class CommentServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CommentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CommentServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Nhận dữ liệu từ request parameters
        String postId = request.getParameter("postId");
        String accountId = request.getParameter("accountId");
        String text = request.getParameter("comment");

        CommentDAO cd = new CommentDAO();
        cd.insertComment(accountId, postId, text);
        Comment c = cd.getNewestComment();

        AccountDao ad = new AccountDao();
        AccountDetail a = ad.getAccountById(Integer.parseInt(accountId), getServletContext());
        String name = a.getName();

        String commentHtml = "<div class=\"comment\">\n"
                + "                                    <div class=\"d-flex\">\n"
                + "                                        <div class=\"img\">\n"
                + "                                            <img src=\"" + a.getAvatarPath() + "\" alt=\"\">\n"
                + "                                        </div>\n"
                + "                                        <div class=\"content\">\n"
                + "                                            <div class=\"person\">\n"
                + "                                                <h4>" + a.getName() + "</h4>\n"
                + "                                                <span>Vừa xong</span>\n"
                + "                                            </div>\n"
                + "                                            <p>" + c.getText() + "</p>\n"
                + "                                        </div>\n"
                + "                                    </div>\n"
                + "\n"
                + "                                    <div style=\"display: flex; justify-content: flex-end; align-items: center\">\n"
                + "\n"
                + "                                        <div class=\"like comment-like\" data-comment-id=\"" + c.getCommentId() + "\" onclick=\"toggleLike('" + c.getCommentId() + "')\">\n";

        if (c.getReactAccounts().contains(a.getAccountId())) {
            commentHtml += "<img class=\"loved\" src=\"./images/heart.png\" alt=\"Loved\" style=\"display: inline-block\">\n";
        } else {
            commentHtml += " <img class=\"not_loved\" src=\"./images/love.png\" alt=\"Not Loved\" style=\"display: inline-block\">";
        }

        commentHtml += "                                            <p>" + c.getReactAccounts().size() + "</p>\n"
                + "                                        </div>\n"
                + "\n";
                
        if (a.getAccountId() == c.getAccountId()) {
            commentHtml += "                                            <span class=\"edit\">\n"
                    + "                                                <i class=\"uil uil-trash-alt delete-comment\" data-comment-id=\"" + c.getCommentId() + "\" onclick=\"toggleDelete('"+ c.getCommentId() +"')\" style=\"cursor: pointer\"></i>\n"
                    + "\n"
                    + "                                            </span>\n";
        }
        
        
        commentHtml +="                                    </div>    \n"
                + "\n"
                + "                                </div>";

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(commentHtml);
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
