/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDao;
import DAL.PostDAO;
import Model.AccountDetail;
import Model.Post;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 *
 * @author DELL
 */
@WebServlet(name = "LoadMoreServlet", urlPatterns = {"/LoadMoreExplore"})
public class LoadMoreExploreServlet extends HttpServlet {

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
        
        String total = request.getParameter("total");

        List<Post> posts = pd.getNext9Posts(Integer.parseInt(total) ,getServletContext());
        Map<AccountDetail, Post> map = new LinkedHashMap<>();
        AccountDao ad = new AccountDao();
        for (Post p : posts) {
            map.put(ad.getAccountById(p.getAccountId(), getServletContext()), p);
        }

        PrintWriter out = response.getWriter();

        Set<AccountDetail> accounts = map.keySet();

        for (AccountDetail a : accounts) {
            out.println("<div class=\"feed\">\n"
                    + "                                    <a href=\"Profile?accountId=" + a.getAccountId() + "&page=1\" style=\"text-decoration: none; color: black\">\n"
                    + "                                    <div class=\"head\">\n"
                    + "                                        <div class=\"user\" style=\"display: flex; justify-content: center; align-items: center\">\n"
                    + "                                            <div class=\"profile-photo\">\n"
                    + "                                                <img src=\"" + a.getAvatarPath() + "\" alt=\"pic\">\n"
                    + "                                            </div>\n"
                    + "                                            <div class=\"info\">\n"
                    + "                                                <h6>" + a.getName() + "</h6>\n"
                    + "                                                <small>" + map.get(a).getFormattedDate() + "</small>\n"
                    + "                                            </div>\n"
                    + "                                        </div>\n"
                    + "\n"
                    + "                                    </div>\n"
                    + "\n"
                    + "                                    </a>\n"
                    + "\n"
                    + "                                    <a href=\"PostPage?postId=" + map.get(a).getPostId() + "\">\n"
                    + "                                        <div class=\"photo\">\n");

            if (map.get(a).getImagePaths().size()!=0) {

                out.println("                                            <c:if test=\"${" + map.get(a).getImagePaths().size() + "!=0}\">\n"
                        + "                                                <td><img src=\"" + map.get(a).getImagePaths().get(0) + "\" alt=\"alt\"/></td>\n"
                        + "                                                </c:if>\n");
            }
            out.println("                                        </div>\n"
                    + "                                    </a>    \n"
                    + "\n"
                    + "                                    <a href=\"PostPage?postId=" + map.get(a).getPostId() + "\" style=\"text-decoration: none; color: black\">\n"
                    + "                                        <div class=\"caption\">\n"
                    + "                                            <p><b>" + map.get(a).getTitle() + "</b> \n"
                    + "                                        </div>\n"
                    + "                                    </a> \n"
                    + "\n"
                    + "                                </div>");
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
